#!/bin/sh

PLIST='/Library/LaunchDaemons/com.github.timsutton.osx-vm-templates.detectnewhardware.plist'

cat <<EOF >"$PLIST"
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.github.timsutton.osx-vm-templates.detectnewhardware</string>
    <key>ProgramArguments</key>
    <array>
        <string>/usr/sbin/networksetup</string>
        <string>-detectnewhardware</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
</dict>
</plist>
EOF

chmod 644 "$PLIST" &&
    chown root:wheel "$PLIST"
