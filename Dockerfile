# Node.js 18 LTS 버전 사용
FROM node:18-alpine

# 작업 디렉토리 생성
WORKDIR /app

# package.json과 package-lock.json 복사
COPY package*.json ./

# 프로덕션 의존성만 설치
RUN npm ci --only=production

# PM2 전역 설치
RUN npm install -g pm2

# 소스 코드 복사
COPY . .

# Prisma 생성
RUN npx prisma generate

# 포트 설정
EXPOSE 3000

# 환경변수 설정을 위한 준비
ENV NODE_ENV=production \
    PORT=3000

# PM2로 애플리케이션 실행
CMD ["pm2-runtime", "start", "src/app.js", "-i", "max"]
