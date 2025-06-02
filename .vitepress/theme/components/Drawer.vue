<template>
    <el-collapse style="--el-fill-color-blank: transparent;--el-collapse-border-color:transparent;" accordion>
        <el-collapse v-model="activeName" style="--el-fill-color-blank: transparent;--el-collapse-border-color:transparent;" accordion>
            
            <el-collapse-item title="大纲" name="wz" v-if="menuToc &&(!frontmatter.layout || frontmatter.layout == 'doc')">
                <Toc style="height: 300px" v-if="activeName=='wz'"/>
            </el-collapse-item>

            <el-collapse-item v-for="(item, index) in menuItems" :title="item.label" :name="index">
                <el-scrollbar style="height: 300px;">
                    <div class="a-card" v-for="citem in item.children" @click="handleMenuClick(citem)">
                        <i :class="citem.icon"></i>
                        {{ citem.label }}
                    </div>
                </el-scrollbar>
            </el-collapse-item>
            
        </el-collapse>
    </el-collapse>
</template>
<script setup>
import { useData } from 'vitepress'
const { theme, frontmatter} = useData()
import { ref, onMounted, onUnmounted } from 'vue'
import Toc from './Toc.vue'
const {
    menuToc = true,
    menuItems = []
} = theme.value

const activeName = ref('0')

const handleMenuClick = (item) => {
    if (item.children?.length) {
        return
    }

    if (item.link) {
        // 生成完整路径
        const basePath = window.location.origin
        const fullPath = item.link.startsWith('/')
            ? `${basePath}${item.link}`
            : `${basePath}/${item.link}`

        if (item.link.startsWith('http')) {
            window.open(item.link, '_blank')
        }
        else {
            window.open(fullPath, '_blank') // 保持新标签页打开行为
        }
    }
}

</script>
<style scoped></style>