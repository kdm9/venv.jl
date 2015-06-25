venv.jl
=======

Python-style virtual environments in Julia

To use this:

    cp venv-jl.sh ~/.venv-jl.sh
    echo 'source ~/.venv-jl.sh' >> ~/.bashrc # or zshrc, if that's your thing

Commands:

    lsjlenv # lists environments
    mkjlenv # make new virtual environment
    rmjlenv # rm -rf a virtual environment
    jlworkon # use an environment until shell exits, or jldeactivate is called
    jldeactivate # stop using an environment, and go back to the system pkgdir

## WARNING:

**This is basically a proof of concept. I will probably eventually loot code
from virtualenv/RVM/NVM.** This is essentially a bunch of shell hacks. It still
needs a whole lot of work.
