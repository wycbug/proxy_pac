#!/bin/bash

# 仓库路径
repo_path="$HOME/proxy_pac"
# 域名添加脚本路径
script_path="$HOME/proxy_pac/add_proxy_domain.sh"
# 要添加的新代理域名
new_domain=$1

# 检查是否提供了新域名
if [ -z "$new_domain" ]; then
  echo "请提供一个新的代理域名。"
  exit 1
fi

# 运行第一个脚本并检查输出
output=$($script_path "$new_domain")

if echo "$output" | grep -q "SUCCESS"; then
  # 进入仓库目录
  cd "$repo_path" || exit

  # Git 添加、提交并推送
  git add bdnew.pac
  git commit -m "添加新的代理域名: $new_domain"
  git push origin main

  echo "域名 $new_domain 已成功提交并推送到远端仓库。"
else
  echo "添加域名失败。"
  echo "$output"
fi
