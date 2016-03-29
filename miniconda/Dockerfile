FROM centos:7

MAINTAINER Michael Bishop <michael@logitbot.com>

RUN yum update -y && yum upgrade -y && yum install curl epel-release -y && \
    curl -o /etc/yum.repos.d/zulu.repo http://repos.azulsystems.com/rhel/zulu.repo && \
    yum install -y wget bzip2 ca-certificates \
    glib2-devel libXext-devel libSM-devel libXrender-devel \
    git mercurial subversion && yum clean all -y

RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.continuum.io/miniconda/Miniconda-latest-Linux-x86_64.sh && \
    /bin/bash /Miniconda-latest-Linux-x86_64.sh -b -p /opt/conda && \
    rm -f Miniconda-latest-Linux-x86_64.sh

RUN yum install -y curl grep sed  && \
    TINI_VERSION=`curl https://github.com/krallin/tini/releases/latest | grep -o "/v.*\"" | sed 's:^..\(.*\).$:\1:'` && \
    curl -L "https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini_${TINI_VERSION}.rpm" > \
    tini.rpm && \
    yum install -y tini.rpm && \
    rm -f tini.rpm && \
    yum clean all -y

# http://bugs.python.org/issue19846
# > At the moment, setting "LANG=C" on a
# Linux system *fundamentally breaks Python 3*
#ENV LC_ALL C.UTF-8
ENV LC_ALL en_US.utf8
ENV PATH /opt/conda/bin:$PATH
RUN mkdir -p /usr/local/app
ENV HOME /usr/local/app
WORKDIR /usr/local/app

RUN conda update conda -y && conda clean --all -y
RUN conda config --add channels 'conda-forge' && conda config --add channels 'defaults' && \
    conda config --set always_yes yes

COPY environment.yml $HOME/environment.yml
RUN  conda env update . &&  conda update numbapro -y && \
   conda update --all -y && conda clean --all -y

ENTRYPOINT [ "/usr/bin/tini", "--" ]
CMD [ "/bin/bash" ]

# us.gcr.io/vnext-1254/miniconda2