if test "$1" = ""; then
  echo "Please specify a github user to pull keys from"
  exit 1
fi

if ! which vektra > /dev/null; then
  echo "Please download the vektra tool first"
  echo "HINT: curl -L http://get.vektra.io | sh"
  exit 1
fi

set -e -x

echo "Checking that your system is ready for vektra..."

if ! vektra outpost:check; then
  echo "You need to install Virtualbox first!"
  exit 1
fi

echo "Cloning test repo..."

if test -e note; then
  echo "Detecting existing note directory, using it."
else
  git clone https://github.com/vektra/homesteading-note.git note
fi

cd note

echo "Booting vektra outpost instance..."
vektra boot

GITHUB_USER=$1

vektra -o setup -g $GITHUB_USER

eval $(vektra -o env)

vektra addons:enable postgres
vektra --app note addons:bind postgres

vektra init -n note

echo "yes" | git push outpost master

vektra run rake db:migrate db:seed

vektra logs

open "http://note.outpost.vektra.io"
