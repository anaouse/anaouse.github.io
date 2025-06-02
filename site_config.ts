export default {
  // VitePress 站点基本配置,必填，允许留空
  site_name: "anaouse's blog",
  site_description: "wuwuuw",
  site_url: "/",
  author: 'anaouse',
  defaultFocusMode: false, // 是否默认开启焦点模式
  isDark: null, // 是否默认开启深色模式, null 则会跟随系统
  // 首页配置
  home: {
    mainTitle: "anaouse's blog",
    subTitles: ['我', '要','听歌', '看动漫'],//打字机效果的副标题，使用字符串列表
  },
  background: '/wallpaper/1.webp',
  pageSize: 8, //首页文章列表分页大小，默认为8


  // 侧边简介卡
  avatar: "http://p1.music.126.net/ACZbqR-2XlucBQMdcYDfkw==/109951170473559542.jpg?param=180y180", //头像地址
  name: 'anaouse',
  position: '个人博客',
  bio: '我是无敌玩耍高手',
  socialLinks: [
    {
      name: 'GitHub',
      icon: 'fa-brands fa-github',
      url: 'https://github.com/anaouse/'
    }
  ],
  footer: {
      message: '......',
      copyright: 'Copyright © 2025-present'
  },
  //菜单栏
  menuToc: true, //是否显示文章目录
  menuItems: [
    {
      label: '同学搞的按钮，不知道有啥用',
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
}