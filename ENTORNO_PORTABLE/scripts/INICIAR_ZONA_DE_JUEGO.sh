#!/bin/bash

# === RUTAS DEL ENTORNO ===
BASE_DIR="$(dirname "$(dirname "$(realpath "$0")")")"
GAMES_DIR="$BASE_DIR/../Games"
WINE="$BASE_DIR/../bin/wine/bin/wine"
WINEPREFIX="$BASE_DIR/../wineprefixes/universal"

export WINEPREFIX
export PATH="$BASE_DIR/../bin/wine/bin:$PATH"
export LD_LIBRARY_PATH="$BASE_DIR/../bin/wine/lib:$BASE_DIR/../bin/wine/lib64:$LD_LIBRARY_PATH"

clear

# === CABECERA COMPACTA ===
echo -e "\e[1;34m"
echo "   ╔═════════════════════════════════════════════╗"
echo "   ║         🎮 ZONA DE JUEGO PORTABLE          ║"
echo "   ╚═════════════════════════════════════════════╝"
echo -e "\e[0m"

# === DETECTAR ARCHIVOS .exe EN Games/*/*.exe ===
mapfile -t exe_files < <(find "$GAMES_DIR" -type f -iname "*.exe")

if [ ${#exe_files[@]} -eq 0 ]; then
    echo -e "\n❌ No se encontraron juegos en $GAMES_DIR"
    exit 1
fi

# === MOSTRAR OPCIONES ===
echo -e "\n🎮 Juegos disponibles:"
for i in "${!exe_files[@]}"; do
    rel_path="${exe_files[$i]#$GAMES_DIR/}"
    printf "  %2d. 🎯 %s\n" $((i+1)) "$rel_path"
done

echo -ne "\n🔢 Elegí un número: "
read -r selection

if [[ "$selection" =~ ^[0-9]+$ ]] && (( selection >= 1 && selection <= ${#exe_files[@]} )); then
    selected_exe="${exe_files[$((selection-1))]}"
    selected_dir="$(dirname "$selected_exe")"
    
    echo -e "\n🚀 Iniciando: \e[32m${selected_exe#$GAMES_DIR/}\e[0m"
    cd "$selected_dir" || exit 1
    wine "$selected_exe"

    echo -e "\n✅ Finalizado. Presioná una tecla para salir."
    read -n 1 -s
else
    echo -e "\n❌ Selección inválida."
    exit 1
fi
