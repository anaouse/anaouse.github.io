import { readdir, stat as _stat, readFile } from 'fs/promises'
import { writeJSON } from 'fs-extra'
import { resolve } from 'path'
import { load } from 'js-yaml'
import moment from 'moment'
import { red } from 'chalk'

const articlePath = '../docs'
const excludeDirs = ['node_modules', '.vitepress', 'public']
const pagesPath = './.vitepress/pages.json'

/**
 * 获取需要处理的目录列表
 * 1. 读取 docs 目录下的所有条目
 * 2. 过滤掉排除目录（node_modules 等）
 * 3. 筛选出实际存在的目录
 */
const getTargetDirs = async () => {
  const allDirs = await readdir(articlePath)
  const dirsStatPromiseArr = []
  const dirsPathArr = []
  allDirs.forEach((dir) => {
    if (excludeDirs.includes(dir)) return
    const pathWay = resolve(articlePath, dir)
    dirsStatPromiseArr.push(_stat(pathWay))
    dirsPathArr.push(pathWay)
  })
  const dirsStat = await Promise.all(dirsStatPromiseArr)
  const targetDirs = []
  dirsStat.forEach((stat, index) => {
    if (stat.isDirectory()) {
      targetDirs.push(dirsPathArr[index])
    }
  })
  return targetDirs
}

/**
 * 递归获取指定路径下所有 .md 文件
 * @param {string} pathWay - 要扫描的目录路径
 * @returns {Promise<Array>} 包含所有 .md 文件绝对路径的数组
 */
const getAllMdFiles = async (pathWay) => {
  const mdFileArr = []
  const dirs = await readdir(pathWay)
  const statPromiseArr = []
  const dirsPathArr = []
  dirs.forEach((dir) => {
    statPromiseArr.push(_stat(resolve(pathWay, dir)))
    dirsPathArr.push(resolve(pathWay, dir))
  })
  const statArr = await Promise.all(statPromiseArr)
  for (let i = 0; i < statArr.length; i++) {
    if (statArr[i].isDirectory()) {
      mdFileArr.push(...(await getAllMdFiles(dirsPathArr[i])))
    } else {
      dirs[i].endsWith('.md') && mdFileArr.push(dirsPathArr[i])
    }
  }
  return mdFileArr
}

// 匹配 YAML frontmatter 的正则表达式（使用 dotall 模式匹配多行内容）
const yamlRegExp = /---(.*?)---/s

/**
 * 解析 Markdown 文件内容并提取元数据
 * @param {string} pathWay - 文件绝对路径
 * @returns {Promise<Object|boolean>} 包含元数据的对象（不符合条件返回 false）
 */
const getContent = async (pathWay) => {
  const content = await readFile(pathWay, 'utf-8')
  const yamlArr = yamlRegExp.exec(content)
  if (!yamlArr || !yamlArr[1]) return false
  const yamlObj = load(yamlArr[1])
  if (!yamlObj.date && !yamlObj.categories && !yamlObj.tags) return false
  yamlObj.link = pathWay.replace(resolve(articlePath), '').replaceAll('\\', '/').replace('.md', '')
  if (yamlObj.date) yamlObj.timestamp = moment(yamlObj.date).valueOf()
  return yamlObj
  // 解析逻辑说明：
  // 1. 必须包含 date/categories/tags 中的至少一个字段
  // 2. 自动生成文章链接路径（转换为 UNIX 风格路径）
  // 3. 将日期转换为时间戳用于排序
}

/**
 * 主函数：生成页面数据并写入 JSON 文件
 * 处理流程：
 * 1. 获取所有目标目录
 * 2. 递归查找所有 Markdown 文件
 * 3. 并行解析文件元数据
 * 4. 过滤有效数据并写入文件
 * @returns {Promise<Array>} 包含所有页面元数据的数组
 */
const getPages = async () => {
  console.log(red('正在解析 pages...'))
  const targetDirs = await getTargetDirs()
  const mdFilePromiseArr = []
  targetDirs.forEach((pathWay) => {
    mdFilePromiseArr.push(getAllMdFiles(pathWay))
  })
  let mdFileArr = await Promise.all(mdFilePromiseArr)
  mdFileArr = mdFileArr.flat(Infinity)
  const infoPromiseArr = []
  mdFileArr.forEach((filePath) => {
    infoPromiseArr.push(getContent(filePath))
  })
  const infoArr = await Promise.all(infoPromiseArr)
  const pages = []
  infoArr.forEach((info) => {
    if (!info) return
    pages.push(info)
  })
  await writeJSON(resolve(pagesPath, './pages.json'), pages)
  console.log(red('pages 解析完成, 开始构建'))
  return pages
}

export default getPages