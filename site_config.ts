import ThemeConfig  from "./.vitepress/theme/ts/ThemeConfig";
// 使用typescript类型检查
const config: ThemeConfig = {
  // VitePress 站点基本配置
  site_name: "anaouse'blog",
  site_description: "这是一个使用 VitePress 构建的文档站点。",
  site_url: "/",
  author: 'anaouse',
  defaultFocusMode: true, // 是否默认开启焦点模式
  isDark: null, // 是否默认开启深色模式, null 则会跟随系统

  // 首页配置
  home: {
    mainTitle: "My Awesome Site",
    subTitles: ['我要', '听音乐', '看动漫'],//打字机效果的副标题，使用字符串列表
    firstViewHeight: 60, //首页第一屏的高度，默认为100vh
  },
  pageSize: 8, //首页文章列表分页大小，默认为8
  sortedMethor : 'date', //排序方式，默认为lastUpdated，可选值为lastUpdated、date
  
  // 背景
  background: '/wallpaper/1.webp',
  bg_rainfall: true, //是否开启背景雨

  // 最后更新时间相关选项
  lastUpdated: {
    use: true, // 是否开启最后更新时间
    text: '', // 最后更新时间的文本
  },

  // 侧边简介卡
  avatar: "/wallpaper/anaouse.jpg", //头像地址
  name: 'anaouse',
  position: '博客当作笔记本以及记录日常',
  bio: 'wuwuwuwuwuu',
  socialLinks: [
    {
      name: 'GitHub',
      icon: 'fa-brands fa-github',
      url: 'https://github.com/anaouse/'
    }
  ],
  footer: {
    message: '......',
    copyright: 'Copyright © 2025-present My Awesome Site'
  },
  //菜单栏
  menuToc: true, //是否显示文章目录
  menuItems: [
    {
      label: '同学搞得按钮',
      icon: 'fa-solid fa-browser',
      children: [
        {
          key: 'action1',
          label: '课程平台青春版',
          icon: 'fa-solid fa-browser',
          link: 'https://course.bjtu.top'
        },
        
      ]
    },
    {
      label: '更多',
      icon: '',
      children: [
        {
          key: 'action1',
          label: '标签',
          icon: 'fa-solid fa-tags',
          link: '/Tags/'
        },
      ]
    },
  ],
};



export default config;