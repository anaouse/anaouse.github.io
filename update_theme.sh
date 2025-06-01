#!/bin/bash
# update-theme.sh

set -e  # 出错时终止脚本

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # 无颜色

echo -e "${YELLOW}=============================================${NC}"
echo -e "${YELLOW}         VitePress主题一键更新工具          ${NC}"
echo -e "${YELLOW}=============================================${NC}"
echo -e "${GREEN}提示：本工具将从上游仓库更新主题核心文件${NC}"
echo -e "${RED}警告：以下文件将被覆盖：${NC}"
echo -e "  - .vitepress/ 目录"
echo -e "  - package.json"
echo -e "  - package-lock.json"
echo -e "${GREEN}以下文件将保持不变：${NC}"
echo -e "  - posts/ 目录"
echo -e "  - public/ 目录"
echo -e "  - site_config.ts"
echo -e "  - .gitignore"
echo -e "  - .github/ 目录"
echo -e ""

# 确认用户操作
read -p "是否继续更新？(y/N) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo -e "${RED}更新已取消${NC}"
    exit 1
fi

# 检查Git是否安装
if ! command -v git &> /dev/null; then
    echo -e "${RED}错误：未找到Git，请先安装Git${NC}"
    exit 1
fi

# 检查是否在Git仓库中
if ! git rev-parse --is-inside-work-tree &> /dev/null; then
    echo -e "${RED}错误：当前目录不是Git仓库${NC}"
    exit 1
fi

# 保存当前进度
git stash save "pre-update-backup" || true

# 设置上游仓库（如果尚未设置）
if ! git remote -v | grep -q 'upstream'; then
    echo -e "${YELLOW}设置上游仓库为：https://github.com/57Darling02/VitePress_butterfly.git${NC}"
    git remote add upstream https://github.com/57Darling02/VitePress_butterfly.git
fi

# 获取上游更新
echo -e "${GREEN}正在从上游仓库获取更新...${NC}"
git fetch upstream main

# 创建临时分支进行更新
git checkout -b temp-update upstream/main

# 复制需要更新的文件到当前目录
echo -e "${GREEN}正在更新核心文件...${NC}"
cp -r .vitepress ../
cp package.json ../
cp package-lock.json ../ 2>/dev/null || true  # 忽略不存在的文件

# 回到主分支
git checkout main
git branch -D temp-update  # 删除临时分支

# 恢复更新的文件
echo -e "${GREEN}正在应用更新...${NC}"
git checkout -- .  # 清除未跟踪的文件
cp -r ../.vitepress .
cp ../package.json .
cp ../package-lock.json . 2>/dev/null || true

# 提交更新
git add .vitepress package.json package-lock.json
git commit -m "Update theme core from upstream" || true

# 恢复用户修改
echo -e "${GREEN}正在恢复你的自定义修改...${NC}"
git stash pop || true

echo -e "${GREEN}=============================================${NC}"
echo -e "${GREEN}主题核心已成功更新！${NC}"
echo -e "${GREEN}=============================================${NC}"
echo -e "${YELLOW}高级用户建议：${NC}"
echo -e "  1. 使用 'git diff' 查看详细变更"
echo -e "  2. 执行 'npm install' 更新依赖"
echo -e "  3. 如需更精细控制，建议使用 'git merge upstream/main'"