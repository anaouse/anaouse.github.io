// https://vitepress.dev/guide/custom-theme
import DefaultTheme from 'vitepress/theme'
import Layout from './Layout.vue'
import './style.css'
import ElementPlus from 'element-plus'
import './fontawesome/css/all.min.css'
/** @type {import('vitepress').Theme} */

export default {
  Layout,
  enhanceApp({ app, router, siteData }) {
    app.use(ElementPlus)
  },
}
