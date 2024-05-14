#!/bin/bash

# 要添加的新代理域名
new_domain=$1

# bdnew.pac文件路径
file_path="$HOME/proxy_pac/bdnew.pac"

# 检查是否提供了新域名
if [ -z "$new_domain" ]; then
  echo "请提供一个新的代理域名。"
  exit 1
fi

# 检查文件是否存在
if [ ! -f "$file_path" ]; then
  echo "文件 $file_path 不存在。"
  exit 1
fi

# 检查域名是否已经存在于文件中
if grep -q "\"$new_domain\"" "$file_path"; then
  echo "域名 $new_domain 已经存在于 $file_path 文件中。"
  exit 1
fi

# 在 autoproxy_host 对象末尾添加新的代理域名，并在后面加上换行符
sed -i '' "/^var autoproxy_host = {/a\\
  \"$new_domain\" : 1,\\
" "$file_path"

echo "域名 $new_domain 已成功添加到 $file_path 文件中。"
echo "SUCCESS"
