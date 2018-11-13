# hello test for various kinds of language

HELLO_TYPE=$1
case ${HELLO_TYPE} in
    c)
        cat << END > /tmp/hello.c
#include <stdio.h>
int main()
{
    printf("Hello World!\n");
    return 0;
}
END
        #gcc -v /tmp/hello.c 2> /tmp/hello.c.txt
        #gcc -v /tmp/hello.c
        #rm -rf /tmp/hello.c* a.out
    ;;
    cpp)
        cat << END > /tmp/hello.cpp
#include <iostream>
int main()
{
    std::cout << "Hello World!" << std::endl;
    return 0;
}
END
        #g++ -v /tmp/hello.cpp 2> /tmp/hello.cpp.txt
        #g++ -v /tmp/hello.cpp
        #rm -rf /tmp/hello.cpp* a.out
    ;;
    go)
        cat << END > /tmp/hello.go
package main
import "fmt"
func main() {
    fmt.Println("Hello World!")
}
END
        #go build -o a.out /tmp/hello.go
        #rm -rf /tmp/hello.go a.out
    ;;
    python)
        cat << END > /tmp/hello.py
# -*- coding: UTF-8 -*-
print('Hello World!')
END
        #python /tmp/hello.py
        #rm -rf /tmp/hello.py
    ;;
    *)

    ;;
esac

