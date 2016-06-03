# load virtualenvwrapper, if installed

t1=$(perl -MTime::HiRes -e 'printf("%.0f\n",Time::HiRes::time()*1000)')

if [[ -f "/usr/local/bin/virtualenvwrapper.sh" ]]; then
    export WORKON_HOME=$HOME/.virtualenvs
    export PROJECT_HOME=$HOME/Code
    export VIRTUALENVWRAPPER_SCRIPT=/usr/local/bin/virtualenvwrapper.sh
    source /usr/local/bin/virtualenvwrapper_lazy.sh
fi

t1=$(perl -MTime::HiRes -e 'printf("%.0f\n",Time::HiRes::time()*1000)')
echo "PLUGIN venv: $(( t1-t0 ))"