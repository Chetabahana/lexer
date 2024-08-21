#!/usr/bin/env bash
# Structure: Cell Types – Modulo 6

hr='------------------------------------------------------------------------------------'

# Set update workflow
git config --global user.name "${GITHUB_ACTOR}"
git config --global --add safe.directory ${GITHUB_WORKSPACE}
git config --global user.email "${GITHUB_ACTOR}@users.noreply.github.com"

if [ ! -d /mnt/disks/platform/usr/bin ]; then
  
  REMOTE_REPO="https://${GITHUB_ACTOR}:${GITHUB_ACCESS_TOKEN}@github.com/${GITHUB_REPOSITORY}.git"
  cd ${GITHUB_WORKSPACE} && git remote set-url origin ${REMOTE_REPO}
  git commit --allow-empty -m "rerun actions" && git push

else

  echo -e "\n$hr\nFinal Space\n$hr"
  df -h

  echo -e "\n$hr\nFinal Cloud\n$hr"
  /mnt/disks/platform/usr/bin/gcloud info
  
  echo -e "\n$hr\nFinal Network\n$hr"
  /mnt/disks/platform/usr/bin/docker network inspect bridge

  REMOTE_REPO="https://${GITHUB_ACTOR}:${GITHUB_ACCESS_TOKEN}@github.com/${GITHUB_REPOSITORY_OWNER}/${NEXT_TARGET}.git"
  #cd /home/runner/_site && git init --initial-branch=master > /dev/null && git remote add origin ${REMOTE_REPO}
  #git add . && git commit -m "jekyll build" > /dev/null && git push --force ${REMOTE_REPO} master:gh-pages

  echo -e "\njob completed"

fi 
