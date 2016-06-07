# setup alias, as required

# hints: http://carlosbecker.com/posts/speeding-up-zsh
# https://kev.inburke.com/kevin/profiling-zsh-startup-time/

t0=$(perl -MTime::HiRes -e 'printf("%.0f\n",Time::HiRes::time()*1000)')

# lazyload via shim
if (( $+commands[thefuck] )); then

    # a faster, lazier fuck
    fuck() {
        local args="$@"
        eval "$(command thefuck --alias)"
        eval "fuck $args &> /dev/null"
    }
fi

t1=$(perl -MTime::HiRes -e 'printf("%.0f\n",Time::HiRes::time()*1000)')
echo "PLUGIN thefuck: $(( t1-t0 ))"