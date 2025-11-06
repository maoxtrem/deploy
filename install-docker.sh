#!/bin/bash
set -e

echo "🚀 Instalando Docker y Docker Compose..."

# Actualizar paquetes
sudo apt update -y
sudo apt upgrade -y

# Instalar dependencias necesarias
sudo apt install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# Agregar clave GPG oficial de Docker
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
    sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Agregar repositorio de Docker
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Instalar Docker Engine y CLI
sudo apt update -y
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Habilitar y arrancar Docker
sudo systemctl enable docker
sudo systemctl start docker

# Instalar Docker Compose standalone (última versión)
DOCKER_COMPOSE_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep tag_name | cut -d '"' -f 4)
sudo curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Añadir usuario actual al grupo docker
sudo usermod -aG docker $USER

echo "✅ Instalación completada."
echo "👉 Docker version:"
docker --version
echo "👉 Docker Compose version:"
docker-compose --version
echo "⚠️ Recuerda cerrar sesión y volver a entrar para que tu usuario tenga permisos sin sudo."
