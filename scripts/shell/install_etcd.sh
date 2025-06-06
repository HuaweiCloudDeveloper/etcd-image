#!/bin/bash

# etcd安装脚本 for ARM架构 (EulerOS 2.0/Ubuntu 24.04)
# 版本: v3.6.0

ETCD_VERSION="v3.6.0"
ETCD_PKG="etcd-${ETCD_VERSION}-linux-arm64"
ETCD_URL="https://github.com/etcd-io/etcd/releases/download/${ETCD_VERSION}/${ETCD_PKG}.tar.gz"
INSTALL_DIR="/usr/local/bin"
CONFIG_DIR="/etc/etcd"
DATA_DIR="/var/lib/etcd"

# 检查root权限
if [ "$(id -u)" -ne 0 ]; then
    echo "请使用root用户或通过sudo运行此脚本"
    exit 1
fi

# 检查系统架构
ARCH=$(uname -m)
if [ "$ARCH" != "aarch64" ]; then
    echo "此脚本仅适用于ARM64(aarch64)架构"
    exit 1
fi

# 安装依赖
if command -v yum &> /dev/null; then
    # EulerOS/CentOS/RHEL
    yum install -y wget tar
elif command -v apt-get &> /dev/null; then
    # Ubuntu/Debian
    apt-get update
    apt-get install -y wget tar
else
    echo "不支持的包管理器"
    exit 1
fi

# 下载etcd
echo "下载etcd ${ETCD_VERSION}..."
wget ${ETCD_URL} -O /tmp/${ETCD_PKG}.tar.gz || {
    echo "下载失败"
    exit 1
}

# 解压安装
echo "安装etcd到${INSTALL_DIR}..."
tar xzvf /tmp/${ETCD_PKG}.tar.gz -C /tmp
mv /tmp/${ETCD_PKG}/etcd ${INSTALL_DIR}/etcd
mv /tmp/${ETCD_PKG}/etcdctl ${INSTALL_DIR}/etcdctl
mv /tmp/${ETCD_PKG}/etcdutl ${INSTALL_DIR}/etcdutl

# 创建配置和数据目录
echo "创建配置和数据目录..."
mkdir -p ${CONFIG_DIR}
mkdir -p ${DATA_DIR}

# 创建etcd系统服务
echo "创建etcd系统服务..."
cat > /etc/systemd/system/etcd.service <<EOF
[Unit]
Description=etcd key-value store
Documentation=https://github.com/etcd-io/etcd
After=network.target

[Service]
User=root
Type=notify
Environment=ETCD_DATA_DIR=${DATA_DIR}
Environment=ETCD_NAME=%H
ExecStart=${INSTALL_DIR}/etcd \\
  --config-file=${CONFIG_DIR}/etcd.conf.yml
Restart=always
RestartSec=10s
LimitNOFILE=40000

[Install]
WantedBy=multi-user.target
EOF

# 创建etcd配置文件
echo "创建etcd配置文件..."
cat > ${CONFIG_DIR}/etcd.conf.yml <<EOF
name: $(hostname)
data-dir: ${DATA_DIR}
listen-client-urls: "http://0.0.0.0:2379"
advertise-client-urls: "http://0.0.0.0:2379"
listen-peer-urls: "http://0.0.0.0:2380"
initial-advertise-peer-urls: "http://0.0.0.0:2380"
initial-cluster: "$(hostname)=http://0.0.0.0:2380"
initial-cluster-token: "etcd-cluster"
initial-cluster-state: "new"
enable-v2: true
EOF

# 设置权限
chmod 644 /etc/systemd/system/etcd.service
chmod 600 ${CONFIG_DIR}/etcd.conf.yml
chown -R root:root ${DATA_DIR}

# 重载systemd
systemctl daemon-reload

# 启用并启动服务
systemctl enable etcd
systemctl start etcd

# 验证安装
echo "验证etcd安装..."
${INSTALL_DIR}/etcd --version
${INSTALL_DIR}/etcdctl version

echo "etcd安装完成!"
echo "服务状态: systemctl status etcd"
echo "启动服务: systemctl start etcd"
echo "停止服务: systemctl stop etcd"