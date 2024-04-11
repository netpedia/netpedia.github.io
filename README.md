# Installation and Setup Netpedia
## Relay Server
Setup VPN relay server on Android using [v2rayNG](https://play.google.com/store/apps/details?id=com.v2ray.ang):
1. Scan Vmess QR Code connection
2. Relay socks5 on 1080 port and http on 8080
3. Set Up and Turn on Tether wifi

## Client
### Android
Installation and setup for Android:
1. Install and set [Tun2Tap](https://play.google.com/store/apps/details?id=com.newtoolsworks.tun2tap)
2. Run with lazy-connect
### PC
Installation and setup for PC client Requirements:
1. Copy [wintun](https://www.wintun.net/) dll file into system32
2. Copy and rename [tun2socks.exe](https://github.com/xjasonlyu/tun2socks/releases) into  system32
3. [Download bat file](wintun.bat) and run as administrator

## Advance Setup
### Manual Wintun Run
For example, your proxy is http://192.168.191.57:7071, then:

1. open cmd in Administrator Mode, create layer 3 network interface(tap)
```sh
tun2socks -device wintun -proxy http://192.168.191.57:7071
tun2socks -device wintun -proxy socks5://host:port
```
2. set the IP Address and get the interface number using route print. For example, 51 were identified as WireGuard Tunnel. By using CMD :
    ```sh
    netsh interface ip set address name="wintun" source=static addr=192.168.123.1 mask=255.255.255.0 gateway=none
    ```
    Use Interface :
    
    ![image](https://user-images.githubusercontent.com/11188109/233845162-753567e6-0911-4788-840a-4b877fcdd610.png)

3. Set the gateway to tap interface except for proxy routing. Route default traffic to the TUN interface and make the proxy server IP as an exception.

  ![image](https://user-images.githubusercontent.com/11188109/233844995-b8e4f27e-f54e-4a22-99cf-53bba2c95a97.png)

  ```sh
  route print
  route add 0.0.0.0 mask 0.0.0.0 192.168.123.1 if <IF NUM> metric 5
  route add <proxy server ip> mask 255.255.255.255 <primary gateway ip for proxy server>
  ```

## Use Proxy Setting

![image](https://github.com/netpedia/netpedia.github.io/assets/11188109/5af51c8b-0be6-4bbd-af69-cc14850a45bf)  

## VPN2Share

* [on PC](https://newtoolsworks.com/tun2tap/)
* [on Phone](https://play.google.com/store/apps/details?id=com.newtoolsworks.vpn2share&hl=en_US)
* [on TV](https://apkpure.com/vpn2share-share-vpn-no-root/com.newtoolsworks.vpn2share)

## Netmod

* [Download Netmod](https://sourceforge.net/projects/netmodhttp/) Update 2023-05-09 
* [Download](https://openvpn.net/community-downloads/) OpenVPN [2.6.3](https://swupdate.openvpn.org/community/releases/OpenVPN-2.6.3-I003-amd64.msi)
* [Download SSTAP-Beta](https://sourceforge.net/projects/sstap/) global setup to socks5://127.0.0.1:1080
* Shared SSTAP 1 to any network

## Reference

1. Proxy to TAP Interface in [Superuser](https://superuser.com/questions/1339015/virtual-network-adapter-that-forwards-request-to-a-socks-proxy)
2. UDPGW in [stackpointer](https://stackpointer.io/network/ssh-port-forwarding-tcp-udp/365/)
3. [tun2socks](https://github.com/xjasonlyu/tun2socks/wiki/Examples)
