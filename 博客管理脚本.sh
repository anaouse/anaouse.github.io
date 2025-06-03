#!/bin/bash
# theme-utils.sh - VitePress主题管理工具

# ===== 用户可配置区域 =====
# 保护文件/目录列表（可根据需要修改）
PROTECTED_PATHS=(
  "posts/"
  "site_config.ts"
  "public/"
  ".github/"
)

# 上游主题仓库URL
UPSTREAM_URL="https://github.com/57Darling02/VitePress_butterfly.git"
# ===== 配置结束 =====

# 显示菜单
show_menu() {
  echo "🚀 VitePress主题管理工具"
  echo "1. 发布更新到GitHub"
  echo "2. 更新主题"
  echo "其他键退出"
  echo "------------------------------------"
}

# 发布功能
deploy() {
  echo "📤 正在发布更新到GitHub..."
  
  # 复制必要文件
  cp posts/主题介绍/README.md README.md
  
  
  # 提交更新
  git add .
  git commit -m "update"
  git push origin main
  
  echo "✅ 已成功发布更新！"
}

deploy_dev() {
  echo "📤 正在发布更新到GitHub..."
  
  # 复制必要文件
  cp posts/主题介绍/README.md README.md
  cp site_config.ts .vitepress/site_config_template.ts
  # 提交更新
  git add .
  git commit -m "update"
  git push origin main
  
  echo "✅ 已成功发布dev更新！"
}

# 更新主题功能
update_theme() {
  echo "🔄 开始更新主题..."
  
  # 检查是否在Git仓库
  if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "错误：当前目录不是Git仓库！"
    echo "请确保在项目根目录运行此脚本"
    return 1
  fi

  # 添加上游仓库
  if ! git remote | grep -q upstream; then
    echo "添加上游主题仓库..."
    git remote add upstream $UPSTREAM_URL
  fi

  # 获取最新主题
  echo "获取最新主题..."
  git fetch upstream main

  # 显示警告
  echo ""
  echo "⚠️ 警告：即将强制更新所有主题文件（保护内容除外）"
  echo "----------------------------------------------"
  echo "以下内容将被保护:"
  for path in "${PROTECTED_PATHS[@]}"; do
    echo "  - $path"
  done

  # 用户确认
  read -p "是否继续更新？(y/n): " confirm </dev/tty
  if [[ ! $confirm =~ ^[Yy]$ ]]; then
    echo "操作已取消"
    return 0
  fi

  # 备份保护内容
  echo "备份保护内容..."
  local BACKUP_DIR=".theme-backup-$(date +%s)"
  mkdir "$BACKUP_DIR"

  for path in "${PROTECTED_PATHS[@]}"; do
    if [ -e "$path" ]; then
      mkdir -p "$(dirname "$BACKUP_DIR/$path")"
      cp -r "$path" "$BACKUP_DIR/$path"
      echo "备份: $path"
    fi
  done

  # 强制更新
  echo "强制更新主题..."
  git reset --hard upstream/main

  # 恢复保护内容
  echo "恢复保护内容..."
  for path in "${PROTECTED_PATHS[@]}"; do
    if [ -e "$BACKUP_DIR/$path" ]; then
      rm -rf "$path"
      cp -rp "$BACKUP_DIR/$path" "./"
      echo "恢复: $path"
    fi
  done

  # 清理备份
  echo "清理临时文件..."
  rm -rf "$BACKUP_DIR"

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
}

# 主程序
main() {
  while true; do  # 添加循环
    show_menu
    read -p "请选择操作: " choice </dev/tty
    
    case "$choice" in
      1) 
        deploy
        ;;
      2) 
        update_theme
        ;;
      3)
        deploy_dev
        ;;
      *) 
        echo "操作已取消"
        exit 0  # 退出脚本
        ;;
    esac
    
    echo ""  # 添加空行分隔
    read -p "按回车键返回主菜单..." </dev/tty  # 添加暂停
  done
}
# 执行主程序
main