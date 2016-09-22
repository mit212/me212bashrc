alias open='gnome-open'
alias rebash='source ~/.bashrc'

gituser()
{
  if [ $# -eq 0 ]; then
    echo 'Current user is: '
    git config user.name
    git config user.email
    echo 'Usage: gituser <athena_id>'
    return 0
  fi

  case $1 in
  peterkty) email=peterkty@gmail.com ;;
  fishr)    email=fishr@mit.edu ;;
  *) echo "$1 is not in the list, please enter your athena id"; return 1 ;;
  esac
  
  git config --global user.name $1
  git config --global user.email $email
}

function setenv {
  echo "$1" > ~/.env
} 
alias getenv='echo $ENV'

