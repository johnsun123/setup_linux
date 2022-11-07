## 80

```
server {
  listen 80;
  server_name domain.name;
location / {
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header Host $http_host;
    proxy_redirect off;
    proxy_pass http://127.0.0.1:8080;

    # 如果您要使用本地存储策略，请将下一行注释符删除，并更改大小为理论最大文件尺寸
    # client_max_body_size 20000m;
}
}
```
---

## 80强制跳转443

```
server {
    listen 443 ssl;
    server_name domain.name;
    # root /var/www/html;
    # index index.html index.htm;
    ssl_certificate  cert/pan/XXX.pem;
    ssl_certificate_key cert/pan/XXX.key;
    ssl_session_timeout 5m;
    ssl_ciphers ECDHE-RSA-AES128-GCM-SHA256:ECDHE:ECDH:AES:HIGH:!NULL:!aNULL:!MD5:!ADH:!RC4;
    ssl_protocols TLSv1.1 TLSv1.2 TLSv1.3; #表示使用的TLS协议的类型。
    ssl_prefer_server_ciphers on;
location / {
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header Host $http_host;
    proxy_redirect off;
    proxy_pass http://127.0.0.1:8080;

    # 如果您要使用本地存储策略，请将下一行注释符删除，并更改大小为理论最大文件尺寸
    # client_max_body_size 20000m;
}
}
server {
    listen 80;
    server_name domain.name;
    rewrite ^(.*)$ https://domain.name:443; #将所有HTTP请求通过rewrite指令重定向到HTTPS。
}  
```
---

## tomcat

```
server {
    listen 80;
    server_name domain.name;
    root /software/tomcat/tomcat/webapps/ROOT; #假如不配置的话，所有css，js，img文件都无法加载
    charset utf-8;
    location / {
     proxy_pass http://localhost:8080/;   #核心关键的地方，将数据交给本地8080端口的test后台去处理，ps：后面的 / 别忘了
    }
}
```
---

## question项目部署（vue）

```
server {
    listen 443 ssl;
    server_name domain.name;
    # root /var/www/html;
    # index index.html index.htm;
    ssl_certificate  cert/question/XXX.pem;
    ssl_certificate_key cert/question/XXX.key;
    ssl_session_timeout 5m;
    ssl_ciphers ECDHE-RSA-AES128-GCM-SHA256:ECDHE:ECDH:AES:HIGH:!NULL:!aNULL:!MD5:!ADH:!RC4;
    ssl_protocols TLSv1.1 TLSv1.2 TLSv1.3; #表示使用的TLS协议的类型。
    ssl_prefer_server_ciphers on;
location / {
            try_files $uri $uri/ /index.html;
            root   /etc/nginx/question-admin;
            index  index.html;
        }

        location /api {
            proxy_pass http://localhost:18080/;
        }
}
server {
    listen 80;
    server_name domain.name;
    rewrite ^(.*)$ https://domain.name:443; #将所有HTTP请求通过rewrite指令重定向到HTTPS。
}
```
---
## code-server部署
```
server {
    listen 80;
    server_name code.javagood.top;

    location / {
        proxy_pass http://localhost:28080;
proxy_set_header Host $host;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection upgrade;
        proxy_set_header Accept-Encoding gzip;
    }
}
```