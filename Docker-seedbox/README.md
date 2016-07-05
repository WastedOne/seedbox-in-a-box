## Generate the htpasswd file (username and password to access rutorrent's web interface)

# ******* The htpassd MUST be created or there will be no authentication *******
```
htpasswd -c htpasswd seeduser
```

## Create and populate the host's user directory like this:
```
mkdir -p /home/seeduser/.autodl /home/seeduser/.config/rtorrent/sessions /home/seeduser/rutorrent/users/seeduser/torrents

cp autodl2.cfg /home/seeduser/.autodl

touch /home/seeduser/.autodl/autodl.cfg
```

```
[seeduser@host ~]$ pwd

/home/seeduser

[seeduser@host ~]$ find .

.

./downloads

./.autodl

./.autodl/autodl2.cfg

./.autodl/autodl.cfg

./.config

./.config/rtorrent

./.config/rtorrent/sessions

./rutorrent

./rutorrent/users

./rutorrent/users/seeduser

./rutorrent/users/seeduser/torrents
```

```
## Don't forget to set the selinux context with
chcon -t svirt_sandbox_file_t -l s0 -R /home/seeduser
```

