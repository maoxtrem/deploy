#!/bin/bash
# Script para instalar Webmin en Ubuntu 24

set -e  # hace que el script se detenga si ocurre algún error

echo "Descargando script de repositorio Webmin..."
curl -o webmin-setup-repo.sh https://raw.githubusercontent.com/webmin/webmin/master/webmin-setup-repo.sh

echo "Ejecutando script de configuración del repositorio..."
sudo sh webmin-setup-repo.sh

echo "Instalando Webmin con dependencias recomendadas..."
sudo apt-get update
sudo apt-get install -y webmin --install-recommends

echo "Instalación completada. Accede a Webmin en https://localhost:10000"
