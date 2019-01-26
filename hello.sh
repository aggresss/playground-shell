# hello test for various kinds of language

# linux shell color support.
BLACK="\\033[30m"
RED="\\033[31m"
GREEN="\\033[32m"
YELLOW="\\033[33m"
BLUE="\\033[34m"
MAGENTA="\\033[35m"
CYAN="\\033[36m"
WHITE="\\033[37m"
NORMAL="\\033[m"
HIGHLIGHT="\\033[1m"
INVERT="\\033[7m"


HELLO_TYPE=$1
case ${HELLO_TYPE} in
    c)
        cat << END > /tmp/hello.c
#include <stdio.h>
int main()
{
    printf("Hello, World!\n");
    return 0;
}

END
        echo "/tmp/hello.c"
        #gcc -v /tmp/hello.c 2> /tmp/hello.c.txt
        #gcc -v /tmp/hello.c
        #rm -rf /tmp/hello.c* a.out
    ;;
    cpp)
        cat << END > /tmp/hello.cpp
#include <iostream>
int main()
{
    std::cout << "Hello, World!" << std::endl;
    return 0;
}

END
        echo "/tmp/hello.cpp"
        #g++ -v /tmp/hello.cpp 2> /tmp/hello.cpp.txt
        #g++ -v /tmp/hello.cpp
        #rm -rf /tmp/hello.cpp* a.out
    ;;
    go)
        cat << END > /tmp/hello.go
package main
import "fmt"
func main() {
    fmt.Println("Hello, World!")
}

END
        echo "/tmp/hello.go"
        #go build -o a.out /tmp/hello.go
        #rm -rf /tmp/hello.go a.out
    ;;
    py)
        cat << END > /tmp/hello.py
# -*- coding: UTF-8 -*-
print('Hello, World!')

END
        echo "/tmp/hello.py"
        #python /tmp/hello.py
        #rm -rf /tmp/hello.py
    ;;
    sh)
        cat << END > /tmp/hello.sh
#!/usr/bin/env bash
# brief line
set -e
set -u
# set -x
# set -v
# set -o pipefail
# shopt -s nullglob

# linux shell color support.
BLACK="\\\\033[30m"
RED="\\\\033[31m"
GREEN="\\\\033[32m"
YELLOW="\\\\033[33m"
BLUE="\\\\033[34m"
MAGENTA="\\\\033[35m"
CYAN="\\\\033[36m"
WHITE="\\\\033[37m"
NORMAL="\\\\033[m"
HIGHLIGHT="\\\\033[1m"
INVERT="\\\\033[7m"

function hello()
{
    echo "\$(echo "Hello, World!")"
}

hello $@
END
        echo "/tmp/hello.sh"
        chmod +x /tmp/hello.sh
        #bash /tmp/hello.sh
        #rm -rf /tmp/hello.sh
    ;;
    pl)
        cat << END > /tmp/hello.pl
#!/usr/bin/env perl

print "Hello, Wrold!\n"

END
        echo "/tmp/hello.pl"
        chmod +x /tmp/hello.pl
        #perl /tmp/hello.pl
        #rm -rf /tmp/hello.pl

    ;;
    *)
        echo -e "${RED}Nothing to do!${NORMAL}"
    ;;
esac

