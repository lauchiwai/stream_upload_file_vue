<template>
    <div class="container">
        <FileUpload />
    </div>
</template>

<script setup lang="ts">
import FileUpload from '@/components/FileUpload.vue';
</script>

<style scoped>
.container {
    width: 100vw;
    height: 100vh;
    padding: 100px;
    display: flex;
    align-items: center;
    flex-direction: column;
    background-color: gray;
}
</style>
