<script setup>
import 'element-plus/dist/index.css'
import { useData } from 'vitepress'
const { page, frontmatter, theme } = useData()
import navbar from './components/navbar.vue';
import Home from './components/Home.vue';
import NotFound from './components/NotFound.vue';
import { ref, onMounted, onUnmounted } from 'vue'
import postinfo from './components/postinfo.vue';
import profieldcard from './components/profieldcard.vue';
import tocCard from './components/toc-card.vue';
import { data as posts } from './utils/posts.data.js'
// 状态栏&滚动条设置
const scrollbarRef = ref()
const contentContainer = ref()
const showNavbar = ref(true)
const lastScrollY = ref(0)
const scrollingDown = ref(false)

const handleScroll = ({ scrollTop }) => {
    const currentY = scrollTop
    const windowHeight = scrollbarRef.value?.wrapRef?.clientHeight || 0
    scrollingDown.value = currentY > lastScrollY.value
    if (currentY < 100) {
        showNavbar.value = true
    } else if (scrollingDown.value) {
        showNavbar.value = false
    } else {
        showNavbar.value = true
    }
    const documentHeight = contentContainer.value?.scrollHeight || 0
    if (currentY + windowHeight >= documentHeight - 100) {
        showNavbar.value = true
    }
    lastScrollY.value = currentY
}
// 使用被动事件监听器优化性能
let rafId

onMounted(() => {
    contentContainer.value = scrollbarRef.value?.wrapRef?.querySelector('.el-scrollbar__view')
})

onUnmounted(() => {
    window.removeEventListener('scroll', optimizedScrollHandler)
    if (rafId) cancelAnimationFrame(rafId)
})
</script>

<template>
    <div class="main-layout">
        <div class="navbar-container" :class="{ 'nav-hidden': !showNavbar }">
            <navbar :logo="theme.logo" :title="theme.title" :menuItems="theme.menuItems" />
        </div>
        <NotFound v-if="page.isNotFound" />
        <div class="nullpage" v-else-if="frontmatter.layout === 'customPage'">
            <Content />
        </div>
        <el-scrollbar ref="scrollbarRef" height="100vh" @scroll="handleScroll" :wrap-style="{ overflowX: 'hidden' }"
            v-else>
            <Home v-if="frontmatter.layout === 'home'" />
            <div class="content-container" v-if="frontmatter.layout === 'home'">
                <div class="page-wrapper">
                    <div class="page-card vp-doc" style="background-color: transparent;padding-top: 0%;">
                        <div v-for="post in posts" :key="post.link" class="article-card">
                            <div class="text">
                                <a :href="post.link" class="article-link">
                                    <h3 class="article-title">{{ post.title }}</h3>
                                    <p class="article-excerpt">{{ post.excerpt.replace(/\r\n/g, ' ') }}</p>
                                    <span class="read-more">阅读全文 →</span>
                                </a>
                            </div>
                            <div class="image">
                                <img :src="post.cover" :alt="post.cover">
                            </div>
                        </div>
                    </div>

                    <div class="sidebar">
                        <div class="sidebar-stay">
                            <profieldcard name="57D02" :socialLinks="theme.socialLinks" :avatar="theme.avatar"
                            :position="theme.position" :bio="theme.bio" />
                        </div>
                    </div>
                </div>
            </div>
            <div class="content-container" v-else>
                <div id="post-info">
                    <postinfo :title="frontmatter.title"
                        :author="frontmatter?.author || theme?.defaultauthor || 'unknow'" :date="frontmatter.date" />
                </div>
                <div class="page-wrapper">
                    <div class="page-card vp-doc">
                        <Content />
                    </div>
                    <div class="sidebar">
                        <profieldcard name="57D02" :socialLinks="theme.socialLinks" :avatar="theme.avatar"
                            :position="theme.position" :bio="theme.bio" />
                        <div class="sidebar-stay">
                            <tocCard :posts="posts" :currentUrl="page.relativePath" />
                            <div class="sidebar-card" v-if="false">
                                <h3 class="outline-title">
                                    {{ frontmatter }}
                                </h3>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="footer-container" style="color: white;">
                <Badge type="tip">{{ theme.footer.copyright }}</Badge>
            </div>
        </el-scrollbar>

    </div>
</template>

<style>
.main-layout {
    position: relative;
    height: 100vh;
}

.main-layout::before {
    content: '';
    position: fixed;
    top: 0;
    left: 0;
    width: 100vw;
    height: 100vh;
    background-image: url('/image/bg.webp');
    background-repeat: no-repeat;
    background-position: center;
    background-size: cover;
    z-index: -1;

}

.navbar-container {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    z-index: 1000;
    transition:
        transform 0.3s cubic-bezier(0.4, 0, 0.2, 1),
        box-shadow 0.3s ease;
}

.nav-hidden {
    transform: translateY(-100%);
    box-shadow: none !important;
}

.page-wrapper {
    padding-left: 5px;
    display: flex;
    justify-content: center;
    margin: 0 auto;
    max-width: 1111px;
    min-width: 500px;
    position: relative;
}

.page-card {
    background-color: white;
    padding: 35px;
    border-radius: 8px;
    width: 100%;
    transition: width 0.3s ease;

}

.article-card {
    background: rgba(255, 255, 255, 0.9);
    border-radius: 12px;
    padding: 2rem;
    transition: all 0.3s ease;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
    margin-bottom: 10px;
    
}

.article-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 12px 20px rgba(0, 0, 0, 0.1);
}

.sidebar {
    padding-right: 5px;
    position: absolute;
    right: -220px;
    /* 初始位置在可视区域外 */
    top: 0;
    width: 300px;
    opacity: 0;
    transform: translateX(20px);
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    visibility: hidden;
    display: flex;
    flex-direction: column;
    gap: 20px;
}

:root {
    --nav-height: 64px;
}

.sidebar-stay {
    position: sticky;
    top: calc(var(--nav-height) + 20px);
    margin-bottom: 40px;
    /* 保留滚动缓冲空间 */
    transition:
        top 0.3s cubic-bezier(0.4, 0, 0.2, 1),
        transform 0.3s ease;
    will-change: top;
    z-index: 50;
}

.nav-hidden~.el-scrollbar .sidebar-stay {
    --nav-height: 0px;
    top: 20px;
    /* 仅保留安全间距 */
}

.sidebar-card {
    background-color: white;
    padding: 10px;
    border-radius: 8px;
    width: 300px;
}

@media (min-width: 768px) {
    .sidebar {
        position: static;
        /* 重置定位 */
        transform: translateX(0);
        opacity: 1;
        visibility: visible;
        margin-left: 20px;
        right: auto;
        width: auto;
        min-width: 200px;
    }

    .page-card {
        width: calc(100% - 220px);
        /* 保持内容区域稳定宽度 */
    }
}

#post-info {
    height: 500px;
    display: flex;
    /* 垂直居中 */
    align-items: center;
    /* 水平居中 */
    justify-content: center;
    flex-direction: column;
}

.footer-container {
    display: flex;
    /* 垂直居中 */
    align-items: center;
    padding-top: 50px;
    flex-direction: column;
}

/* 添加以下样式覆盖默认设置 */
#post-info h1 {
    font-size: 2.5rem !important;
    color: wheat !important;
    margin: 0;
    text-align: center;
}
.text a{
    text-decoration: none;
    color: #000;
}
</style>
