#!/usr/bin/env bash
set -euo pipefail

# 默认用户：root（你也可以在 run 时用 -e SSH_USER=xxx 指定）
SSH_USER="${SSH_USER:-root}"

# 支持 SSH_PUBLIC_KEY(单个) 或 SSH_AUTHORIZED_KEYS(可多行)
KEYS="${SSH_AUTHORIZED_KEYS:-}"
if [[ -z "$KEYS" && -n "${SSH_PUBLIC_KEY:-}" ]]; then
  KEYS="${SSH_PUBLIC_KEY}"
fi

if [[ -z "$KEYS" ]]; then
  echo "ERROR: no ssh key provided. Set SSH_PUBLIC_KEY or SSH_AUTHORIZED_KEYS." >&2
  exit 2
fi

HOME_DIR="$(getent passwd "$SSH_USER" | cut -d: -f6)"
if [[ -z "$HOME_DIR" ]]; then
  echo "ERROR: user '$SSH_USER' not found in container." >&2
  exit 3
fi

SSH_DIR="${HOME_DIR}/.ssh"
AUTH_KEYS="${SSH_DIR}/authorized_keys"

mkdir -p "$SSH_DIR"
chmod 700 "$SSH_DIR"

# 覆盖写入（避免旧 key 残留；想追加可改成 >>）
printf "%s\n" "$KEYS" >> "$AUTH_KEYS"
chmod 600 "$AUTH_KEYS"

chown -R "$SSH_USER:$SSH_USER" "$SSH_DIR" 2>/dev/null || true

exec "$@"
