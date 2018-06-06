#!/bin/bash
shopt -s extglob
rm -rf !(.git) *
git reset --hard
