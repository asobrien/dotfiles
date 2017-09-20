# source aws completions
[[ -f /usr/local/share/zsh/site-functions/_aws ]] && \
source /usr/local/share/zsh/site-functions/_aws

# more inspiration: https://gist.github.com/waylan/4080362

# helpers to make my life easier
# desribe an ec2 instance
aws-ec2-info () {
    local env
    local instance
    env=$1
    instance=$2
    aws --profile ${env} ec2 describe-instances --filters "Name=tag:Name,Values=${instance}" | \
        jq '.Reservations[0].Instances[0]' | gron
}

aws-id2ip () {
    local env
    local ec2id
    env=$1
    ec2id=$2
    aws --profile ${env} ec2 describe-instances --instance-ids "${ec2id}" | \
        jq -rM '.Reservations[0].Instances[0].PrivateIpAddress'
}
