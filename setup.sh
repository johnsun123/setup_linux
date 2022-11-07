#!/bin/bash
update() {
  sudo rm /var/lib/dpkg/lock-frontend
  sudo rm /var/lib/dpkg/lock
  sudo apt-get update
}

install_pip() {
  sudo apt install python3-pip -y
  echo "[global]
  index-url = https://pypi.tuna.tsinghua.edu.cn/simple" >/etc/pip.conf
}

install_java() {
  sudo apt-get install openjdk-11-jdk -y
}

install_tomcat() {
  sudo apt-get install tomcat8 -y
  service tomcat8 start
}


install_docker() {
  sudo apt-get install docker.io -y
  echo '{
  "registry-mirrors": ["https://mim2fpma.mirror.aliyuncs.com"]
  }' >/etc/docker/daemon.json
  sudo systemctl daemon-reload
  sudo systemctl restart docker
}

install_docker_others() {
  docker pull jeessy/ddns-go
  docker run -d --name ddns-go --restart=always --net=host jeessy/ddns-go
  docker pull xavierniu/cloudreve
  docker run -d --name cloudreve -e PUID=0 -e PGID=0 -e TZ="Asia/Shanghai" -p 5212:5212 --restart=unless-stopped -v /software/cloudreve/sharedfolders:/cloudreve/uploads -v /software/cloudreve/dockercnf/cloudreve/config:/cloudreve/config -v /software/cloudreve/dockercnf/cloudreve/db:/cloudreve/db -v /software/cloudreve/dockercnf/cloudreve/avatar:/cloudreve/avatar xavierniu/cloudreve
  docker pull portainer/portainer-ce
  docker run -d -p 8000:8000 -p 9000:9000 -p 9443:9443 \
    --name=portainer --restart=always \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v portainer_data:/data \
    portainer/portainer-ce:latest
  docker run -d --name coder-server -p 28080:8080 -e PASSWORD=123 --restart always codercom/code-server:latest
}
install_docker_compose() {
  update
  sudo apt-get install docker-compose -y
}

install_lite() {
  echo "即将安装精简版本！"
  update
  install_pip
  install_java
  install_tomcat
  install_docker
  install_docker_compose
}

install_all() {
  echo "即将安装完整版本！"
  update
  install_pip
  install_java
  install_tomcat
  install_docker
  install_docker_compose
  install_docker_others
}
installing() {
  if [ $(whoami) != "root" ]; then
    echo "请使用root权限执行安装命令！"
    exit 1
  fi
  if [ $1 == lite ]; then
    install_lite $*
  elif [ $1 == all ]; then
    install_all $*
  else
    echo "命令有误，请检查后重试"
    exit
  fi
}

installing $*
echo "
+-------------------------------------------------------------------------+
| 安装完成！请手动安装mariaDB                                                 |
+-------------------------------------------------------------------------+
"
