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
```
2. set IP Address and get interface number using route print, for example 51.
By using CMD :
```sh
netsh interface ip set address name="wintun" source=static addr=192.168.123.1 mask=255.255.255.0 gateway=none
```

Use Interface :

![image](https://user-images.githubusercontent.com/11188109/233845162-753567e6-0911-4788-840a-4b877fcdd610.png)

3. Set gateway to tap interface except for proxy routing.

![image](https://user-images.githubusercontent.com/11188109/233844995-b8e4f27e-f54e-4a22-99cf-53bba2c95a97.png)

```sh
route print
route add 0.0.0.0 mask 0.0.0.0 192.168.123.1 if 51 metric 5
```

## VPN2Share

* [on PC](https://newtoolsworks.com/tun2tap/)
* [on Phone](https://play.google.com/store/apps/details?id=com.newtoolsworks.vpn2share&hl=en_US)
* [on TV](https://apkpure.com/vpn2share-share-vpn-no-root/com.newtoolsworks.vpn2share)

## Netmod

*[PC](https://sourceforge.net/projects/netmodhttp/)
