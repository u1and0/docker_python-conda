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

USER root
RUN pacman -Syyu --noconfirm python-pip otf-ipafont &&\
    pacman -Qtdq | xargs -r pacman --noconfirm -Rcns

ENV PATH /etc/profile.d/:$PATH

# Base packages
RUN source /etc/profile.d/conda.sh &&\
    conda install --quiet --yes \
        --channel conda-forge \
        autopep8 \
        beautifulsoup4 \
        conda-build \
        cufflinks-py \
        dash \
        dash-core-components \
        dash-html-components \
        dash-renderer \
        dash-table \
        fastapi \
        flake8 \
        h5py \
        ipython \
        jinja2 \
        jupyter \
        jupyter_contrib_nbextensions \
        jupyterthemes \
        line_profiler \
        matplotlib \
        more-itertools \
        mypy \
        neovim \
        notebook \
        numpy \
        pandas \
        plotly \
        poetry \
        pyflakes \
        pygments \
        pylint \
        requests \
        scikit-learn \
        scipy \
        seaborn \
        uvicorn \
        yapf &&\
    : "clean cache" &&\
    conda build purge-all

# !!
# SHELL=/usr/bin/zsh at parent layer
# !!

USER u1and0
EXPOSE 8888

LABEL maintainer="u1and0 <e01.ando60@gmail.com>"\
      description="python dev container"\
      description.ja="python開発用コンテナ。ipython, jupyter notebook, neovimによる開発"\
      build_version="python:v1.2.0"
