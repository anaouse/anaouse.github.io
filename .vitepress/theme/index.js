// https://vitepress.dev/guide/custom-theme
import DefaultTheme from 'vitepress/theme'
import Layout from './Layout.vue'
import './style.css'
import ElementPlus from 'element-plus'
import './fontawesome/css/all.min.css'
/** @type {import('vitepress').Theme} */

export default {
  extends: DefaultTheme,
  Layout,
  enhanceApp({ app, router, siteData }) {
    app.use(ElementPlus)
  },
  markdown: {
    // 启用目录功能
    toc: {
      level: [2, 3, 4]
    }
  }
}
