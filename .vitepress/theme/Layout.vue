<script setup>
import Starrysky from './components/Starrysky.vue';
// import 'element-plus/dist/index.css'
import { useData } from 'vitepress'
const { page, frontmatter, theme } = useData()
import navbar from './components/navbar.vue';
import Home from './components/Home.vue';
import NotFound from './components/NotFound.vue';
import { ref, onMounted, onUnmounted } from 'vue'
import postinfo from './components/postinfo.vue';
import profieldcard from './components/profieldcard.vue';
import tocCard from './components/toc-card.vue';
import articleCard from './components/article-card.vue';
import ArchivePage from './components/ArchivePage.vue';
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
    <keep-alive>
        <Starrysky />
    </keep-alive>
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
            <div class="homePage Page" v-if="frontmatter.layout === 'home'">
                <Home />
                <div class="content-container">

                    <div class="page-wrapper">
                        <div class="a-card vp-doc">
                            <Content />
                        </div>
                        <div class="vp-doc" v-for="post in posts" :key="post.link">
                            <articleCard :post="post" />
                        </div>
                    </div>
                    <div class="sidebar Page">
                        <div class="sidebar-stay">
                            <profieldcard name="57D02" :socialLinks="theme.socialLinks" :avatar="theme.avatar"
                                :position="theme.position" :bio="theme.bio" />
                            <div class="a-card vp-doc">
                                hh
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="docPage Page" v-else>
                <div id="post-info">
                    <postinfo :title="frontmatter.title"
                        :author="frontmatter?.author || theme?.defaultauthor || 'unknow'" :date="frontmatter.date" />
                </div>
                <div class="content-container">
                    <div class="page-wrapper">
                        <div class="a-card vp-doc">
                            <Content />
                        </div>
                    </div>
                    <div class="sidebar">

                        <profieldcard name="57D02" :socialLinks="theme.socialLinks" :avatar="theme.avatar"
                            :position="theme.position" :bio="theme.bio" />

                        <div class="sidebar-stay">
                            <tocCard :posts="posts" :currentUrl="page.relativePath" />
                            <div class="a-card" v-if="false">
                                <h3 class="outline-title">
                                    {{ frontmatter }}
                                </h3>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="footer-container" style="color: white;">
                    <el-tag size="small" type="success" effect="plain" round>
                        {{ theme.footer.copyright }}
                    </el-tag>
                    
                </div>
        </el-scrollbar>
    </div>
</template>
