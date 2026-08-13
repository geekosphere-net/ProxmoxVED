#!/usr/bin/env bash

# Copyright (c) 2021-2026 tteck
# Author: tteck (tteckster)
# License: MIT | https://github.com/community-scripts/ProxmoxVED/raw/main/LICENSE
# Source: https://github.com/mccutchen/go-httpbin

source /dev/stdin <<<"$FUNCTIONS_FILE_PATH"
color
verb_ip6
catch_errors
setting_up_container
network_check
update_os

msg_info "Installing Dependencies"
$STD apt install -y \
  build-essential \
  ca-certificates \
  git \
  curl \
  wget
msg_ok "Installed Dependencies"

msg_info "Setting up Go"
setup_go
msg_ok "Go installed"

msg_info "Cloning go-httpbin Repository"
# TESTING: Clone from fork with LOG_REQUEST feature
# TODO BEFORE PR: Change back to https://github.com/mccutchen/go-httpbin.git
git clone --depth 1 https://github.com/geekosphere-net/go-httpbin.git /opt/go-httpbin
cd /opt/go-httpbin
msg_ok "Repository cloned"

msg_info "Building go-httpbin"
$STD make build
if [[ ! -f /opt/go-httpbin/dist/go-httpbin ]]; then
  msg_error "Build failed - binary not found"
  exit 1
fi
msg_ok "Build completed"

msg_info "Creating Systemd Service"
cat <<EOF >/etc/systemd/system/go-httpbin.service
[Unit]
Description=go-httpbin - HTTP Testing Service
After=network.target

[Service]
Type=simple
ExecStart=/opt/go-httpbin/dist/go-httpbin -port 8080
Restart=always
RestartSec=10
User=root
WorkingDirectory=/opt/go-httpbin
StandardOutput=journal
StandardError=journal

[Install]
WantedBy=multi-user.target
EOF
systemctl enable -q --now go-httpbin
if ! systemctl is-active --quiet go-httpbin; then
  msg_error "Service failed to start"
  systemctl status go-httpbin
  exit 1
fi
msg_ok "Service created and running"

motd_ssh
customize
cleanup_lxc
