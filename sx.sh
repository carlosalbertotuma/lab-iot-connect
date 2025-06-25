#!/bin/bash

cipher_b64="OSnaALIWUkpOziVAMycaZQ=="
echo "$cipher_b64" | base64 -d > cipher.bin

target="master_on"

for i in $(seq -w 000 999); do
    # Monta a chave binária direto com printf (redirecionamento evita null byte warning)
    printf "%s" "$i" > key.bin
    dd if=/dev/zero bs=1 count=$((16 - ${#i})) >> key.bin 2>/dev/null

    # Converte para hexadecimal
    hexkey=$(xxd -p key.bin | tr -d '\n')

    # Decripta e salva o resultado (sem guardar em variável!)
    openssl enc -aes-128-ecb -d -K "$hexkey" -in cipher.bin -nopad 2>/dev/null > out.txt

    if grep -q "$target" out.txt; then
        echo "[✅] Key FOUND!: $i"
        echo -n "[🔓] Text: "
        cat out.txt
        break
    fi
done

rm -f cipher.bin key.bin out.txt
