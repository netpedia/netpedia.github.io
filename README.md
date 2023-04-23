# netpedia.github.io

run in Administrator Mode in CMD 

```sh
go install github.com/xjasonlyu/tun2socks/v2@latest

tun2socks -device wintun -proxy http://192.168.191.57:7071
route print
route add 0.0.0.0 mask 0.0.0.0 192.168.123.1 if 51 metric 5
route add 192.168.191.57 mask 255.255.255.255 192.168.191.57

```
