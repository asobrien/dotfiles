t0=$(perl -MTime::HiRes -e 'printf("%.0f\n",Time::HiRes::time()*1000)')
# source aws completions
[[ -f /usr/local/share/zsh/site-functions/_aws ]] && \
source /usr/local/share/zsh/site-functions/_aws

t1=$(perl -MTime::HiRes -e 'printf("%.0f\n",Time::HiRes::time()*1000)')
echo "PLUGIN aws: $(( t1-t0 ))"
