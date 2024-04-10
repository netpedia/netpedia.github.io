@echo off
setlocal enabledelayedexpansion

for /f "tokens=3" %%a in ('route print ^| findstr "\<0.0.0.0\>"') do (
    set "gateway=%%a"
    goto :found
)

:found
echo Default Gateway: %gateway%
set concatenated=socks5://%gateway%:1080
echo set proxy to : %concatenated%


echo Set proxy server settings in the registry for whatsapp desktop connection

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer /t REG_SZ /d "http=%gateway%:8080;https=%gateway%:8080;socks=%gateway%:1080" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 1 /f

echo Optional: Configure bypass list (if needed)
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyOverride /t REG_SZ /d "<local>;*.example.com" /f

echo Proxy settings updated successfully.


echo Starting tap interface with name wintun
start tun2socks -device wintun -proxy %concatenated%

echo Check if wintun was created
set "interface_found=false"

:check_interface
echo Use ipconfig to list all network interfaces and detect wintun
for /f "tokens=1,* delims=:" %%A in ('ipconfig ^| findstr /n "^"') do (
    echo Check if the line contains "wintun"
    echo %%B | findstr /i "wintun" >nul
    if not errorlevel 1 (
        echo "wintun" interface found.
        set "interface_found=true"
    )
)

echo If "wintun" interface is not found
if "%interface_found%"=="false" (
    echo "wintun" interface not found. Check Again......
	goto :check_interface
) else (
    echo "wintun" interface found.
)


echo set IP Adress of wintun into 172.16.1.1
netsh interface ip set address name="wintun" source=static addr=172.16.1.1 mask=255.255.255.0 gateway=none

:check_wintunip
echo Use ipconfig to get IP address of "wintun" interface
for /f "tokens=2 delims=:" %%A in ('ipconfig ^| findstr /C:"wintun" /C:"172.16.1.1"') do (
	echo Winwun IP set to :
    echo %%A
)else{
	goto :check_wintunip
}

echo add default gateway via wintun
route add 0.0.0.0 mask 0.0.0.0 172.16.1.1 metric 5

echo Please enter your name:
set /p username=
echo Hello, %username%! Welcome to the script.

