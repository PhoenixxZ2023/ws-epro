#!/bin/bash
clear
pkill -f ws-epro
echo "INSTALANDO PYTHON NOVO"
sleep 1
cd

# Instalar ws-epro
function download_and_install() {
    local url="$1"
    local target="$2"
    wget -q --show-progress --load-cookies /tmp/cookies.txt "$url" -O "$target" && rm -rf /tmp/cookies.txt
    chmod +x "$target"
}

download_and_install "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1IbwfNpKpa1JzvXsDT-WgNpp5nWrklisG' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1IbwfNpKpa1JzvXsDT-WgNpp5nWrklisG" "/usr/local/bin/ws-epro"

# Instalar serviço ws-epro
download_and_install "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=10hGKYNZUMHdr4y-ZxMr0wKQpj9zSQRkZ' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=10hGKYNZUMHdr4y-ZxMr0wKQpj9zSQRkZ" "/etc/systemd/system/ws-epro.service"

# Instalar ws-port
download_and_install "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1h9QvOnXScplGTnfpbJ7KJDn4CDkwUKWa' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1h9QvOnXScplGTnfpbJ7KJDn4CDkwUKWa" "/usr/bin/ws-port"

# Configurar portas
clear
echo "SELECIONE AS PORTAS"
sleep 1
read -p "PORTA LOCAL SSH : " openssh
read -p "PORTA PYTHON : " wsopenssh

WS_DIR="/usr/local/etc/ws-epro"
if [ -d "$WS_DIR" ]; then
    rm -rf "$WS_DIR"
fi
mkdir -p "$WS_DIR"
echo "CONFIGURANDO O SERVIDOR, POR FAVOR AGUARDE..."
sleep 0.5
cat <<EOF > /usr/local/etc/ws-epro/config.yml
# Nível de verbose 0=info, 1=verbose, 2=muito verbose
verbose: 0
listen:
  - target_host: 127.0.0.1
    target_port: $openssh
    listen_port: $wsopenssh
EOF

# Habilitar e iniciar serviço
systemctl enable ws-epro
systemctl start ws-epro

# Exibir informações
clear
LP='\033[1;35m'
NC='\033[0m' # Sem Cor
echo -e "${LP}"
echo    "
░██╗░░░░░░░██╗░██████╗░░░░░░██████╗░██████╗░░█████╗░
░██║░░██╗░░██║██╔════╝░░░░░░██╔══██╗██╔══██╗██╔══██╗
░╚██╗████╗██╔╝╚█████╗░█████╗██████╔╝██████╔╝██║░░██║
░░████╔═████║░░╚═══██╗╚════╝██╔═══╝░██╔══██╗██║░░██║
░░╚██╔╝░╚██╔╝░██████╔╝░░░░░░██║░░░░░██║░░██║╚█████╔╝
░░░╚═╝░░░╚═╝░░╚═════╝░░░░░░░╚═╝░░░░░╚═╝░░╚═╝░╚════╝░"

echo    "💙SCRIPT WEBSOCKET CLOUDFLARE SEM PRO E-PRO💙"
echo    "Creditos: @NETCOLVIP"
echo    "════💙🧑🏽‍💻EDITADO POR NETCOLVIP🧑🏽‍💻💙════"
echo    "╔════════════════════╗"
echo    "   Porta Local SSH: $openssh"
echo    "   Porta Python: $wsopenssh"
echo    "╚════════════════════╝"
echo    ""
echo    "WEBSOCKET SEM SER PLANO PRO CLOUDFLARE"
echo    "---------------------------------------"
echo    ""
echo    "PARA MUDAR DE PORTA, USE O COMANDO: ws-port"
echo    "---------------------------------------"
echo    ""
echo    "GET / HTTP/1.1[crlf]Host: Dominio[crlf]Upgrade: websocket[crlf][crlf]"
echo    "---------------------------------------"
echo -e "${NC}"
rm -rf install-ws && cat /dev/null > ~/.bash_history && history -c
echo -ne "\n\033[1;31mPressione \033[1;33mENTER \033[1;32mpara entrar no \033[1;36mMENU!\033[0m"; read
