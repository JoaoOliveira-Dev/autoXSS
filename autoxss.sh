#!/bin/bash

# Função de ajuda para exibir o uso
function ajuda() {
    echo "Uso: $0 -u <URL> -p <payloads> [opções]"
    echo
    echo "Opções:"
    echo "  -u, --url      URL a ser testada"
    echo "  -p, --payload  Arquivo de payloads a ser utilizado"
    echo "  -h, --help     Mostra esta mensagem de ajuda"
    echo
    echo 'Exemplo: ./automate_xss.sh -u "http://testphp.vulnweb.com:80/hpp/index.php?pp=x" -p payloads.txt'
    exit 0
}

# Variáveis
URL=""
PAYLOAD_FILE=""

# Processar as opções
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -u|--url)
            URL="$2"
            shift 2
            ;;
        -p|--payload)
            PAYLOAD_FILE="$2"
            shift 2
            ;;
        -h|--help)
            ajuda
            ;;
        *)
            echo "Opção desconhecida: $1"
            ajuda
            ;;
    esac
done

# Verifica se a URL foi fornecida
if [ -z "$URL" ]; then
    echo "Erro: Você precisa fornecer uma URL com a flag -u ou --url"
    ajuda
fi

# Verifica se o arquivo de payload foi fornecido
if [ -z "$PAYLOAD_FILE" ]; then
    echo "Erro: Você precisa fornecer um arquivo de payloads com a flag -p ou --payload"
    ajuda
fi

# Verifica se o arquivo de payload existe
if [ ! -f "$PAYLOAD_FILE" ]; then
    echo "Erro: O arquivo de payloads '$PAYLOAD_FILE' não existe."
    exit 1
fi

# Lê os payloads do arquivo e testa cada um
while IFS= read -r PAYLOAD; do
    echo "Testando payload: $PAYLOAD"

    # Substitui o valor do parâmetro 'q' com o payload na URL usando qsreplace
    MODIFIED_URL=$(echo "$URL" | qsreplace "$PAYLOAD")

    # Executa o airixss no URL modificado
    echo "$MODIFIED_URL" | airixss -p "$PAYLOAD"
done < "$PAYLOAD_FILE"