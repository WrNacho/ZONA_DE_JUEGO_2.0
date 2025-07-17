#!/bin/bash

# ============================
# 🔧 AUTORIZAR ENTORNO PORTABLE
# ============================

echo -e "\n\033[1;36m🔧 AUTORIZANDO ENTORNO PORTABLE...\033[0m"

# Base
BASE_DIR="$(dirname "$(dirname "$(realpath "$0")")")"
SCRIPTS_DIR="$BASE_DIR/scripts"
DESKTOP_DIR="$HOME/Escritorio"

# 1. Permisos a scripts internos
echo -e "\n\033[1;34m🛠️  Dando permisos a los scripts internos...\033[0m"
chmod +x "$SCRIPTS_DIR"/*.sh && \
echo -e "\033[1;32m✅ Scripts autorizados.\033[0m" || \
echo -e "\033[1;31m❌ Error autorizando scripts.\033[0m"

# 2. Permisos a accesos directos .desktop esperados
echo -e "\n\033[1;34m🗂️  Autorizando accesos directos .desktop...\033[0m"
for desktop in "ZONA DE JUEGO.desktop" "ACTIVAR ZONA DE JUEGO.desktop"; do
    path="$DESKTOP_DIR/$desktop"
    if [ -f "$path" ]; then
        chmod +x "$path"
        gio set "$path" "metadata::trusted" yes
        echo -e "\033[1;32m✅ Acceso autorizado: $desktop\033[0m"
    else
        echo -e "\033[1;31m❌ No se encontró: $desktop\033[0m"
    fi
done

# 3. Confirmación final
echo -e "\n\033[1;32m🎉 El entorno ZONA_DE_JUEGO fue autorizado correctamente.\033[0m"

# 4. Si se ejecuta desde GUI, mantener ventana abierta
if [ -z "$PS1" ]; then
    echo -e "\n📦 Cerrá esta ventana cuando termines de leer."
    read -n 1 -s -r -p "Presioná cualquier tecla para cerrar..."
    echo ""
fi

