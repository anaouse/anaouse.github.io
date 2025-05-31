import { createContentLoader } from 'vitepress'
const contentLoaderConfig = {
    includeSrc: true,
    render: true,
    excerpt: true,
    transform(rawData) {
        return rawData.sort((a, b) => {
            return +new Date(b.frontmatter.date) - +new Date(a.frontmatter.date)
        }).map((page) => {
            // 摘要处理
            let excerpt = page.excerpt
            let textNum = 0
            if (true) {
                const plainText = page.src
                    .replace(/^---[\s\S]*?---/, '')
                    .replace(/(```[\s\S]*?```|#+\s+|\[.*?\]\(.*?\))/g, '')
                    .substring(0, 30)
                excerpt = plainText + (plainText.length >= 30 ? '......' : '')
                excerpt = excerpt.trim()
                textNum = page.src.length
            }
            return {
                title: page.frontmatter.title,
                date: page.frontmatter.date,
                link: page.url,
                excerpt: excerpt,
                tags: (page.frontmatter.tags?.split(/[,\s]+/) ?? []).map(tag => tag.trim()),
                categories: (page.frontmatter.categories?.split(',') ?? []).map(category => category.trim()),
                cover: page.frontmatter.cover || '' , 
                lastUpdated: page.lastUpdated || page.frontmatter.date || '',
                textNum
            }
        })
    }
}
// export const data = createContentLoader('posts/**/*.md', contentLoaderConfig)
export default createContentLoader('posts/**/*.md', contentLoaderConfig)