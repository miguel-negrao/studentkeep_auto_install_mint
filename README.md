# Script para instalação automática de Linux Mint 

## Descrição

Este script permite instalar o Linux Mint 64bits já com Zoom, Teams, Teamviewer e Skype instalados e preparado em modo OEM num computador de forma automatizada. 

## AVISO IMPORTANTE

- Este script manipula tabelas de partições e escreve por cima de partições inteiras. Este script pode conter algum bug não detetado e nesse caso poderá no pior dos casos apagar os dados de qualquer dispositivo ligado ao PC. Não ligar nenhum disco ao PC que contenha dados importantes !

## Requisitos

- Computador x86_64 com firmware efi
- Capacidade de fazer boot via USB.
- Disco com no mínimo 20GiB de espaço.

## Uso

1. Colocar a imagem de instalação do Linux Mint retirada do site (ou de qualquer outro Linux) numa pen. 
2. Se houver espaço na mesma pen, poderás criar uma nova partição na pen usando o espaço vazio. Se estiveres a usar Windows deverás formatar essa partição por exemplo para exfat. Colocar o conteúdo desta pasta onde está este ficheiro nessa partição. Alternativamente poderá ser usado uma outra pen USB ou outro disco externo.
3.  Colocar a pen criada em 1) no PC, arrancar e escolher no menu de boot a pen.
4. Caso precises de segunda Pen insere-a no PC.
5. É necessário descobrir qual é o dispositivo em `/dev` que corresponde ao disco do computador onde se quer instalar. Poderás usar o comando `sudo lsblk` ou abrir aplicação "Disks" e procurar qual é o disco principal do computador. Se for um ssd moderno poderá se algo como `/dev/nvme0n1`.  Para disco SATA será algo como `/dev/sda`. Atenção quer-se o nome do disco e não de uma partição pelo que o nome não poderá ter no fim `p1` ou `1` ou outro número.
6. Abrir uma janela do terminal e fazer:

```bash
cd <Caminho onde foi colocada esta pasta>/auto_mint
sudo bash load_mint.sh <caminho para dispositivo do disco>
```

No caso do ssd mencionado acima o script será chamado fazendo:

```bash
sudo bash load_mint.sh /dev/nvme0n1
```



1. Quando o script terminar, no menu do Mint desligar computador, e este está pronto, não é necessário fazer mais nada.

## Notas

- O script irá escrever uma mensagem "Error 38", pode-se ignorar sem problemas.
- Se quiserem testar se o processo funcionou iniciem o computador. Irão ter ao wizard OEM e não há forma de desligar o computador através do GUI. Poderão fazer ctrl-alt-F3 entrar com a conta `oem` e correr o comando `poweroff`.





Miguel Negrão 2020-05

