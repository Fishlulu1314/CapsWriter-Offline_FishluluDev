REM 设置启动窗口编码为UTF-8
chcp 65001
REM 切换到脚本所在的目录
cd /d "%~dp0"
REM 创建标记文件来指示脚本已经在运行中
echo %date% %time% > "running.flag"
REM 运行启动命令
echo "%~dp0start_client.exe"
start /min /b "" "%~dp0start_server.exe"
timeout /t 1 /nobreak >nul
start /min /b "" "%~dp0start_client.exe"
