# VitePress-Butterfly 主题

基于VitePress和Element Plus的现代化文档主题，集成多种增强功能和视觉优化。

## ? 特性

- 基于 VitePress 1.6.3 + Vue 3 构建
- 集成 Element Plus 组件库
- 响应式布局和动态导航栏
- 自定义主题样式系统
- 内置文章卡片、标签云等组件
- 支持暗色/亮色主题切换
- SEO 友好配置
- 静态资源自动优化

## ? 快速开始

### 安装依赖
```bash
npm install
```
开发模式

```bash
npm run dev
```
构建生产版本
> 这将生成构建到docs目录，可以直接部署到GitHub Pages
>

```bash
npm run build:docs
```
## 配置指南
修改 .vitepress/config.mjs 进行主题配置：


```javascript
export default defineConfig({
  title: "站点标题",
  themeConfig: {
    // 导航菜单配置
    menuItems: [
      {
        label: '文档',
        icon: 'fa-regular fa-file',
        link: '/guide'
      }
    ],
    
    // 作者信息
    defaultauthor: '作者名称',
    
    // 社交链接
    socialLinks: [
      { 
        name: 'GitHub',
        icon: 'fa-brands fa-github',
        url: 'https://github.com/yourprofile'
      }
    ],
    
    // 页脚配置
    footer: {
      message: "备案信息",
      copyright: "Copyright ? 2024-present Your Name"
    }
  }
})
```
### 目录结构

```plainText
Blog/
├── .vitepress/
│   ├── theme/          # 主题组件
│   ├── config.mjs      # 站点配置
├── posts/             # Markdown文章
├── public/            # 静态资源
└── package.json       # 依赖配置
```
### 文章规范
在 posts 目录中创建 .md 文件：


```markdown
Apply
---
title: 文章标题
date: 2024-03-20
author: 作者
layout: home # 可选布局
---
```
贡献
欢迎贡献代码和反馈问题。