
# usage: cp /etc/skel/.bashrc ~/ && cat .bashrc >> ~/.bashrc && source ~/.bashrc
# start of modify
# modify by aggresss

# find file
alias fdf='find . -name "*" |grep -sin'
# find file content
alias fdc='find . -name "*" |xargs grep -sin'

# switch proxy on-off
proxy-cfg(){
  if [ $1 == 1 ];then
    proxy_url="http://127.0.0.1:1080"
    export proxy=${proxy_url}
    export http_proxy=${proxy_url}
    export https_proxy=${proxy_url}
    export ftp_proxy=${proxy_url}   
  elif [ $1 == 0 ];then
    unset proxy http_proxy https_proxy ftp_proxy
    fi
}
export -f proxy-cfg

# modify for docker
docker-inside(){
  docker exec -it $1 bash -c "stty cols $COLUMNS rows $LINES && bash";
}
export -f docker-inside

docker-inspect(){
  docker inspect $1 | jq -r '.[0].ContainerConfig.Volumes'
  docker inspect $1 | jq -r '.[0].ContainerConfig.ExposedPorts'
}
export -f docker-inspect

# modify bash font color value
# usage: cv 0-6 RGY BMC 
colorv(){
  echo -e "\e[0;3${1}m"
}
export -f colorv

# end of modify
