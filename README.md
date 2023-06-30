# Installation and Setup
## Nekoray
Easy way is use VPN mode in Nekoray
[Nekoray](https://github.com/MatsuriDayo/nekoray)

![image](https://github.com/netpedia/netpedia.github.io/assets/11188109/0c22d5f4-b1f3-4a77-a610-b54c56d38ea5)

![image](https://user-images.githubusercontent.com/11188109/235293800-39022689-3926-4f4e-9de2-669a797bf994.png)

## Tun2Socks

### Requirements
1. Copy [wintun](https://www.wintun.net/) dll file into system32
2. install tun2socks golang package
```sh
go install github.com/xjasonlyu/tun2socks/v2@latest
```
### Run
For example, your proxy is http://192.168.191.57:7071, then:

1. open cmd in Administrator Mode, create layer 3 network interface(tap)
```sh
tun2socks -device wintun -proxy http://192.168.191.57:7071
tun2socks -device wintun -proxy socks5://host:port
```
2. set IP Address and get interface number using route print, for example 51.
By using CMD :
```sh
netsh interface ip set address name="wintun" source=static addr=192.168.123.1 mask=255.255.255.0 gateway=none
```

Use Interface :

![image](https://user-images.githubusercontent.com/11188109/233845162-753567e6-0911-4788-840a-4b877fcdd610.png)

3. Set gateway to tap interface except for proxy routing. Route default traffic to TUN interface and make proxy server ip as an exception.

![image](https://user-images.githubusercontent.com/11188109/233844995-b8e4f27e-f54e-4a22-99cf-53bba2c95a97.png)

```sh
route print
route add 0.0.0.0 mask 0.0.0.0 192.168.123.1 if <IF NUM> metric 5
route add <proxy server ip> mask 255.255.255.255 <primary gateway ip for proxy server>
```

![image](https://github.com/netpedia/netpedia.github.io/assets/11188109/6cea5bac-fdf0-49e0-9e16-9cc2e311b093)

## VPN2Share

* [on PC](https://newtoolsworks.com/tun2tap/)
* [on Phone](https://play.google.com/store/apps/details?id=com.newtoolsworks.vpn2share&hl=en_US)
* [on TV](https://apkpure.com/vpn2share-share-vpn-no-root/com.newtoolsworks.vpn2share)

## Netmod

* [Download Netmod](https://sourceforge.net/projects/netmodhttp/)
* Setup/Import config and start Netmod. You'll get proxy in socks5://127.0.0.1:1080, connect and serve socks proxy to your network using bitvise
  ```sh
  𝗣𝗔𝗬𝗟𝗢𝗔𝗗 ➔ GET / HTTP/1.1[crlf]Host: [host][crlf]Connection: Upgrade[crlf]User-Agent: [ua][crlf]Upgrade: websocket[crlf][crlf]
  𝗣𝗿𝗼𝘅𝘆 ➔ cdn.noice.id:80
  𝗘𝘅𝗽𝗶𝗿𝗲 𝗧𝗶𝗺𝗲 ➔ lifeTime
  𝗔𝗸𝘂𝗻 𝗦𝗦𝗛 ➔ vpn.vvip-kanghory.my.id:80@trialhory:123
  ```
  ![image](https://github.com/netpedia/netpedia.github.io/assets/11188109/f9bafa49-e4d1-4ca9-802d-116341ba3845)

* Set up Tap
  ```sh
  tun2socks -device wintun -proxy socks5://127.0.0.1:8123
  ```
* Setup IP Adddress for TAP, check interface number and set routing gateway
  ```sh
  netsh interface ip set address name="wintun" source=static addr=192.168.123.1 mask=255.255.255.0 gateway=none
  route print
  route add 0.0.0.0 mask 0.0.0.0 192.168.123.1 if <IF NUM> metric 5
  route add <proxy server ip> mask 255.255.255.255 <primary gateway ip for proxy server>
  ```

## Reference

1. Proxy to TAP Interface in [Superuser](https://superuser.com/questions/1339015/virtual-network-adapter-that-forwards-request-to-a-socks-proxy)
2. UDPGW in [stackpointer](https://stackpointer.io/network/ssh-port-forwarding-tcp-udp/365/)
3. [tun2socks](https://github.com/xjasonlyu/tun2socks/wiki/Examples)
