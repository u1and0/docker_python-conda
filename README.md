Welcome to Python dev docker image
---


```
Usage:
 In host machine's shell
   $ docker pull u1and0/python-conda
   $ docker run -it --rm -v `pwd`:/work -w /work u1and0/python-conda

 Using other command with activating `conda`
   $ docker run -it --rm -v `pwd`:/work -w /work\
         u1and0/python-conda bash -c ". .bashrc && python"
   $ docker run -it --rm -v `pwd`:/work -w /work\
         u1and0/python-conda bash -c ". .bashrc && ipython"
   $ docker run -it --rm -v `pwd`:/work -w /work\
         u1and0/python-conda bash -c ". .bashrc && nvim"
   $ docker run -P -it --rm -v `pwd`:/work -w /work\
         u1and0/python-conda bash -c ". .bashrc && jupyter notebook"

 In contaner
   Just type
   $ ipython
       or
   $ jupyter notebook
       or
   $ nvim
```
