<template>
    <div class="toc-card a-card">
        <i class="fas fa-columns" />
        <span class="toc-title" style="font-weight: 600;">目录导航</span>
        <el-scrollbar>
            <template v-if="currentPost?.headings?.length">
                <ul class="toc-list" style="max-height: 500px" :wrap-style="{ overflowX: 'hidden' }">
                    <li v-for="heading in currentPost.headings" :key="heading.anchor"
                        :class="[`toc-level-${heading.level}`, { active: currentAnchor === heading.anchor }]">
                        <a :href="getHeadingLink(heading)" class="toc-link"
                            @click.prevent="handleAnchorClick(heading.anchor)">
                            {{ heading.text }}
                        </a>
                    </li>
                </ul>
            </template>
            <div v-else class="empty-tip">暂无目录</div>
        </el-scrollbar>
    </div>
</template>

<script setup>
import { computed, ref, onMounted, onUnmounted } from 'vue'

// 通用工具函数
const normalizeLink = link => link.replace(/\.(md|html)$/, '')
const getScrollContainer = () => {
    if (typeof window === 'undefined') return null
    return document.querySelector('.el-scrollbar__wrap') || window
}
const props = defineProps({
    posts: Array,
    currentUrl: String
})

const currentAnchor = ref(typeof window !== 'undefined' ? decodeURIComponent(window.location.hash) : '')

const scrollContainer = ref(null)
let scrollTimer = null

// 计算属性
const normalizedUrl = computed(() => {
    try {
        const url = new URL(props.currentUrl, location.origin)
        return normalizeLink(decodeURIComponent(url.pathname)) // 新增解码处理
    } catch {
        return normalizeLink(decodeURIComponent(props.currentUrl.split('#')[0])) // 新增解码处理
    }
})

const currentPost = computed(() =>
    props.posts.find(post => normalizeLink(post.link) === normalizedUrl.value)
)

// console.log(currentPost)
// console.log(normalizedUrl)
// 锚点操作方法
const getHeadingLink = heading => `${normalizeLink(currentPost.value.link)}${heading.anchor}`

const handleAnchorClick = anchor => {
    currentAnchor.value = anchor
    history.replaceState(null, '', anchor)
    smoothScroll(anchor)
}

const smoothScroll = anchor => {
    if (!anchor || anchor === '#') return
    const decodedAnchor = decodeURIComponent(anchor)  // 添加解码
    const target = document.querySelector(decodedAnchor.startsWith('#')
        ? decodedAnchor
        : `#${decodedAnchor}`)
    if (!target) return

    const container = scrollContainer.value
    const headerOffset = document.querySelector('header')?.offsetHeight || 70
    const targetY = calculateScrollPosition(target, container) - headerOffset

    container.scrollTo?.({ top: targetY, behavior: 'smooth' }) || (container.scrollTop = targetY)
}

const calculateScrollPosition = (target, container) => {
    const targetRect = target.getBoundingClientRect()
    return container === window
        ? window.scrollY + targetRect.top
        : container.scrollTop + targetRect.top - container.getBoundingClientRect().top
}

// 自动锚点检测
const updateActiveAnchor = () => {
    clearTimeout(scrollTimer)
    scrollTimer = setTimeout(() => {
        if (!currentPost.value?.headings) return

        const anchors = currentPost.value.headings.map(h => `#${h.anchor.slice(1)}`)
        const closest = findClosestAnchor(anchors)

        if (closest && closest !== currentAnchor.value) {
            currentAnchor.value = closest
            history.replaceState(null, '', closest)
        }
    }, 150)
}

const findClosestAnchor = anchors => {
    const container = scrollContainer.value
    const scrollTop = container === window ? window.scrollY : container.scrollTop

    return anchors.reduce((closest, anchor) => {
        const element = document.querySelector(anchor)
        if (!element) return closest

        const position = calculateScrollPosition(element, container)
        const distance = Math.abs(position - scrollTop - 100) // 100px 顶部偏移

        return distance < (closest.distance ?? Infinity)
            ? { anchor, distance }
            : closest
    }, {}).anchor
}

const handleHashChange = e => {
    currentAnchor.value = decodeURIComponent(new URL(e.newURL).hash) // 解码新哈希
    smoothScroll(currentAnchor.value)
}

onMounted(() => {
    scrollContainer.value = getScrollContainer()
    scrollContainer.value.addEventListener('scroll', updateActiveAnchor)
    window.addEventListener('hashchange', handleHashChange)
    updateActiveAnchor()
})

onUnmounted(() => {
    scrollContainer.value?.removeEventListener('scroll', updateActiveAnchor)
    window.removeEventListener('hashchange', handleHashChange)
})
</script>

<style scoped>
.toc-card {
    width: 100%;
    right: 2rem;
    top: 6rem;
    border-radius: 8px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
    padding: 1rem;
    max-height: 80vh;
    overflow-y: hidden;
}

.toc-title {
    color: #2c3e50;
    font-size: 1.1rem;
    margin-bottom: 0.8rem;
    padding-bottom: 0.4rem;
    border-bottom: 1px solid #eee;
}

.toc-list {
    list-style: none;
    padding: 0;
    margin: 0;
}

li {
    border-radius: 5px;
    color: #666;
    text-decoration: none;
    display: block;
    padding: 6px;
    transition: all 0.2s;
    position: relative;
    transition:
        color 0.3s ease,
        transform 0.3s ease,
        padding-left 0.3s ease;

    &:hover {
        color: #42b983;
        transform: translateX(4px);
    }

    &.active {
        color: #fff;
        font-weight: 500;
        background-color: #6d6e6e;

        &::before {
            content: "";
            position: absolute;
            left: -8px;
            top: 50%;
            transform: translateY(-50%);
            width: 4px;
            height: 60%;
            background: #42b983;
            border-radius: 2px;
        }
    }
}

.toc-link.active::before {
    transition: height 0.3s ease;
}

/* 层级缩进 */
.toc-level-1 {
    padding-left: 0.5rem
}

.toc-level-2 {
    padding-left: 1.5rem
}

.toc-level-3 {
    padding-left: 2.5rem
}

.toc-level-4 {
    padding-left: 3.5rem
}

.toc-level-5 {
    padding-left: 4.5rem
}

.toc-level-6 {
    padding-left: 5.5rem
}

.empty-tip {
    color: #999;
    font-size: 0.9rem;
    text-align: center;
    padding: 1rem 0;
}
</style>