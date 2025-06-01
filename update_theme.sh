#!/bin/bash
# update_theme.sh - VitePress主题更新工具

# 设置上游仓库URL
UPSTREAM_URL="https://github.com/57Darling02/VitePress_butterfly.git"

echo "🚀 VitePress_butterfly 主题更新工具"
echo "---------------------------------"

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
echo "⚠️ 警告：以下文件将被覆盖（除非你已修改）:"
echo "----------------------------------------"
git diff --name-only HEAD upstream/main -- \
  .vitepress \
  package.json \
  update_theme.sh \
  -- . ':!posts/' ':!site_config.ts' ':!public/' ':!.gitignore' ':!.github/'

# 第五步：用户选择更新方式
echo ""
echo "请选择更新方式:"
echo "1) 安全更新（推荐）: 只更新主题文件，保留你的内容"
echo "2) Git 合并更新（高级）: 手动解决冲突"
echo "3) 退出"
read -p "请输入选项 (1/2/3): " choice </dev/tty

case $choice in
  1)
    # 安全更新模式
    echo "正在执行安全更新..."
    
    # 备份用户配置文件
    if [ -f "site_config.ts" ]; then
      cp site_config.ts site_config.ts.bak
    fi
    
    # 检出上游文件（排除用户内容）
    git checkout upstream/main -- \
      .vitepress \
      package.json \
      update_theme.sh
    
    # 恢复用户配置文件
    if [ -f "site_config.ts.bak" ]; then
      mv site_config.ts.bak site_config.ts
      echo "已恢复你的站点配置 (site_config.ts)"
    fi
    
    echo "✅ 主题更新完成！以下内容已保留:"
    echo "  - 所有文章 (posts/)"
    echo "  - 站点配置 (site_config.ts)"
    echo "  - 静态资源 (public/)"
    echo "  - GitHub配置 (.github/)"
    echo "  - Git忽略配置 (.gitignore)"
    ;;
  2)
    # Git 合并模式
    echo "正在执行 Git 合并..."
    git merge upstream/main
    
    # 检查合并状态
    if [ $? -ne 0 ]; then
      echo "⚠️ 检测到合并冲突！请手动解决:"
      echo "  1. 查看冲突文件: git status"
      echo "  2. 编辑带冲突标记的文件 (<<<<<<<)"
      echo "  3. 解决后标记为已解决: git add <文件>"
      echo "  4. 完成合并: git merge --continue"
    else
      echo "✅ 合并完成，无冲突"
    fi
    ;;
  3)
    echo "操作已取消"
    exit 0
    ;;
  *)
    echo "无效选项，操作已取消"
    exit 1
    ;;
esac

# 第六步：更新依赖
echo "更新依赖包..."
npm install

# 第七步：完成提示
echo ""
echo "🎉 更新完成！"
echo "---------------------------------"
echo "下一步建议:"
echo "1. 运行本地预览: npm run dev"
echo "2. 检查站点功能"
echo "3. 如有问题可回退: git reset --hard HEAD@{1}"
echo ""
echo "💡 提示：定期运行此脚本保持主题更新"