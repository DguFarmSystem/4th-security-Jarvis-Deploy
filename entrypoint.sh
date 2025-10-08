#!/busybox/sh

# Teleport 데몬 백그라운드 실행
teleport start --config=/etc/teleport/teleport.yaml &

# Teleport가 시작될 때까지 짧게 대기 (필요시 조절)
sleep 5

# Go 백엔드 실행 (백그라운드 실행)
/usr/local/bin/backend &

# 프론트엔드 정적 서버 실행 (포그라운드 실행)
serve -s /app/frontend -l 3000