# 使用 Node.js 的官方映像，這裡選擇較小的 alpine 版本
FROM node:18-alpine

# 設置工作目錄
WORKDIR /streamTest

# 將 package.json 和 package-lock.json 複製到工作目錄
COPY package*.json ./

# 安裝應用程式的依賴
RUN npm install

# 將當前目錄下的所有文件複製到容器中的 /app 目錄
COPY . .

# 手動將 .env.dev 的變數設定為 Docker 環境變數
# 例如 .env.dev 中的 VITE_URL=https://localhost:7034/api
ENV VITE_URL=http://localhost:7034/api

# 開放 5173 端口（Vue 預設開發伺服器的端口）
EXPOSE 5173

# 設置開發模式並啟動應用
CMD ["npm", "run", "dev"]
