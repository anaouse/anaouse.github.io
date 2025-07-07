@echo off
:: 强制使用 UTF‑8，避免中文乱码
chcp 65001 >nul
setlocal EnableDelayedExpansion

:: === 读取文件夹名称 ===
set /p "folder_name=请输入文件夹名称: "
if "!folder_name!"=="" (
    echo 取消：未输入文件夹名称
    goto :eof
)

:: === 路径 ===
set "folder_path=posts\!folder_name!"
set "file_path=!folder_path!\!folder_name!.md"

:: === 创建目录 ===
echo 正在创建文件夹: !folder_path!
md "!folder_path!" 2>nul || (
    echo 文件夹创建失败，请检查权限。
    goto :eof
)
echo 文件夹创建成功。

:: === 取日期 YYYY-MM-DD ===
for /f %%i in ('powershell -NoProfile -Command "Get-Date -Format yyyy-MM-dd"') do set "current_date=%%i"

:: === 写 front matter ===
> "!file_path!" (
    echo ---
    echo title: !folder_name!
    echo date: !current_date!
    echo author: anaouse
    echo layout: doc
    echo ---
)

:: === 打开 VS Code ===
echo 正在使用 VS Code 打开文件: !file_path!
code "!file_path!" || (
    echo 打开 VS Code 失败；请确认 VS Code 安装并已把 ^"code^" 加入 PATH。
    goto :eof
)

echo 脚本执行完毕。
