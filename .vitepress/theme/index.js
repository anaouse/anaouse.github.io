// https://vitepress.dev/guide/custom-theme
import Layout from './Layout.vue'
import ElementPlus from 'element-plus'
import 'element-plus/dist/index.css'
const cssModules = import.meta.glob('./css/*.css', { 
  eager: true,
  query: '?inline' // 使用 Vite 的内联模式
})

// 合并所有样式到单个 style 标签
const combinedCSS = Object.values(cssModules)
  .map(module => module.default)
  .join('')
const style = document.createElement('style')
style.textContent = combinedCSS
document.head.appendChild(style)
import './fontawesome/css/all.min.css'


/** @type {import('vitepress').Theme} */
export default {
  Layout,
  enhanceApp({ app, router, siteData }) {
    app.use(ElementPlus)
  }
}

