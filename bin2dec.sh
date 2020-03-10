#!/bin/sh

help()
{
    echo "Linux shell script, July 19th, 2019"
    printf "\n"
    echo "Usage: $0 [Options] [binval]"
    printf "\n"
    echo "Convert binary numbers to decimal"
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
    BIN_VAL=`cat -`
else
    BIN_VAL=$1
fi

#Get input size                                            
BIT_NUM=${#BIN_VAL}
idx=0
VAL=0

#Loop from LSbit to MSbit
while [ $BIT_NUM -gt 0 ]
do
    bit=`echo $BIN_VAL | cut -c $BIT_NUM-$BIT_NUM`
    let "BIT_NUM = BIT_NUM - 1"
    let "VAL = VAL + bit*2**idx"    
    let "idx = idx + 1"
done

echo $VAL
