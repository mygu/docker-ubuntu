## ����ubuntu:16.04����
FROM ubuntu:16.04

# ������Ϣ
MAINTAINER mygu <mingyugu0410@gmail.com>

# ��������Դ
COPY ./etc/apt/sources.list /etc/apt/sources.list

#RUN echo "deb-src http://archive.ubuntu.com/ubuntu xenial main restricted" > /etc/apt/sources.list
#RUN echo "deb http://mirrors.aliyun.com/ubuntu/ xenial main restricted" >> /etc/apt/sources.list
#RUN echo "deb-src http://mirrors.aliyun.com/ubuntu/ xenial main restricted multiverse universe" >> /etc/apt/sources.list
#RUN echo "deb http://mirrors.aliyun.com/ubuntu/ xenial-updates main restricted" >> /etc/apt/sources.list
#RUN echo "deb-src http://mirrors.aliyun.com/ubuntu/ xenial-updates main restricted multiverse universe" >> /etc/apt/sources.list
#RUN echo "deb http://mirrors.aliyun.com/ubuntu/ xenial universe" >> /etc/apt/sources.list
#RUN echo "deb http://mirrors.aliyun.com/ubuntu/ xenial-updates universe" >> /etc/apt/sources.list
#RUN echo "deb http://mirrors.aliyun.com/ubuntu/ xenial multiverse" >> /etc/apt/sources.list
#RUN echo "deb http://mirrors.aliyun.com/ubuntu/ xenial-updates multiverse" >> /etc/apt/sources.list
#RUN echo "deb http://mirrors.aliyun.com/ubuntu/ xenial-backports main restricted universe multiverse" >> /etc/apt/sources.list
#RUN echo "deb-src http://mirrors.aliyun.com/ubuntu/ xenial-backports main restricted universe multiverse" >> /etc/apt/sources.list
#RUN echo "deb http://archive.canonical.com/ubuntu xenial partner" >> /etc/apt/sources.list
#RUN echo "deb-src http://archive.canonical.com/ubuntu xenial partner" >> /etc/apt/sources.list
#RUN echo "deb http://mirrors.aliyun.com/ubuntu/ xenial-security main restricted" >> /etc/apt/sources.list
#RUN echo "deb-src http://mirrors.aliyun.com/ubuntu/ xenial-security main restricted multiverse universe" >> /etc/apt/sources.list
#RUN echo "deb http://mirrors.aliyun.com/ubuntu/ xenial-security universe" >> /etc/apt/sources.list
#RUN echo "deb http://mirrors.aliyun.com/ubuntu/ xenial-security multiverse" >> /etc/apt/sources.list

RUN apt-get update
RUN apt-get upgrade -y

# ��װһЩ�����İ��ͳ��ù���
RUN apt-get install -y make 
RUN apt-get install -y build-essential
RUN apt-get install -y libtool
RUN apt-get install -y libssl-dev
RUN apt-get install -y zlib1g-dev
RUN apt-get install -y libbz2-dev
RUN apt-get install -y libreadline-dev
RUN apt-get install -y libsqlite3-dev 
RUN apt-get install -y wget
RUN apt-get install -y curl
RUN apt-get install -y llvm
RUN apt-get install -y libncurses5-dev libncursesw5-dev 
RUN apt-get install -y xz-utils
RUN apt-get install -y tk-dev
RUN apt-get install -y libpcre3 libpcre3-dev
RUN apt-get install -y openssl
RUN apt-get install -y unrar
RUN apt-get install -y unzip
RUN apt-get install -y vim vim-scripts vim-gtk vim-gnome
RUN apt-get install -y git

# ����hosts����������git
RUN echo "192.30.253.112 github.com" >> /etc/hosts
RUN echo "151.101.44.249 github.global.ssl.fastly.net" >> /etc/hosts

# ��װpyenv
RUN git clone https://github.com/pyenv/pyenv.git ~/.pyenv
RUN echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
RUN echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
RUN echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.bashrc
RUN exec "$SHELL"

# ��װpyenv-virtualenv���
RUN git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv
RUN echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc
RUN exec "$SHELL"

# ʹ��pyenv��װpython2��python3
#RUN wget -c -P ~/.pyenv/cache http://mirrors.sohu.com/python/2.7.14/Python-2.7.14.tar.xz
#RUN wget -c -P ~/.pyenv/cache http://mirrors.sohu.com/python/3.6.5/Python-3.6.5.tar.xz
COPY ./python/Python-2.7.14.tar.xz ~/.pyenv/cache
COPY ./python/Python-3.6.5.tar.xz ~/.pyenv/cache
RUN pyenv install 2.7.14
RUN pyenv install 3.6.5
RUN pyenv rehash
RUN pyenv global 3.6.5

# ��װnginx
RUN wget -c http://nginx.org/download/nginx-1.14.0.tar.gz  # ���nginx��ѹ��������ǰĿ¼��
RUN tar zxvf nginx-1.14.0.tar.gz  # ���
RUN mkdir -p /usr/local/nginx  # ����nginxĿ¼
RUN cd nginx-1.14.0 && ./configure --prefix=/usr/local/nginx && make && make install  # ���밲װ
RUN rm -fv /usr/local/nginx/conf/nginx.conf  # ɾ���Դ���nginx�����ļ�
#ADD http://www.apelearn.com/study_v2/.nginx_conf /usr/local/nginx/conf/nginx.conf  # ���nginx�����ļ�
# ����80�˿�
#EXPOSE 80
# Set the default command to execute when creating a new container  ��������Ϊ��ֹ����������������ֹͣ�������������Ҫ��ִ��һ��tail����
#ENTRYPOINT /usr/local/nginx/sbin/nginx && tail -f /etc/passwd

# ��װJdk1.7��Jdk1.8
RUN apt-get install -y python-software-properties software-properties-common
RUN add-apt-repository ppa:webupd8team/java
RUN apt-get update
RUN apt-get install -y oracle-java7-installer oracle-java8-installer
# update-alternatives --config java  # ѡ��汾

