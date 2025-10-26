# 실행방법

로컬에서 클론하여 이미지를 빌드해 사용하는 방법

#### git submodule update --init --remote
#### docker build -t teleport-web .
#### docker run -d -p 3000:3000 -p 8080:8080 --name=teleport-web teleport-web

-------

도커 허브 이미지를 받아와 사용하는 방법

#### docker pull clapppp/teleport-web:latest

#### docker run --rm -d -p 3000:3000 -p 8080:8080 clapppp/teleport-web:latest