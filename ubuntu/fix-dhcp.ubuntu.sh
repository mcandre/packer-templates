#!/bin/sh
printf "#!/bin/sh\ndhclient\nexit 0\n" >>/etc/rc.local &&
    chmod 0755 /etc/rc.local
