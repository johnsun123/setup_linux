# code-server项目部署

## docker部署命令
```
  docker run -d --name coder-server -p 28080:8080 -e PASSWORD=123 --restart always codercom/code-server:latest
```
## 添加相应配置
### 登录bash
 - 获取到ID
```
docker ps -a
```
- 登录bash(这里将ID替换为上一步获取到的ID)

```
docker exec -it ID bash
```
- 替换系统镜像源为清华镜像源
```
echo "deb https://mirrors.tuna.tsinghua.edu.cn/debian/ bullseye main contrib non-free"| sudo tee /etc/apt/sources.list
echo "deb https://mirrors.tuna.tsinghua.edu.cn/debian/ bullseye-updates main contrib non-free"| sudo tee -a /etc/apt/sources.list
echo "deb https://mirrors.tuna.tsinghua.edu.cn/debian/ bullseye-backports main contrib non-free"| sudo tee -a /etc/apt/sources.list
echo "deb https://mirrors.tuna.tsinghua.edu.cn/debian-security bullseye-security main contrib non-free"| sudo tee -a /etc/apt/sources.list
```
- 安装vim
```
sudo apt-get install vim
```

- 安装jdk

搜索openjdk
```
sudo apt-cache search openjdk
```
```
sudo apt-get install openjdk-11-jdk
```
- 安装pip3
```
  sudo apt-get install python3-pip -y
  pip3 config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
```
