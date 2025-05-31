<template>
    <el-switch v-model="isFocusMode" :active-action-icon="Moon" :inactive-action-icon="Sunny" />
</template>

<script setup lang="ts">
import { Sunny, Moon } from '@element-plus/icons-vue'
import { inject, } from 'vue'
const isFocusMode = inject('isFocusMode')


</script>
