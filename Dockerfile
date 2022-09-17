# Python dev docker image
#
# Usage:
#   In host machine's shell
#     $ docker pull u1and0/python-conda
#     $ docker run -it --rm -v `pwd`:/work -w /work u1and0/python-conda
#
#   Using other command with activating `conda`
#     $ docker run -it --rm -v `pwd`:/work -w /work\
#           u1and0/python-conda bash -c ". .bashrc && python"
#     $ docker run -it --rm -v `pwd`:/work -w /work\
#           u1and0/python-conda bash -c ". .bashrc && ipython"
#     $ docker run -it --rm -v `pwd`:/work -w /work\
#           u1and0/python-conda bash -c ". .bashrc && nvim"
#     $ docker run -P -it --rm -v `pwd`:/work -w /work\
#           u1and0/python-conda bash -c ". .bashrc && jupyter notebook"
#
#   In contaner
#     Just type
#     $ ipython
#         or
#     $ jupyter notebook
#         or
#     $ nvim

FROM u1and0/zplug:latest

# !!
# USER=u1and0 not root user
# !!

# Install miniconda3-latest & restore conda packages
RUN yay -Syyu --noconfirm miniconda3 &&\
    yay -Scc &&\
    sudo ln -s /opt/miniconda3/etc/profile.d/conda.sh /etc/profile.d/conda.sh

RUN sudo pacman -Syyu --noconfirm python-pip otf-ipafont &&\
    pacman -Qtdq | xargs -r sudo pacman --noconfirm -Rcns

ENV PATH /etc/profile.d/:$PATH

# Base packages
RUN source /etc/profile.d/conda.sh &&\
    sudo conda install --quiet --yes \
        autopep8 \
        beautifulsoup4 \
        conda-build \
        conda-forge::jupyter_contrib_nbextensions \
        conda-forge::jupyterthemes \
        conda-forge::neovim \
        flake8 \
        h5py \
        ipython \
        jupyter \
        line_profiler \
        matplotlib \
        more-itertools \
        mypy \
        notebook \
        numpy \
        pandas \
        pyflakes \
        pygments \
        pylint \
        requests \
        scipy \
        seaborn \
        yapf &&\
    sudo conda remove --quiet --yes --force qt pyqt && \
    : "clean cache" &&\
    conda build purge-all

# Dev packages
RUN source /etc/profile.d/conda.sh &&\
    sudo conda install --quiet --yes \
        scikit-learn \
        plotly \
        conda-forge::cufflinks-py \
        dash \
        dash-renderer \
        dash-core-components \
        dash-html-components \
        dash-table &&\
    sudo conda remove --quiet --yes --force qt pyqt && \
    : "clean cache" &&\
    conda build purge-all

# !!
# SHELL=/usr/bin/zsh at parent layer
# !!

EXPOSE 8888

LABEL maintainer="u1and0 <e01.ando60@gmail.com>"\
      description="python dev container"\
      description.ja="python開発用コンテナ。ipython, jupyter notebook, neovimによる開発"\
      build_version="python:v1.1.0"
