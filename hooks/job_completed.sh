#!/usr/bin/env bash
# Structure: Cell Types – Modulo 6

hr='------------------------------------------------------------------------------------'

echo -e "\n$hr\nFinal Space\n$hr"
df -h

echo -e "\n$hr\nFinal Cloud\n$hr"
/mnt/disks/platform/usr/bin/gcloud info
  
echo -e "\n$hr\nFinal Network\n$hr"
/mnt/disks/platform/usr/bin/docker network inspect bridge

echo -e "\n$hr\nNext Workflow\n$hr"
git config --global user.name "${GITHUB_ACTOR}"
git config --global --add safe.directory ${GITHUB_WORKSPACE}
git config --global user.email "${GITHUB_ACTOR}@users.noreply.github.com"

REMOTE_REPO="https://${GITHUB_ACTOR}:${GITHUB_ACCESS_TOKEN}@github.com/${TARGET_REPOSITORY}.git"
cd /home/runner/_site && git init --initial-branch=master > /dev/null && git remote add origin ${REMOTE_REPO}
#git add . && git commit -m "action pages jekyll build" > /dev/null && git push --force ${REMOTE_REPO} master:gh-pages

echo -e "\njob completed"
