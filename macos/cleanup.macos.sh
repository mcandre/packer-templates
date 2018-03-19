#!/bin/sh

# Delete leftover VMware tool files
rm -rf /Users/vagrant/payload \
    /Users/vagrant/manifest.plist \
    /Users/vagrant/descriptor.xml \
    /Users/vagrant/com.vmware.fusion.tools.darwin.zip \
    /Users/vagrant/com.vmware.fusion.tools.darwin.zip.tar

# Disable hibernation
pmset hibernatemode 0 && \
    rm -f /var/vm/sleepimage

# Disable power saving
pmset -a displaysleep 0 disksleep 0 sleep 0

# Disable screensaver
defaults -currentHost write com.apple.screensaver idleTime 0

# Clear cache
rm -rf /Users/vagrant/Library/Caches/* \
    /Library/Caches/*

# Uninstall non-critical applications
rm -rf /Applications/Calculator.app \
    /Applications/Calendar.app \
    /Applications/Chess.app \
    /Applications/Contacts.app \
    /Applications/DVD\ Player.app \
    /Applications/FaceTime.app \
    /Applications/Mail.app \
    /Applications/Maps.app \
    /Applications/Notes.app \
    /Applications/Photo\ Booth.app \
    /Applications/QuickTime\ Player.app \
    /Applications/Reminders.app \
    /Applications/Safari.app \
    /Applications/Siri.app \
    /Applications/Stickies.app \
    /Applications/iBooks.app \
    /Applications/iTunes.app

# Uninstall voices
rm -rf /System/Library/Speech/Voices/*

# Clear bash history
rm /Users/vagrant/.bash_history

# Clear logs
rm -rf /private/var/log/*

# Clear temporary files
rm -rf /tmp/*

# Shrink swap space
launchctl unload /System/Library/LaunchDaemons/com.apple.dynamic_pager.plist && \
    sleep 5 && \
    rm -f /private/var/vm/swap*

# Shrink root partition
diskutil secureErase freespace 0 '/Volumes/Macintosh HD'
