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

echo "Booting vektra outpost instance..."
vektra boot

echo "Cloning test repo..."
git clone https://github.com/vektra/homesteading-note.git note

cd note

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
