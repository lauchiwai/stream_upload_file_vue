<template>
    <div class="file-upload-container">
        <h1>串流上傳</h1>
        <input type="file" @change="handleFileUpload" />
        <button @click="uploadFile">上傳</button>

        <p v-if="uploadStatus">{{ uploadStatus }}</p>

        <!-- 顯示進度條 -->
        <div v-if="uploadProgress > 0">
            <progress :value="uploadProgress" max="100">{{ uploadProgress }}%</progress>
            <span>{{ uploadProgress }}%</span>
        </div>
    </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import axios from 'axios';

const file = ref<File | null>(null);
const url = import.meta.env.VITE_URL;
const uploadStatus = ref('');
const uploadProgress = ref<number>(0);  // 新增上傳進度狀態

// 處理檔案上傳
function handleFileUpload(event: any) {
    file.value = event.target.files[0];
}

// 上傳檔案
const uploadFile = async () => {
    if (!file.value) {
        uploadStatus.value = '請先選擇檔案';
        return;
    }

    try {
        const formData = new FormData();
        formData.append('file', file.value);
        formData.append('name', "haha");
        // 發送請求並監控進度
        const response = await axios.post(
            url + '/SteamUpload/UploadFile',
            formData,
            {
                headers: {
                    'Content-Type': 'multipart/form-data',
                },
                withCredentials: true,
                onUploadProgress: (progressEvent: any) => {
                    if (progressEvent.lengthComputable) {
                        uploadProgress.value = Math.round((progressEvent.loaded * 100) / progressEvent.total);
                    }
                },
            }
        );

        if (response.status === 200) {
            uploadStatus.value = '檔案上傳成功！';
        } else {
            uploadStatus.value = '上傳失敗';
        }
    } catch (error: any) {
        uploadStatus.value = '上傳出錯：' + error.message;
    }
}
</script>

<style scoped>
.file-upload-container{
    display: block;
    padding: 20px;
    border-radius: 5px;
    background-color: rgb(226, 223, 223);
    color: black;
}
</style>