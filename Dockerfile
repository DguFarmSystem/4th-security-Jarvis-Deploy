# 1단계: 프론트엔드 빌드
FROM node:18 AS fe-builder

WORKDIR /app
COPY 4th-security-Jarvis-FE ./4th-security-Jarvis-FE
WORKDIR /app/4th-security-Jarvis-FE

RUN npm install --legacy-peer-deps
RUN npm run build

# 2단계: 백엔드 빌드
FROM golang:1.25-alpine AS be-builder

WORKDIR /app
ENV CGO_ENABLED=0 GOOS=linux

# 소스 복사 및 빌드
COPY 4th-security-Jarvis-BE ./4th-security-Jarvis-BE
WORKDIR /app/4th-security-Jarvis-BE
RUN go mod download
RUN go build -o backend ./main.go

# 3단계: 최종 실행 이미지
FROM debian:bullseye-slim

# Node.js + 필수 패키지 설치
RUN apt-get update && apt-get install -y curl ca-certificates gnupg && \
    curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g serve && \
    rm -rf /var/lib/apt/lists/*

# Teleport 바이너리 다운로드
RUN curl -sSL https://cdn.teleport.dev/teleport-v13.3.4-linux-amd64-bin.tar.gz | tar -xz && \
    mv teleport/teleport /usr/local/bin/teleport && \
    chmod +x /usr/local/bin/teleport

# Teleport 설정 복사
COPY teleport.yaml /etc/teleport/teleport.yaml

# 백엔드 복사
COPY --from=be-builder /app/4th-security-Jarvis-BE/backend /usr/local/bin/backend

# 프론트엔드 빌드 결과 복사
COPY --from=fe-builder /app/4th-security-Jarvis-FE/dist /app/frontend

# 포트 노출
EXPOSE 3000 8080 3025

# ENTRYPOINT: 모든 서비스 실행
ENTRYPOINT sh -c "\
  teleport start --config=/etc/teleport/teleport.yaml & \
  sleep 5 && \
  /usr/local/bin/backend & \
  serve -s /app/frontend -l 3000"