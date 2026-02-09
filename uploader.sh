#!/bin/bash
# Watches /staging and pushes to GitHub PPA
# handles -march= / -mtune= architecture-specific distribution
# TODO set -euxo nounset -o pipefail

REPO_URL="https://${GH_TOKEN}@github.com/InnovAnon-Inc/ppa.git"
STAGING="/staging"

cd /tmp
git clone "$REPO_URL" ppa_repo

inotifywait -m -e moved_to --format '%f' "$STAGING" | while read -r DEB_FILE
do
    echo "📦 New package detected: $DEB_FILE. Pushing to PPA..."
    cp "$STAGING/$DEB_FILE" ppa_repo/
    cd ppa_repo
    git add "$DEB_FILE"
    git commit -m "Automated Forge: $DEB_FILE"
    git push origin main
    cd ..
done
