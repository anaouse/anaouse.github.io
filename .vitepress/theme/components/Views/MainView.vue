<template>
    <template v-if="frontmatter.layout === 'home'">
        <content />
    </template>
    <template v-else-if="frontmatter.layout === 'page'">
        <content />
    </template>
    <template v-else>
        <div style="display: flex;flex-direction: column;align-items: center;">
            <DocView>
                <template #doc-header>
                    <PostInfo />
                </template>
                <template #main-content>
                    <content class="vp-doc fade-item" style="overflow-x: hidden;padding: 38px 30px 20px;" :class="{ 'a-card': !isFocusMode }" />
                </template>
                <template #sidebar-non-stay>
                    <ProfileCard />
                </template>
                <template #sidebar-stay>
                    <Toc class="a-card" style="height: 300px;display: flex;flex-direction: column;padding: 18px;" v-if="!isFocusMode"/>
                    <Toc v-else/>
                </template>
            </DocView>
        </div>

    </template>
</template>
<script lang='ts' setup>
import { useData } from 'vitepress'
import { computed, inject } from 'vue'
import DocView from './DocView.vue'
import Toc from '../Toc.vue'
import ProfileCard from '../default/ProfileCard.vue'
import PostInfo from '../default/PostInfo.vue'
const data = useData()
const frontmatter = computed(() => data.frontmatter.value)
const isFocusMode = inject('isFocusMode')
</script>
<style lang="scss" scoped>

</style>