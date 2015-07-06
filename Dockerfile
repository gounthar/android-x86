# Android-x86
#
# VERSION               0.0.1
#

FROM     ubuntu:14.10
MAINTAINER BrunoVerachten "bruno.verachten@worldline.net"

ENV UBUNTU_FRONTEND noninteractive

# Depots, mises a jour et installs
RUN (apt-get update && apt-get upgrade -y -q && apt-get dist-upgrade -y -q && apt-get -y -q autoclean && apt-get -y -q autoremove)
RUN (apt-get update)
RUN (apt-get install -y software-properties-common)
RUN (add-apt-repository ppa:webupd8team/java)
RUN (add-apt-repository "deb http://archive.canonical.com/ trusty partner")
RUN (apt-get update)
#RUN (apt-get upgrade -y)
RUN (sed -i -e '1ideb mirror://mirrors.ubuntu.com/mirrors.txt trusty main restricted universe multiverse\ndeb mirror://mirrors.ubuntu.com/mirrors.txt trusty-updates main restricted universe multiverse\ndeb mirror://mirrors.ubuntu.com/mirrors.txt trusty-backports main restricted universe multiverse\ndeb mirror://mirrors.ubuntu.com/mirrors.txt trusty-security main restricted universe multiverse\n' /etc/apt/sources.list)
RUN (apt-get update)
RUN echo "[docker provisioning] Installing Java..."
RUN (apt-get -y install python-software-properties)
RUN (add-apt-repository -y ppa:webupd8team/java)
RUN (apt-get update)
RUN (echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections)
RUN (echo oracle-java8-installer shared/accepted-oracle-license-v1-1 seen true | /usr/bin/debconf-set-selections)
RUN (apt-get -y install oracle-java7-set-default)
RUN (apt-get -y install openjdk-7-jdk)
RUN (update-java-alternatives -s java-1.7.0-openjdk)
RUN (apt-get -y install oracle-java8-set-default)
RUN (apt-get -y install oracle-java6-set-default)
ENV JAVA_HOME "/usr/lib/jvm/java-7-oracle/jre"
ENV PATH $JAVA_HOME/bin:$PATH
ENV USE_CCACHE 1
RUN echo "[docker provisioning] Java installed"
RUN (dpkg --configure -a)
RUN (apt-get autoremove -y)
RUN echo "[docker provisioning] Creating .provision_java_check file..."
RUN (touch .provision_java_check)
RUN (apt-get install -y connect-proxy socat zip build-essential curl git-core)
RUN (mkdir -p /root/bin)
ENV PATH ~/bin:$PATH
RUN (curl http://commondatastorage.googleapis.com/git-repo-downloads/repo > /root/bin/repo)
RUN (chmod a+x  /root/bin/repo)
ENV M3_HOME ”/usr/share/maven3″
ENV MAVEN_HOME ”/usr/share/maven3″
ENV M3 ”/usr/share/maven3/bin”
ENV M2_HOME ”/usr/share/maven3″
ENV M2 ”/usr/share/maven3/bin”
RUN (apt-get install -y python gcc patch flex bison gperf g++ squashfs-tools g++-multilib zlib1g-dev lib32z1-dev lib32ncurses5-dev gcc-multilib libwxgtk2.8-dev tofrodos texinfo mtools lib32z1 lib32ncurses5 lib32bz2-1.0 gnupg flex bison gperf build-essential \
zlib1g-dev libc6-dev lib32ncurses5-dev \
x11proto-core-dev libx11-dev lib32readline-gplv2-dev lib32z-dev \
libgl1-mesa-dev g++-multilib mingw-w64 python-markdown \
libxml2-utils xsltproc yasm g++-4.4-multilib ccache bc expect \
python-mako gettext)
RUN (mkdir -p /data)
RUN (mkdir -p /data/android-x86)
RUN (chmod 777 /data/android-x86)
RUN (cd /data/android-x86)
RUN git config --global user.email "android-x86@docker.com"
RUN git config --global user.name "Android-x86 Builder"
VOLUME /data
COPY expect.sh /root/bin/
RUN /root/bin/expect.sh
#RUN sh -e -u -x /root/bin/expect.sh

#RUN (chown -R docker:docker /home/docker/)
