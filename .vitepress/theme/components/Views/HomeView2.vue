<template>
    <div style="display: flex;width: 100%;flex-direction: column;align-items: center;justify-content: center;">
        <div id="content-container" :style="{ maxWidth: isFocusMode ? 'none' : '1200px' }">
            <div id="page-wrapper">
                <div class="vp-doc" v-for="post in posts" :key="post.link">
                    <ArticleCard :post="post" />
                </div>
            </div>
            <div class="sidebar" v-if="showSidebar">
                    <slot name="sidebar-non-stay">
                        <ProfileCard/>
                    </slot>
                    <div class="sidebar-stay">
                        <slot name="sidebar-stay">
                            <div class="a-card"
                                style="height: 300px;display: flex;flex-direction: column;padding: 18px;">
                               {{ theme.sidebar }}
                            </div>
                        </slot>
                    </div>
                
            </div>
        </div>
    </div>

</template>
<script lang='ts' setup>
import { inject } from 'vue';
import { data as posts } from '../utils/posts.data.js'
import ArticleCard from '../default/ArticleCard.vue';
import ProfileCard from '../default/ProfileCard.vue';
import { useData } from 'vitepress'
import { pa } from 'element-plus/es/locales.mjs';
const { theme, frontmatter, page } = useData()

// 获取全局状态和方法
const isFocusMode = inject('isFocusMode')
const showSidebar = inject('showSidebar') 
</script>
<style lang="scss" scoped></style>