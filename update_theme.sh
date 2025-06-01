#!/bin/bash
# update_theme.sh - 极简主题更新工具

# 设置上游仓库URL
UPSTREAM_URL="https://github.com/57Darling02/VitePress_butterfly.git"

# 保护文件/目录列表
PROTECTED_PATHS=(
  "posts/"
  "site_config.ts"
  "public/"
  ".github/"
)

echo "🚀 VitePress_butterfly 主题极简更新工具"
echo "------------------------------------"

# 第一步：检查是否在Git仓库中
if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "错误：当前目录不是Git仓库！"
  echo "请确保在项目根目录运行此脚本"
  exit 1
fi

# 第二步：添加上游仓库
if ! git remote | grep -q upstream; then
  echo "添加上游主题仓库..."
  git remote add upstream $UPSTREAM_URL
fi

# 第三步：获取最新主题
echo "获取最新主题..."
git fetch upstream main

# 第四步：显示警告信息
echo ""
echo "⚠️ 警告：即将强制更新所有主题文件（保护内容除外）"
echo "----------------------------------------------"
echo "以下内容将被保护:"
for path in "${PROTECTED_PATHS[@]}"; do
  echo "  - $path"
done

# 第五步：确认操作
read -p "是否继续更新？(y/n): " confirm </dev/tty
if [[ ! $confirm =~ ^[Yy]$ ]]; then
  echo "操作已取消"
  exit 0
fi

# 第六步：备份保护内容
echo "备份保护内容..."
BACKUP_DIR=".theme-backup-$(date +%s)"
mkdir "$BACKUP_DIR"

for path in "${PROTECTED_PATHS[@]}"; do
  if [ -e "$path" ]; then
    cp -r "$path" "$BACKUP_DIR/$path"
    echo "备份: $path"
  fi
done

# 第七步：强制更新所有文件
echo "强制更新主题..."
git reset --hard upstream/main

# 第八步：恢复保护内容
echo "恢复保护内容..."
for path in "${PROTECTED_PATHS[@]}"; do
  if [ -e "$BACKUP_DIR/$path" ]; then
    rm -rf "$path"
    cp -r "$BACKUP_DIR/$path" "./"
    echo "恢复: $path"
  fi
done

# 第九步：清理备份
echo "清理临时文件..."
rm -rf "$BACKUP_DIR"

# 第十步：更新依赖
echo "更新依赖包..."
npm install

# 完成提示
echo ""
echo "🎉 主题更新完成！"
echo "---------------------------------"
echo "保护内容已恢复:"
for path in "${PROTECTED_PATHS[@]}"; do
  echo "  - $path"
done
echo ""
echo "下一步建议:"
echo "1. 运行本地预览: npm run dev"
echo "2. 检查站点功能"
echo "3. 如有问题可回退: git reset --hard HEAD@{1}"