#!/bin/bash

# Ruta absoluta del entorno actual (portátil)
BASE_DIR="$(dirname "$(dirname "$(realpath "$0")")")"
SCRIPT_PATH="$BASE_DIR/scripts/INICIAR_ZONA_DE_JUEGO.sh"
ICON_PATH="$BASE_DIR/icono/activarzonadejuego.png"
DESKTOP_FILE="$HOME/Escritorio/ZONA_DE_JUEGO.desktop"

# Crear el archivo .desktop
cat > "$DESKTOP_FILE" <<EOF
[Desktop Entry]
Name=🎮 ZONA DE JUEGO
Comment=Ejecutar juegos portables
Exec=env bash -c '$SCRIPT_PATH'
Icon=$ICON_PATH
Terminal=true
Type=Application
Categories=Game;
EOF

# Darle permisos de ejecución
chmod +x "$DESKTOP_FILE"

# Confirmación
echo -e "\n✅ Acceso directo creado en el Escritorio: ZONA_DE_JUEGO.desktop"
