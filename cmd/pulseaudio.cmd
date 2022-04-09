REM launch PulseAudio with arguments
@echo off
setlocal
%USERPROFILE%\bin\pulseaudio-1.1\bin\pulseaudio.exe --exit-idle-time=-1 --load="module-native-protocol-tcp auth-ip-acl=0.0.0.0/0" --load="module-esound-protocol-tcp auth-ip-acl=0.0.0.0/0"
endlocal
