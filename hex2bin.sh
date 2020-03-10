#!/bin/sh

help()
{
    echo "Linux shell script, July 19th, 2019"
    printf "\n"
    echo "Usage: $0 [Options] [hexval prefixed with 0x or 0X]"
    printf "\n"
    echo "Convert hexadecimal numbers to binary"
    printf "\n"
    echo "Options:"
    printf "\n"
    echo "  -  read from stdin"

    exit 0
}

if [ $# -eq 0 ]; then
    help
elif [ $1 = "-" ]; then
    #Read from stdin
    HEX_VAL=`cat -`
else
    #Hex value must be prefixed with 0x (or 0X)
    INPUT=$1
    PREFIX=`echo $INPUT | cut -c 1-2`
    if [ $PREFIX = "0x" ] || [ $PREFIX = "0X" ]; then
        HEX_VAL=$INPUT
    else 
        help
    fi
fi

#Get input size and format the size in bits (remove 0x)
HEX_SIZE=${#HEX_VAL}
let "BIT_TOTAL = (HEX_SIZE - 2)*4"
DEC_VAL=`printf "%d" "$HEX_VAL"`
BIN_VAL=""

#Convert to binary
while [ $DEC_VAL -ne 0 ]; do
    let "bit = DEC_VAL % 2"
    BIN_VAL=$bit$BIN_VAL
    let "DEC_VAL = DEC_VAL / 2"
done

#Make 0-padding
#Note: If MSbit is 1, no need for padding   
CUR_SIZE=${#BIN_VAL}
let "PAD_SIZE = BIT_TOTAL - CUR_SIZE"

while [ $PAD_SIZE -gt 0 ]; do
    let "PAD_SIZE = PAD_SIZE - 1"
    BIN_VAL=0$BIN_VAL
done

echo $BIN_VAL

