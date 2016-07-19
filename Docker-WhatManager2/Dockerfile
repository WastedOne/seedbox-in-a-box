FROM fedora:23

RUN dnf -y upgrade && dnf -y clean all

RUN dnf -y install mod_wsgi httpd redhat-rpm-config-36-1.fc23 mariadb-devel git transmission-daemon rabbitmq-server librabbitmq flac lame sox mktorrent mariadb python-devel libxml2-devel libxslt-devel gcc && dnf -y clean all

RUN useradd --shell /bin/bash -u 1001 -o -c "" what

ADD whatmanager.conf /etc/httpd/conf.d

USER what 

WORKDIR /home/what

RUN git clone https://github.com/karamanolev/WhatManager2.git

USER root

RUN pip install -r /home/what/WhatManager2/requirements.txt

COPY start.sh /

CMD ["/start.sh"]

LABEL RUN docker run -d --link=mariadb-wm2 -v /home/what:/home/what -p 59614:59614 fedora-23-whatmanager2-what
