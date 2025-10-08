# 1단계: 프론트엔드 빌드
FROM node:18 AS fe-builder

WORKDIR /app
COPY 4th-security-Jarvis-FE ./4th-security-Jarvis-FE
WORKDIR /app/4th-security-Jarvis-FE

RUN npm install --legacy-peer-deps
RUN npm run build

# serve 설치 (단독 스테이지)
FROM node:18 AS serve-installer
RUN npm install -g serve

# 2단계: 백엔드 빌드
FROM golang:1.25-alpine AS be-builder

WORKDIR /app
ENV CGO_ENABLED=0 GOOS=linux

# 소스 복사 및 빌드
COPY 4th-security-Jarvis-BE ./4th-security-Jarvis-BE
WORKDIR /app/4th-security-Jarvis-BE
RUN go mod download
RUN go build -o backend ./main.go

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# 3단계: 최종 이미지 (Teleport 베이스 이미지 + 빌드된 Go 바이너리)
FROM public.ecr.aws/gravitational/teleport-distroless-debug:18.2.1

# 백엔드 실행파일 및 entrypoint 복사
COPY --from=be-builder /app/4th-security-Jarvis-BE/backend /usr/local/bin/backend
COPY --from=be-builder /entrypoint.sh /entrypoint.sh

# teleport 설정 복사
COPY teleport.yaml /etc/teleport/teleport.yaml

# 프론트엔드 빌드 결과 복사
COPY --from=fe-builder /app/4th-security-Jarvis-FE/dist /app/frontend

# 포트 오픈
EXPOSE 3025 3080 3000

ENTRYPOINT ["/entrypoint.sh"]
