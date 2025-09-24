# 실행방법

클론 후 프로젝트 루트에서
#### git submodule update --init --remote
#### docker build -t teleport-web .
#### docker run -d -p 8080:8080 --name=teleport-web teleport-web
