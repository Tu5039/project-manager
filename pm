#!/bin/bash
check1=0
check2=0
check3=0

if [[ -x "$(command -v git)" ]]
then
    echo "$(git version)"
else
    echo -e "\033[35mmissing git!\033[0m"
    check1=1
fi

if [[ -d draft ]]
then
    echo "directory draft exit"
    cd draft
    if [[ $check1 = 1 ]]
    then
        echo -e "\033[35mdraft cannot be judged as a git repo because git is missing!\033[0m"
    elif [[ $(git rev-parse --is-inside-work-tree) ]]
    then
        echo "draft is a git repo."
    else
        echo -e "\033[35mdraft is not a git repo!\033[0m"
        check2=$[check2+2]
    fi
    cd ..
else
    echo -e "\033[35mmissing directory draft!\033[0m"
    check2=$[check2+1]
fi

if [[ -d finalization ]]
then
    echo "directory finalization exit"
    cd finalization
    if [[ $check1 == 1 ]]
    then
        echo -e "\033[35mfinalization cannot be judged as a git repo because git is missing!\033[0m"
    elif [[ $(git rev-parse --is-inside-work-tree) ]]
    then
        echo "finalization is a git repo."
    else
        echo -e "\033[35mfinalization is not a git repo!\033[0m"
        check3=$[check3+2]
    fi
    cd ..
else
    echo -e "\033[35mmissing directory finalization!\033[0m"
    check3=$[check3+1]
fi

if [[ "$1" == "test" ]]
then 
    if [[ $[check1+check2+check3] == 0 ]] 
    then 
        echo -e "\033[32mtest passed !!!\033[0m"
    else 
        echo -e "\033[31mtest failed !!!\033[0m"
    fi
    exit 0
elif [[ $check1 == 1 ]]
then 
    echo -e "\033[31m[error 1]: missing git.\033[0m"
    exit 1
fi


case $1 in
init|\-i)
    git init draft
    git init finalization
;;
clone)
    read -p "please input draft repo: " draft_repo_url draft
    read -p "please input finalization repo: " finalization_repo_url finalization
    git clone $draft_repo_url
    git clone $finalization_repo_url
;;
config)
    case $2 in
    draft)
        cd draft
        git remote add origin $3
        cd ..
    ;;
    finalization)
        cd finalization
        git remote add origin $3
        cd ..
    ;;
    esac
;;
pull|\-p)
    if [[ [$check2%2] == 1 ]]
    then 
        echo -e "\033[31mderetory draft doesn't exist!\033[0m"
    elif [[ $check2 -ge 2 ]]
    then
        echo -e "\033[31mdraft is not a git repo!\033[0m"
    else
        cd draft
        git fetch
        git pull
    fi
    if [[ [$check3%2] == 1 ]]
    then 
        echo -e "\033[31mderetory finalization doesn't exist!\033[0m"
    elif [[ $check3 -ge 2 ]]
    then
        echo -e "\033[31mfinalization is not a git repo!\033[0m"
    else
        cd ../finalization
        git fetch
        git pull
        cd ..
    fi
;;
draft|\-d) # to finish if and fi
    if [[ [$check2%2] == 1 ]]
    then 
        echo -e "\033[31mderetory draft doesn't exist!\033[0m"
    elif  [[ $check2 -ge 2 ]]
    then
        echo -e "\033[31mdraft is not a git repo!\033[0m"
    else
        echo "project manager is saving draft!"
        cd draft 
        git add * && git commit -a -m "auto commit by project manager" 
        git push --all origin
        cd ..
    fi
    ;;
finalization|\-f)
    if [[ [$check3%2] == 1 ]]
    then 
        echo -e "\033[31mderetory finalization doesn't exist!\033[0m"
    else
        echo "project manager is saving publish"
        cp -r ./draft/* ./finalization/
    fi
    ;;
"")
    echo -e "\033[31mmissing operation\033[0m"
    ;;
*)
    echo "invalid operation!"
    exit 1
    ;;
esac
