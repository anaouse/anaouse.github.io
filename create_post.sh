#!/bin/bash

# 提示用户输入文件夹名称
read -p "请输入文件夹名称: " folder_name

# 构建文件夹路径和文件路径
folder_path="./posts/${folder_name}"
file_path="${folder_path}/${folder_name}.md"

# 创建文件夹
echo "正在创建文件夹: ${folder_path}"
mkdir -p "${folder_path}"

# 检查 mkdir 命令是否成功执行
if [ $? -eq 0 ]; then
  echo "文件夹创建成功。"
else
  echo "文件夹创建失败，请检查权限。"
  exit 1
fi

# 使用 Visual Studio Code 打开文件
echo "正在使用 Visual Studio Code 打开文件: ${file_path}"
code "${file_path}"

# 检查 code 命令是否成功执行
if [ $? -eq 0 ]; then
  echo "文件已在 Visual Studio Code 中打开。"
else
  echo "打开 Visual Studio Code 失败。请确保 'code' 命令已添加到 PATH 环境变量中，且 VS Code 已正确安装。"
  exit 1
fi

echo "脚本执行完毕。"