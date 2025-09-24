# 1단계: Go 빌드 단계
FROM golang:1.25-alpine AS builder

WORKDIR /app
ENV CGO_ENABLED=0 GOOS=linux

# 소스 복사 및 빌드
COPY 4th-security-Jarvis-BE ./4th-security-Jarvis-BE
WORKDIR /app/4th-security-Jarvis-BE
RUN go mod download
RUN go build -o backend ./main.go

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# 2단계: 최종 이미지 (Teleport 베이스 이미지 + 빌드된 Go 바이너리)
FROM public.ecr.aws/gravitational/teleport-distroless-debug:18.2.1

# Teleport 설정 복사
COPY teleport.yaml /etc/teleport/teleport.yaml

# 빌드된 Go 실행파일 복사
COPY --from=builder /app/4th-security-Jarvis-BE/backend /usr/local/bin/backend
COPY --from=builder /entrypoint.sh /entrypoint.sh
# Teleport 포트 오픈
EXPOSE 3025 3080


ENTRYPOINT ["/entrypoint.sh"]
