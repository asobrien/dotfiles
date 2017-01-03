#!/bin/bash

# THESE ARE A SET OF SCRIPTS TO DO RELEASE

# This is host specific
REPO_SALT="${HOME}/Code/jwp/provisioning"
REPO_PILLAR="${HOME}/Code/jwp/pillar"
#GH_USER="asobrien"

# function gf_fea_start {
#         feature_name="$GH_USER/$1"
#         git checkout develop && \
#         git fetch origin && \
#         git pull --rebase=preserve origin develop && \
#         git checkout -b feature/$feature_name;
# }

# function gf_fea_prov_finish {
#         feature_name="matt/$1"
#         git checkout develop && \
#         git fetch origin && \
#         git pull --rebase=preserve origin develop && \
#         git checkout feature/$feature_name && \
#         git pull --rebase=preserve origin feature/$feature_name
#         git push origin -u feature/$feature_name && \
#         git rebase develop && \
#         git push origin feature/$feature_name --force-with-lease && \
#         git pull-request -b develop
#         git checkout develop
# }

# function gf_fea_pill_finish {
#         feature_name="matt/$1"
#         git checkout develop && \
#         git fetch origin && \
#         git pull --rebase=preserve origin develop && \
#         git checkout feature/$feature_name && \
#         git pull --rebase=preserve origin feature/$feature_name
#         git push origin -u feature/$feature_name  && \
#         git rebase develop && \
#         git push origin feature/$feature_name --force-with-lease && \
#         git checkout develop && \
#         git merge --no-ff feature/$feature_name  && \
#         git pull --rebase=preserve origin develop  && \
#         git push origin develop
# }


# function gf_hotfix_start {
#         hotfix_date=`date +"%Y.%m.%d"`
#         hotfix_name="$hotfix_date.$1"
#         echo $hotfix_name
#         git checkout master && \
#         git fetch origin && \
#         git pull --rebase=preserve origin master && \
#         git checkout -b hotfix/$hotfix_name && \
#         git push origin -u hotfix/$hotfix_name
# }

# function gf_hotfix_finish {
#         hotfix_date=`date +"%Y.%m.%d"`
#         hotfix_name="$hotfix_date.$1"
#         echo $hotfix_name
#         git fetch origin && \
#         git checkout hotfix/$hotfix_name && \git
#         git pull --rebase=preserve origin hotfix/$hotfix_name &&\
#         git pull --rebase=preserve origin master &&\
#         git checkout master && \
#         git pull --ff-only origin master && \
#         git merge --no-ff hotfix/$hotfix_name && \
#         git push origin master && \
#         git tag -a $hotfix_name && \
#         git push --tags origin && \
#         git fetch origin && \
#         git checkout develop && \
#         git pull --rebase=preserve origin develop && \
#         git pull --rebase=preserve origin master && \
#         git push origin develop --force-with-lease
# }


### THIS IS WHAT WE USE

# USED THIS IS NICE !!!
function gf_rel_start {
        release_date=`date +"%Y.%m.%d"`
        git checkout develop && \
        git fetch origin && \
        git pull --rebase=preserve origin develop && \
        release_count=`git tag | grep $release_date | wc -l | sed 's/^ *//;s/ *$//'` && \
        release_count=$((release_count+1)) && \
        release_name="${release_date}.${release_count}" && \
        echo "CREATING RELEASE: ${release_name}" && \
        git checkout -b release/$release_name && \
        git push origin -u release/$release_name && \
        echo && \
        echo "RELEASE BRANCH: release/${release_name}"
}

# FINISH THE RELEASE -- the latest release
function gf_rel_finish {
        # release_date=`date +"%Y.%m.%d"`
        # release_name="$release_date.$1"
        # echo $release_name
        # TODO: if release_name not defined you must specify
        git fetch origin && \
        git checkout release/$release_name && \
        git pull --rebase=preserve origin release/$release_name && \
        git checkout master && \
        git pull --ff-only origin master && \
        git merge --no-ff release/$release_name && \
        git push origin master && \
        git tag -a $release_name  && \
        git push --tags origin && \
        git fetch origin && \
        git checkout develop && \
        git pull --rebase=preserve origin develop && \
        git pull --rebase=preserve origin master && \
        git push origin develop --force-with-lease
}

# something similar could be done for pillar with "Merge branch"
function gf_rel_notes {
        local last_tag
        last_tag=`git tag | grep "^[0-9]\{4\}\.[0-9]\{2\}\.[0-9]\{2\}\..*$" | sort -n | tail -n 1`
        git log --grep "Merge pull request" "$last_tag"..HEAD --pretty="* %s&&>>  %b" \
                | sed "s/Merge pull request/PR/g" | sed "s/from .*&&>> //g"
}



# RELEASE BOTH
# for each repo:
# do
#     cd repo && gf_rel_start
# done

# PREP STG
# ssh salt-stg
# cd repo
# # prob need to chgrp
# git fetch origin
# git checkout $release

# # Run tests
# cd pillar
# _tests/run

# # Run MINION TESTS
# sudo salt '*' -b 5 state.highstate  # --fail-hard hurts too much
