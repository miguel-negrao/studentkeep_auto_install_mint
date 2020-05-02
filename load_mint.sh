#!/bin/bash

# $1 o primeiro argumento do script e o disco para onde vamos clonar. 
# p. ex. /dev/nvme0n1
# ATENCAO: e o disco e nao a particao, portanto nao pode terminar em p1 ou p2.


# Ver os comandos que vão correr.
set -o xtrace

if [[ ! -e /sys/firmware/efi ]]; then
    echo Comptudor nao tem efi, a abortar.
    exit 1
fi

disk_destination="$1"

echo A gravar linux mint studentkeep no dispositivo "$disk_destination"

# Verificações
if [ ! -e "$disk_destination" ]; then
    echo Disco "$disk_destination" nao existe.
    exit 1
fi

if grep "$disk_destination" /proc/mounts; then
    echo O disco tem particoes montadas, a abortar.
    exit 1
fi

mint_uuid="5fdab837-71dd-497d-b702-c304d1181f13"

efi_partition="/dev/disk/by-partuuid/b65d01f3-19c7-4649-a68c-f8e6fcf5fd2a"
mint_partition="/dev/disk/by-partuuid/${mint_uuid}"

sgdisk -g --load-backup=table "$disk_destination"
partprobe
# udev e assincrono, temos que esperar que as particoes sejam criadas
while [ ! -e "$efi_partition" ]; do sleep 1; done
while [ ! -e "$mint_partition" ]; do sleep 1; done

# Copiar imagens
dd if=p1 of="$efi_partition" conv=noerror status=progress
dd if=p2 of="$mint_partition" conv=noerror status=progress
sync

# Aumentar a partição até ocupar disco inteiro
sgdisk -d 2 "$disk_destination"
sgdisk -n 0:0:0  "$disk_destination"
sgdisk -u "2:${mint_uuid}" "$disk_destination"
partprobe
while [ ! -e "$mint_partition" ]; do sleep 1; done
e2fsck -f "$mint_partition"
resize2fs "$mint_partition"

# Colocar particção como alvo para arranque no firmware EFI
efibootmgr -c -d "$disk_destination" -p 1 -L "Linux Mint StudentKeep" -l "\EFI\ubuntu\shimx64.efi" -v
