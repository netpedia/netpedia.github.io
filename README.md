# Installation and Setup

## Tun2Socks
For example, your proxy is http://192.168.191.57:7071, then:

1. Copy [wintun](https://www.wintun.net/) dll file into system32
2. install tun2socks golang package
```sh
go install github.com/xjasonlyu/tun2socks/v2@latest
```

3. open cmd in Administrator Mode, create layer 3 network interface(tap), set IP Address and get interface number using route print, for example 51.
```sh
tun2socks -device wintun -proxy http://192.168.191.57:7071
route print
```

![image](https://user-images.githubusercontent.com/11188109/233845162-753567e6-0911-4788-840a-4b877fcdd610.png)

![image](https://user-images.githubusercontent.com/11188109/233844995-b8e4f27e-f54e-4a22-99cf-53bba2c95a97.png)

4. Set gateway to tap interface except for proxy routing.
```sh
route add 0.0.0.0 mask 0.0.0.0 192.168.123.1 if 51 metric 5
route add 192.168.191.57 mask 255.255.255.255 192.168.191.57
```
