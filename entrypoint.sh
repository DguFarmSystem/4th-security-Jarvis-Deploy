#!/busybox/sh

# Teleport 데몬 백그라운드 실행
teleport start --config=/etc/teleport/teleport.yaml &

# Teleport가 시작될 때까지 짧게 대기 (필요시 조절)
sleep 5

# Go 백엔드 앱 실행 (포그라운드 유지)
exec /usr/local/bin/backend