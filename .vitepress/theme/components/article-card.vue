<template>
    <div class="text">
        <a :href="props.link" class="article-link" style="text-decoration: none;">
            <h3 class="article-title" style=" color: #000;">{{ props.title }}</h3>
            <p class="article-excerpt" style="color: grey;">{{ props.excerpt.replace(/\r\n/g, ' ') }}</p>
            <i class="fa-light fa-calendar"></i>
            <time :datetime="props.date">{{ formattedDate }}</time>
            <span class="read-more">阅读全文 →</span>
        </a>
    </div>
</template>
<script setup>
import { computed } from 'vue'
const props = defineProps({
    title: {
        type: String,
        default: 'Untitled Article'
    },
    author: {
        type: String,
        default: 'Anonymous'
    },
    date: {
        type: String,
        default: '',
        validator: (value) => {
            if (!value) return true
            return !isNaN(Date.parse(value))
        }
    },
    link: {
        type: String,
        required: true
    },
    tags: {
        type: Array,
        default: () => []
    },
    categories: {
        type: Array,
        default: () => []
    },
    excerpt: {
        type: String,
        default: '' 
    }
})

const formattedDate = computed(() => {
    if (!props.date) return 'Unknown date'
    try {
        return new Date(props.date).toLocaleDateString('zh-CN', {
            year: 'numeric',
            month: 'long',
            day: 'numeric'
        })
    } catch {
        return 'Invalid date'
    }
})
</script>
<style></style>