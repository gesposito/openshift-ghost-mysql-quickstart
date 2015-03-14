# Update Cartdrige files
#
# chmod +x upgrade-ghost-openshift.sh
# ./upgrade-ghost-openshift.sh
#
# https://gist.github.com/brettof86/48895e95d8c68148ae74

#!/usr/bin/env bash

if [ ! -f package.json ]; then
	echo "This script must be run from the ghost blog directory"
	exit 1
fi

ZIP_URL=https://ghost.org/zip/ghost-latest.zip
PROJ_DIR=$(pwd)
TMP_DIR=$(mktemp -d -t ghost)
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

echo -n "Checking current version..."
LOCAL_VER=$(grep version package.json | awk '{print $3}' | egrep -o '\d+.\d+.\d+')
REMOTE_VER=$(curl -LIs https://ghost.org/zip/ghost-latest.zip | \
	grep -i 'ghost-' | \
	tail -n 1 | \
	egrep -o "\d+\.\d+\.\d+" 2> /dev/null)
echo -e "${GREEN}done${NC}"

if [ $LOCAL_VER = $REMOTE_VER ]; then
	echo -e "${RED}You already have the latest version! ($LOCAL_VER) ${NC}"
	exit 1
fi

cd $TMP_DIR
echo -n "Downloading latest ghost..."
curl -LO $ZIP_URL > /dev/null 2>&1
echo -e "${GREEN}done${NC}"

echo -n "Unzipping latest ghost..."
unzip ghost-latest.zip > /dev/null
echo -e "${GREEN}done${NC}"

# back to the project directory
cd - > /dev/null

for f in index.js package.json core content/themes/casper; do
	echo -n "Updating $f..."
	\rm -rf "$f"
	\cp -r "$TMP_DIR/$f" "$f"
	echo -e "${GREEN}done${NC}"
done

echo -n "Fixing package.json..."
sed -i '' 's/"main": "\.\/core\/index"/"main": "index.js"/g' package.json
echo -e "${GREEN}done${NC}"

echo
echo -e "${GREEN}All done!${NC}"
echo -e "Review the changes with ${YELLOW}git status${NC} then push to openshift"
#echo -e "${YELLOW}HINT${NC}: if you don't see any changes then you might already have the latest version"
echo "ENJOY!"
