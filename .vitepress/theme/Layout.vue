<script setup>
import { ref, onMounted, onUnmounted, nextTick } from 'vue'
import Starrysky from './components/Starrysky.vue';
import navbar from './components/navbar.vue';
import Home from './components/Home.vue';
import postinfo from './components/postinfo.vue';
import NotFound from './components/NotFound.vue';
import tocCard from './components/toc-card.vue';
import profieldcard from './components/profieldcard.vue';
import articleCard from './components/article-card.vue';
import moreFuc from './components/moreFuc.vue';
import { useData } from 'vitepress'

const { page, frontmatter, theme } = useData()
import { data as posts } from './utils/posts.data.js'
const isClient = typeof window !== 'undefined'
// 状态栏&滚动条设置
const scrollbarRef = ref()
const contentContainer = ref()
const showNavbar = ref(true)
const lastScrollY = ref(0)
const scrollingDown = ref(false)
const handleScroll = ({ scrollTop }) => {
    if (!isClient) return
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


onMounted(() => {
    if (!isClient) return
    nextTick(() => { // 等待 DOM 更新
        contentContainer.value = scrollbarRef.value?.wrapRef?.querySelector('.el-scrollbar__view')
    })
})

onUnmounted(() => {
    if (!isClient) return
    window.removeEventListener('scroll', optimizedScrollHandler)
})
</script>

<template>
    <keep-alive>
        <Starrysky />
    </keep-alive>
    <div class="main-layout">
        <div class="navbar-container" :class="{ 'nav-hidden': !showNavbar }">
            <navbar />
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
                        <profieldcard />
                        <div class="a-card vp-doc">
                            <moreFuc />
                        </div>
                        <div class="sidebar-stay">
                            <profieldcard />
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

                        <profieldcard />

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
            <div class="footer-container" style="color: white;margin-bottom: 250px;">
                <el-tag size="small" type="success" effect="plain" round>
                    {{ theme.footer.copyright }}
                </el-tag>
            </div>

        </el-scrollbar>
    </div>

</template>
