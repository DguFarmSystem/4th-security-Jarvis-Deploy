# 4th-security-Jarvis-Deploy

> 📖 [English Version](./README.en.md)

이 프로젝트는 [Teleport](https://goteleport.com/) 위에 구축된 **웹 기반 SSH 접근 플랫폼**입니다.  
오픈소스 개발자 챌린지를 위해 개발되었으며, Teleport 기본 웹 UI의 한계를 극복하는 **커스텀 사용자 인터페이스**를 제공합니다.  
Teleport의 강력한 보안 기능을 유지하면서, **한국어 지원(로컬라이제이션)** 과 **커스텀 워크플로우**를 가능하게 하는 것이 목표였습니다.

## 스크린샷

[![screengif](https://github.com/DguFarmSystem/4th-security-Jarvis-Deploy/raw/main/images/JARVIS_screengif.gif)](https://github.com/DguFarmSystem/4th-security-Jarvis-Deploy/blob/main/images/JARVIS_screengif.gif)

## 아키텍처

[![Architecture](https://github.com/DguFarmSystem/4th-security-Jarvis-Deploy/raw/main/images/JARVIS_architecture.png)](https://github.com/DguFarmSystem/4th-security-Jarvis-Deploy/blob/main/images/JARVIS_architecture.png)

- 배포를 단순화하고 네트워크 복잡성을 줄이기 위해 **단일 컨테이너 아키텍처**를 채택했습니다.
- Teleport의 **Go API**가 가장 넓은 범위의 기능을 지원하기 때문에, 백엔드는 **Go**로 개발했습니다.
- 백엔드 일부는 **CLI 명령어**를 통해 Teleport와 통신합니다. Teleport가 공개 로그인 API를 제공하지 않기 때문에, CLI 기반 로그인 프로세스를 자동화하여 백엔드 API로 노출시켰습니다.
- **Go 클라이언트**를 통해 접근하는 Teleport의 **gRPC 기반 API**는 로그인을 제외한 대부분의 기능을 지원하며, 백엔드가 커스텀 애플리케이션과 Teleport 사이의 게이트웨이 역할을 합니다.

## 배운 점

- **Docker**와 **Docker Compose**를 실전에서 활용하며, 컨테이너 네트워킹과 **Docker Hub**를 통한 이미지 배포 경험을 쌓았습니다.
- 마이크로서비스처럼 구성된 서비스들이 **REST API** 뿐만 아니라 필요에 따라 **CLI 기반 명령 실행**을 통해서도 통신할 수 있다는 것을 배웠습니다.
- **오픈소스 라이선스**에 대한 이해가 깊어졌고, 오픈소스 생태계에 더 큰 관심과 기여 의지를 갖게 되었습니다.

## 실행 방법

```bash
git clone --recurse-submodules https://github.com/DguFarmSystem/4th-security-Jarvis-Deploy.git
cd 4th-security-Jarvis-Deploy
docker build -t jarvis .
docker run -d --name jarvis -p 3000:3000 -p 8080:8080 jarvis
```

`http://localhost:3000`에서 애플리케이션에 접속하고, 기본 계정으로 로그인할 수 있습니다.

- ID: `admin` / PW: `admin`
