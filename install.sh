#!/bin/bash
clear
pkill -f ws-epro
echo "INSTALANDO PYTHON NOVO"
sleep 1
cd

# Instalar ws-epro
wget -q --show-progress --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1IbwfNpKpa1JzvXsDT-WgNpp5nWrklisG' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1IbwfNpKpa1JzvXsDT-WgNpp5nWrklisG" -O /usr/local/bin/ws-epro && rm -rf /tmp/cookies.txt
chmod +x /usr/local/bin/ws-epro

# Serviço ws-epro
wget -q --show-progress --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=10hGKYNZUMHdr4y-ZxMr0wKQpj9zSQRkZ' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=10hGKYNZUMHdr4y-ZxMr0wKQpj9zSQRkZ" -O /etc/systemd/system/ws-epro.service && rm -rf /tmp/cookies.txt
chmod +x /etc/systemd/system/ws-epro.service

# Porta ws-epro
wget -q --show-progress --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1h9QvOnXScplGTnfpbJ7KJDn4CDkwUKWa' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1h9QvOnXScplGTnfpbJ7KJDn4CDkwUKWa" -O /usr/bin/ws-port && rm -rf /tmp/cookies.txt
chmod +x /usr/bin/ws-port

# Função para definir a porta
definir_porta() {
    clear
    echo "SELECIONE AS PORTAS"
    sleep 1
    read -p "PORTA LOCAL : " openssh
    read -p "PORTA PYTHON : " wsopenssh
    WS_DIR=/usr/local/etc/ws-epro
    if [ -d "$WS_DIR" ]; then # se existir, exclua
        rm -rf "$WS_DIR"
    fi
    mkdir "$WS_DIR"
    echo "CONFIGURANDO SERVIDOR, AGUARDE..."
    sleep 0.5
    echo "# nível de verbosidade 0=info, 1=verbose, 2=muito verbose" >> /usr/local/etc/ws-epro/config.yml
    echo "verbosidade: 0" >> /usr/local/etc/ws-epro/config.yml
    echo "escutar:"  >> /usr/local/etc/ws-epro/config.yml

    echo "##openssh" >> /usr/local/etc/ws-epro/config.yml
    echo "- host_alvo: 127.0.0.1" >> /usr/local/etc/ws-epro/config.yml
    echo "##porta_openssh" >> /usr/local/etc/ws-epro/config.yml
    echo "  porta_alvo: $openssh" >> /usr/local/etc/ws-epro/config.yml
    echo "##ws_openssh" >> /usr/local/etc/ws-epro/config.yml
    echo "  porta_escuta: $wsopenssh" >> /usr/local/etc/ws-epro/config.yml

    chmod +x /usr/local/etc/ws-epro/config.yml

    # Habilitar & Iniciar serviço
    systemctl enable ws-epro
    systemctl start ws-epro

    echo "CONFIGURE SEU SERVIDOR WEBSOCKET PRO..."
    sleep 0.3
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
    echo    "Créditos a: @NETCOLVIP"
    echo    "════💙🧑🏽‍💻EDITADO POR NETCOLVIP🧑🏽‍💻💙════"
    echo    "╔════════════════════╗"
    echo    "   Porta Local SSH: $openssh"
    echo    "   Porta Python: $wsopenssh"
    echo    "╚════════════════════╝"
    echo    ""
    echo    "WEBSOCKET SEM SER PLANO PRO CLOUDFLARE"
    echo    "---------------------------------------"
    echo    ""
    echo    "PARA MUDAR A PORTA, USE O ws-port" 
}

definir_porta
