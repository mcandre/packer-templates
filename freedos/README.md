# freedos

## Bundled

* [FDNET](https://www.ibiblio.org/pub/micro/pc-stuff/freedos/files/distributions/1.2/repos/pkg-html/fdnet.html) network stack
* [mTCP](https://www.ibiblio.org/pub/micro/pc-stuff/freedos/files/distributions/1.2/repos/pkg-html/mtcp.html) DHCP client, FTP client, FTPSRV, htget, HTTPSERV, IRC client, netcat, ping, PKTTOOL packet sniffer, SNTP client, telnet client
* [rmenu](https://www.bttr-software.de/products/jhoffmann/#rmenu) telnet server
* [pico](https://www.ibiblio.org/pub/micro/pc-stuff/freedos/files/distributions/1.2/repos/pkg-html/pico.html) text editor
* [noise.sys](http://www.rahul.net/dkaufman/) for `RANDOM$`, `\dev\random`, `\dev\urandom` number generation

## Notes

### telnet

* Supply `-8` flag to telnet clients in order to forward control keys such as `Control+o` (Pico save), `Control+x` (Pico quit).
* DOS is a single user system, unable to handle multiple concurrent telnet client connections.
* Apply a 5s delay between successive client connections, or else the telnet server may appear to be offline.
* Apply a 1s delay between keyboard (hot)keys, or else the telnet server may corrupt user input.
* rmenu may visually corrupt the client screen, leaving ghostly copies of older command logs. This can include server command logs before to the rmenu daemon even launches.

### FTP

* Some FTP clients (e.g. Firefox) may have difficulty communicating with FTPSrv. lftp recommended.
* FTPSrv includes many artificial client disconnects. You will likely want to lower client retry delay configuration accordingly, down to 5s.
