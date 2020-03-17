#/usr/bin/env bash
# update local file from remote

# $1 download url
# $2 local filepath
function update_file()
{
    local tmp_path="/tmp"
    # can replace by dirname and basename command
    local down_file=`echo "$1" | awk -F "/" '{print $NF}'`
    local down_path=`echo "$2" | awk 'BEGIN{res=""; FS="/";}{for(i=2;i<=NF-1;i++) res=(res"/"$i);} END{print res}'`
    if [ ! -d ${down_path} ]; then
        mkdir -vp ${down_path}
    fi
    rm -rvf ${tmp_path}/${down_file}
    if [ $(command -v wget > /dev/null; echo $?) -eq 0 ]; then
        wget -P ${tmp_path} $1
    elif [ $(command -v curl > /dev/null; echo $?) -eq 0 ]; then
        cd ${tmp_path}
        curl -OL $1
        cd -
    else
        echo "No http request tool."
        exit 1;
    fi
    cp -vf ${tmp_path}/${down_file} $2
    rm -vf ${tmp_path}/${down_file}
    if [ ${down_file##*.} = "sh" ]; then
        chmod +x $2
    fi
}

update_file $@

