# freedos

## Bundled

* [FDNET](https://www.ibiblio.org/pub/micro/pc-stuff/freedos/files/distributions/1.2/repos/pkg-html/fdnet.html) network stack
* [mTCP](https://www.ibiblio.org/pub/micro/pc-stuff/freedos/files/distributions/1.2/repos/pkg-html/mtcp.html) DHCP client, FTP client, FTPSRV, HTTPSERV, IRC client, netcat, ping, PKTTOOL packet sniffer, SNTP client, telnet client
* [wget](https://www.ibiblio.org/pub/micro/pc-stuff/freedos/files/distributions/1.2/repos/pkg-html/wget.html) HTTP client
* [rmenu](https://www.bttr-software.de/products/jhoffmann/#rmenu) telnet server
* [pico](https://www.ibiblio.org/pub/micro/pc-stuff/freedos/files/distributions/1.2/repos/pkg-html/pico.html) text editor
* [noise.sys](http://www.rahul.net/dkaufman/) for `RANDOM$`, `\dev\random`, `\dev\urandom` number generation

## Notes

FreeDOS and MS-DOS are primarily non-networked, single-process environments. Most FreeDOS applications are client-only, no daemon/server mode available. Any servers available for DOS, may be limited to a single client connection at a time. Don't expect BitTorrent, `fork()`, or HTTPS to work well under these conditions.

Glitches, gotchas, surprises, segfaults, typos, bugs, vulnerabilities, dead links, data corruption, and casing concerns are the norm. Multiple memory modes are manifest. FreeDOS != MS-DOS, except when it does.

DOS `echo`...` >[>]<path>` may emit trailing whitespace, unlike UNIX `echo`. Position any redirect symbols immediately adjacent to the last desired character in your DOS `echo` commands.

fdimples is the primary package manager for FreeDOS. fdimples is graphical. fdimples does not offer command line automation. fdimples requires arrow key navigation (Packer `boot_command`). fdimples doesn't include every DOS application that exists online. Some fdimmples packages are broken.

When in doubt, copy the UPPERCASE form of any strings on screen you are interested in passing elsewhere through the system. Some DOS applications are primitive cygwin-like ports that expect file paths in terms of `/drive_<letter>/[<directory>/...]<base-filename>`. Even native applications like `dir` may warp long paths like `supercalifragilisticexpialidocious.txt` as `SUPERCAL[.]TXT`. Good luck!

### FTP

* Some FTP clients (e.g. Firefox) may have difficulty communicating with FTPSrv. lftp recommended.
* FTPSrv includes many artificial client disconnects. You will likely want to lower client retry delay configuration accordingly, down to 5s. For example, `-e "set net:reconnect-interval-base 5;[<command>;...]"` in lftp.
* FTPSrv is sensitive to any trailing whitespace in MTCPCFG configuration files. When writing your own applications, please select a more structured, capable grammar (*cough* YAML *cough* TOML *cough* JSON *cough* *cough* *hack* *wheeze* *owie!*)
* As mentioned above, DOS is a single-process environment. FTPSrv may not serve client requests when run from rmenu, and terminating FTPSrv within rmenu may terminate the client's telnet session. Sometimes launching FTPSrv from rmenu is enough to terminate the client's telnet session.

### HTTP clients

* mTCP's `ftp` does not handle HTTP URL's, unlike FTP clients for other operating systems.
* htget is best avoided, as it will silently fail to preserve downloads to disk.
* curl segfaults.
* wget is unable to access HTTPS resources; Force `http://`... URLs.
* wget transforms many common characters such as hyphen minus (`-`) into underscores (`_`).
* wget will gladly produce a corrupt file given by the name `-o <name>`, and continue transforming the actual download filename as mentioned above.

### telnet

* Supply `-8` flag to telnet clients in order to forward control keys such as `Control+o` (Pico save), `Control+x` (Pico quit).
* DOS is a single user system, unable to handle multiple concurrent telnet client connections.
* Apply a 5s delay between successive client connections, or else the telnet server may appear to be offline.
* Apply a 1s delay between keyboard (hot)keys, or else the telnet server may corrupt user input.
* rmenu may visually corrupt the client screen, leaving ghostly copies of older command logs. This can include server command logs before to the rmenu daemon even launches.
