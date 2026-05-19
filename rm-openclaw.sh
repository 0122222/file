#!/bin/bash
echo "=== 彻底删除所有 OpenClaw ==="

# 停止所有进程
pkill -9 -f openclaw 2>/dev/null

# 删除 systemd 服务
rm -f ~/.config/systemd/user/openclaw-gateway.service
systemctl --user daemon-reload

# 删除主目录和配置
rm -rf ~/.openclaw
rm -rf ~/.cache/openclaw
rm -f ~/.local/bin/openclaw
rm -f /usr/local/bin/openclaw 2>/dev/null

# 删除日志
rm -f /tmp/openclaw*.log
rm -rf /tmp/openclaw

# 删除 npm/pnpm 全局安装（如果通过包管理器安装）
npm uninstall -g openclaw 2>/dev/null
pnpm uninstall -g openclaw 2>/dev/null

# 清理环境变量
sed -i '/OPENCLAW/d' ~/.bashrc 2>/dev/null
sed -i '/openclaw/d' ~/.bashrc 2>/dev/null

echo "=== 完成 ==="
echo "验证："
which openclaw
ls ~/.openclaw 2>/dev/null
ps aux | grep openclaw | grep -v grep
