# 安装青龙面板并配置京豆相关
```
docker run -dit \
-v /software/ql/config:/ql/config \
-v /software/ql/log:/ql/log \
-v /software/ql/db:/ql/db \
-v /software/ql/scripts:/ql/scripts \
-v /software/ql/jbot:/ql/jbot \
-v /software/ql/repo:/ql/repo \
-p 5700:5700 \
-e ENABLE_HANGUP=true \
-e ENABLE_WEB_PANEL=true \
--name qinglong \
--hostname qinglong \
--restart always \
whyour/qinglong:latest
```
### 浏览器端访问
```
ip:5700
```

### 完成相应配置

---
## 批量部署依赖库
```
https://www.dujin.org/18899.html
```

---
## 添加京豆相关
```
https://www.dujin.org/18884.html
```

---
## 快手相关配置
```
https://blog.csdn.net/xuekaitt/article/details/123037703
```
添加cookie：
```
ksjsbCookie=
```