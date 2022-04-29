#! /bin/sh
# -*- mode: sh -*-

OUTYAD=$(yad --form --field=$"Input:fl" '' --field=$"Output:sfl" ''  --field=$"Linearize:chk" '' --field=$"Empty:chk" '' --field=$"Same:chk" '' --field=$"CheckLin:chk" '')
#echo $OUTYAD
#decripta l'output
IFS='|' read in out lin empty same chklin <<END
$OUTYAD
END
#argomenti
    ARGS=" "
    if [ $lin == "TRUE" ]; then
        ARGS+=" --linearize "
    fi
    if [ $same == "TRUE" ]; then
        ARGS+=" --replace-input "
    fi
    #comandi

    if [ $chklin == "TRUE"  ]; then #empty per test
    qpdf $in --check
    fi
if [ $empty == "TRUE"  ]; then #empty per test
    qpdf --empty --check
else #default
    qpdf "$in" $ARGS "$out"
fi
