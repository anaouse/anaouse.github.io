// import DefaultTheme from 'vitepress/theme'
import 'element-plus/dist/index.css'
import 'element-plus/theme-chalk/display.css'
const cssModules = import.meta.glob('./css/*.css', { eager: true })
Object.values(cssModules).forEach(module => {
  if (module?.default) module = module.default
  if (typeof module === 'string') {
    const style = document.createElement('style')
    style.textContent = module
    document.head.appendChild(style)
  }
})

import Layout from './Layout.vue'
import ElementPlus from 'element-plus'
import './fontawesome/css/all.min.css'
export default {
  Layout,
  enhanceApp({ app, router, siteData }) {
    app.use(ElementPlus)
  },
}
