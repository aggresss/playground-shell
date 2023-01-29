#!/usr/bin/env bash
# https://www.baeldung.com/linux/join-multiple-lines

if [ ${1:-NOCONFIG} = "NOCONFIG" ]; then
    echo 'please input filename.'
    exit 1
fi

SED_CMD="sed"
case $(uname) in
Darwin)
    SED_CMD="gsed"
    ;;
esac

${SED_CMD} -i ':a; N; $!ba; s/   //g; s/\n\n/\v/g; s/\n/ /g; s/\v/\n/g' $1
${SED_CMD} -i '/\[Page/d' $1
