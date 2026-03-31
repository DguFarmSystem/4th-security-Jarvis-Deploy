## Overview
This project is a **web-based SSH access platform** built on top of [Teleport](https://goteleport.com/). It was developed for an Open Source Developer Challenge to provide a **customizable, user-friendly web interface** that overcomes the limitations of Teleport's built-in web UI.
The goal was to decouple the user experience from Teleport's native UI, enabling **localization (Korean support)** and **custom workflows** while leveraging Teleport's robust security features.

## Screenshots
<img width="500" height="320" alt="Image" src="https://github.com/user-attachments/assets/9010fea4-c9d3-41f2-b4f1-f75f2866dc01" />
<img width="500" height="320" alt="Image" src="https://github.com/user-attachments/assets/888f9b19-16db-447e-b61f-0e2601c9594b" />
<img width="500" height="320" alt="Image" src="https://github.com/user-attachments/assets/cc1d954d-27ce-4650-b58c-e08aa97a230e" />
<img width="500" height="320" alt="Image" src="https://github.com/user-attachments/assets/ca939c22-2713-4350-8088-cc3e0bfb3afb" />
<img width="500" height="320" alt="Image" src="https://github.com/user-attachments/assets/67474dae-6fea-47c5-91a1-b11ae668dc78" />
<img width="500" height="320" alt="Image" src="https://github.com/user-attachments/assets/7bf67ef2-5748-475c-bd1c-9e8f198c3d58" />
<img width="500" height="320" alt="Image" src="https://github.com/user-attachments/assets/2b677e67-d754-4b85-b040-e635f851063d" />
<img width="500" height="320" alt="Image" src="https://github.com/user-attachments/assets/103bc843-3541-4058-beb4-42265aacdd7b" />

## Architecture


## Learnings
- Built practical experience with **Docker** and **Docker Compose**, including container networking and image deployment through **Docker Hub**.
- Learned that services organized in a microservice-like structure can communicate not only through **REST APIs** but also through **CLI-based command execution** when needed.
- Gained a stronger understanding of **open-source licenses** and became more interested in the open-source ecosystem, with a stronger desire to contribute to it.

## How to run
```
git clone --recurse-submodules https://github.com/DguFarmSystem/4th-security-Jarvis-Deploy.git
cd 4th-security-Jarvis-Deploy
docker build -t jarvis .
docker run -d --name jarvis -p 3000:3000 -p 8080:8080 -p 3025:3025 jarvis
```
You can access the application at http://localhost:3000 and log in with the default credentials
