echo
echo "Check for Vektra CLI..."
read -p "$ which vektra" -n 1

if ! which vektra; then

  read -p "Did not find Vektra CLI. Download now? [y/n]: " DOWNLOAD

  if [[ "$DOWNLOAD" != "y" ]]; then

    echo
    echo "Please download the Vektra CLI manually and rerun this script."
    echo "HINT: curl -L https://get.vektra.com | sh"
    exit 1

  else

    echo
    echo "Download Vektra CLI to current directory..."
    read -p "$ curl -L https://get.vektra.com | sh" -n 1
    curl -L https://get.vektra.com | sh

    echo
    echo "Move Vektra CLI to somewhere in your PATH, like ~/bin..."
    read -p "$ mv ./vektra " CLIPATH
    mv ./vektra $CLIPATH

    echo
    echo "Check for Vektra CLI..."
    read -p "$ which vektra" -n 1

    if ! which vektra; then
      echo "Cannot find Vektra CLI. Make sure it is in your PATH rerun this script."
      exit 1
    fi
  fi
fi

set -e

echo
echo "Check for VirtualBox..."
read -p "$ vektra outpost:check" -n 1

if ! vektra outpost:check; then
  echo "Please install VirtualBox and rerun this script."
  echo "HINT: https://www.virtualbox.org/wiki/Downloads"
  exit 1
fi

echo
echo "Check for existing test repo..."
read -p "$ test -e note" -n 1

if test -e note; then
  echo "Found existing test repo, using it."
else
  echo "Clone test repo..."
  read -p "$ git clone https://github.com/vektra/homesteading-note.git note" -n 1
  git clone https://github.com/vektra/homesteading-note.git note
fi

read -p "$ cd ./note" -n 1
cd ./note

echo
echo "Boot Vektra outpost instance..."
read -p "$ vektra boot"
vektra boot

echo
echo "Setup Vektra outpost instance with SSH keys from GitHub..."
read -p "$ vektra -o setup -g " GITHUB_USER
vektra -o setup -g $GITHUB_USER

echo
echo "Setup Vektra CLI to default to talk to outpost instance..."
read -p "$ eval \$(vektra -o env)"
eval $(vektra -o env)

echo
echo "Enable PostgreSQL addon..."
read -p "$ vektra addons:enable postgres" -n 1
vektra addons:enable postgres

echo
echo "Bind PostgreSQL addon to note app..."
read -p "$ vektra --app note addons:bind postgres"
vektra --app note addons:bind postgres

echo
echo "Initialize note app to be deployed..."
read -p "$ vektra init -n note" -n 1
if ! git remote -v | grep outpost > /dev/null; then
  vektra init -n note
fi

echo
echo "Deploy note app..."
read -p "$ git push outpost master" -n 1
git push outpost master

echo
echo "Setup database for note app"
read -p "vektra run rake db:migrate db:seed" -n 1
vektra run rake db:migrate db:seed

echo
echo "View app logs..."
read -p "$ vektra logs" -n 1
vektra logs

echo
echo "Open note app in a web browser..."
read -p "open \"http://note.outpost.vektra.io\""
open "http://note.outpost.vektra.io"
