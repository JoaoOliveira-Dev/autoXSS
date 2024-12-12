#!/bin/bash

if [ "$#" -lt 2 ]; then
    echo "Uso: $0 <arquivo_entrada> <arquivo_saida>"
    exit 1
fi

ARQUIVO_ENTRADA="$1"
ARQUIVO_SAIDA="$2"

if [ ! -f "$ARQUIVO_ENTRADA" ]; then
    echo "Erro: Arquivo de entrada '$ARQUIVO_ENTRADA' não encontrado."
    exit 1
fi

while IFS= read -r PAYLOAD; do
    echo '">'"$PAYLOAD" >> "$ARQUIVO_SAIDA"
done < "$ARQUIVO_ENTRADA"

echo "Novo arquivo '$ARQUIVO_SAIDA' criado com sucesso!"