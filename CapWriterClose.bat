@echo off
REM 关闭启动的客户端和服务器程序
taskkill /t /f /im start_client.exe
taskkill /t /f /im start_server.exe
REM 切换到当前目录
cd /d %~dp0
REM 删除标记文件
del "running.flag"
