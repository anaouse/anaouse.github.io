<template>
    <el-collapse accordion>
        <el-collapse v-model="activeName" accordion>
            <el-collapse-item v-for="(item, index) in menuItems" :title="item.label" :name="index">

                <div class="a-card" v-for="citem in item.children" @click="handleMenuClick(citem)">

                    <i :class="citem.icon"></i>
                    {{ citem.label }}

                </div>
            </el-collapse-item>
        </el-collapse>
    </el-collapse>
</template>
<script setup>
import { useData } from 'vitepress'
const { theme } = useData()
const {
    menuItems = [
        {
            label: '更多',
            icon: 'fa-solid fa-list',
            children: [
                {
                    key: 'action1',
                    label: 'action1',
                    icon: 'fa-solid fa-circle',
                    link: 'website'
                },
                {
                    key: 'action2',
                    label: 'Action 2',
                    icon: 'fa-solid fa-square',
                    link: 'index'
                },
                {
                    key: 'action3',
                    label: 'Action 3',
                    icon: 'fa-solid fa-star',
                    link: 'website'
                }
            ]
        }
    ]
} = theme.value

import { ref } from 'vue'

const activeName = ref('1')

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
<style>
:root {
    --el-fill-color-blank: transparent;
}
</style>