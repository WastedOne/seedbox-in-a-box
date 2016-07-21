FROM fedora:23

ADD bashrc /etc/

RUN dnf -y install http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-23.noarch.rpm http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-23.noarch.rpm

RUN dnf -y update && dnf -y clean all

RUN dnf -y install mod_wsgi mariadb-server mariadb \
	httpd redhat-rpm-config-36-1.fc23 mariadb-devel git transmission-daemon \
	rabbitmq-server librabbitmq flac lame sox mktorrent python-devel \
	libxml2-devel libxslt-devel gcc hostname procps-ng which && dnf -y clean all

RUN useradd what

ADD whatmanager.conf /etc/httpd/conf.d

COPY start.sh /

USER what

RUN git clone https://github.com/karamanolev/WhatManager2.git /home/what/WhatManager2

COPY wm2settings.py /home/what/WhatManager2/WhatManager2/settings.py

COPY bib.settings.py /home/what/WhatManager2/bibliotik/settings.py

COPY mam.settings.py /home/what/WhatManager2/myanonamouse/settings.py

USER root

RUN pip install -r /home/what/WhatManager2/requirements.txt

CMD ["/start.sh"]

LABEL RUN sudo docker run -it --rm -p 8089:80 --name wm2test fedora-23-whatmanager2-testharness 
