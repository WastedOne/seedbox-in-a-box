# Note that at this time, rpmfusion for fedora 24 does not have unrar, as such it is unsuitable for use here.
# When/if there is an unrar package, we will start using f24.
FROM fedora:23

RUN dnf -y install http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-23.noarch.rpm http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-23.noarch.rpm

RUN dnf -y update && dnf -y clean all

RUN dnf -y install irssi perl-Archive-Zip \
        perl-Net-SSLeay perl-HTML-Entities-Numbered \
        perl-XML-LibXML perl-Digest-SHA perl-JSON \
        perl-JSON-XS deluge-console php php-xml ffmpeg \
        mediainfo procps-ng nginx git \
        php-fpm php-cli socat bzip2 \
        tar zip unzip unrar mediainfo \
        nmap-ncat rtorrent findutils && dnf -y clean all

# Add system-wide bashrc with environment variables.
ADD bashrc /etc/

# Add user with bash as the login shell, uid of 1000, username of seeduser
# Make sure this uid is the same as an existing user in your system or this will not work.
RUN useradd --shell /bin/bash -u 1000 seeduser

# Copy files to destinations inside the container, self-explanatory line by line.
# rtorrent config
ADD .rtorrent.rc /home/seeduser/

# nginx server config
ADD nginx.conf /etc/nginx/

# xmlrpc config
ADD seeduser.conf /etc/nginx/default.d

# ******* The htpassword MUST be created or there will be no authentication *******
# htpasswd -c htpasswd seeduser
ADD htpasswd /etc/

# Update trackers files every time we launch irssi
ADD startup /home/seeduser/.irssi/

# Our start script 
ADD start.sh /root/

# Clone some git repositories. This is better than asking folks to trust embedded files. This way you only have to trust the software author, not me. :)
RUN git clone https://github.com/Novik/ruTorrent.git /usr/share/nginx/html/rutorrent

# Ratiocolor plugin, I like it. If you don't, just comment the following line.
RUN git clone https://github.com/Gyran/rutorrent-ratiocolor.git /usr/share/nginx/html/rutorrent/plugins/ratiocolor

# irssi-autodl rutorrent plugin and irssi script
RUN git clone https://github.com/autodl-community/autodl-rutorrent.git /usr/share/nginx/html/rutorrent/plugins/autodl-rutorrent

RUN git clone https://github.com/autodl-community/autodl-irssi.git /home/seeduser/.irssi/scripts/AutodlIrssi.git

# Create the autorun directory. This is the highest level directory we'll need here and creates all the ones below it we'll need as well.
RUN mkdir -p /home/seeduser/.irssi/scripts/autorun

# Create links from the git repo to the various places we'll need those files. Easier than having copies.
RUN ln -s /home/seeduser/.irssi/scripts/AutodlIrssi.git/autodl-irssi.pl /home/seeduser/.irssi/scripts/
RUN ln -s /home/seeduser/.irssi/scripts/AutodlIrssi.git/autodl-irssi.pl /home/seeduser/.irssi/scripts/autorun/
RUN ln -s /home/seeduser/.irssi/scripts/AutodlIrssi.git/AutodlIrssi /home/seeduser/.irssi/scripts/

RUN git clone https://github.com/autodl-community/autodl-trackers.git /home/seeduser/.irssi/scripts/AutodlIrssi/trackers

# Copy config files for autodl-irssi rutorrent plugin and rutorrent config itself.
ADD conf.php /usr/share/nginx/html/rutorrent/conf/users/seeduser/plugins/autodl-irssi/
ADD config.php /usr/share/nginx/html/rutorrent/conf/

# Allow any user to read+execute the home directory. nginx needs this.
RUN chmod 755 /home/seeduser

# As we initiate multiple programs at container start, php-fpm, nginx and rtorrent, we need to use a script that gets run when we start the container.
CMD /root/start.sh

# This is how you start the container and get rtorrent running
# run -it --rm means interactive and don't store the container when finished running
# -p means map port to host the syntax is hostip:hostport:containerport 
# Note: omitting hostip means 0.0.0.0 on the host (every interface)
# Note: the rtorrent port is hardcoded in .rtorrent.rc to 64668. You can choose any port to map it to on the host, it doesn't have to be the same.
# Note: This gets you a web rutorrent UI interface on localhost port 8223

# sudo docker run -it --rm -p 64668:64668/udp -p 64668:64668/tcp -p 127.0.0.1:8223:80/tcp -v /home/seeduser/downloads:/home/seeduser/downloads -v /home/seeduser/.autodl:/home/seeduser/.autodl -v /home/seeduser/.config:/home/seeduser/.config -v /home/seeduser/rutorrent:/home/seeduser/rutorrent --name=fedora-23-seedbox-seeduser fedora-23-seedbox-seeduser

# This is how you start irssi in the same container instance as rtorrent is running as the user seeduser
# sudo docker exec -it -u seeduser fedora-23-seedbox-seeduser irssi

