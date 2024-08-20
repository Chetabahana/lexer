#!/usr/bin/env bash
# Structure: Cell Types – Modulo 6

hr='------------------------------------------------------------------------------------'

echo -e "\n$hr\nFinal Space\n$hr"
df -h

if [ ! -d /mnt/disks/platform/usr/bin ]; then
  
  echo ${GITHUB_ACCESS_TOKEN} | gh auth login --with-token
  gh run rerun ${GITHUB_RUN_ID} --debug

else

  echo -e "\n$hr\nFinal Cloud\n$hr"
  /mnt/disks/platform/usr/bin/gcloud info
  
  echo -e "\n$hr\nFinal Network\n$hr"
  /mnt/disks/platform/usr/bin/docker network inspect bridge

  # Set update workflow
  git config --global user.name "${GITHUB_ACTOR}"
  git config --global --add safe.directory ${GITHUB_WORKSPACE}
  git config --global user.email "${GITHUB_ACTOR}@users.noreply.github.com"

  REMOTE_REPO="https://${GITHUB_ACTOR}:${GITHUB_ACCESS_TOKEN}@github.com/${GITHUB_REPOSITORY_OWNER}/${NEXT_TARGET}.git"
  #git init --initial-branch=master > /dev/null && git remote add origin ${REMOTE_REPO}
  #git add . && git commit -m "jekyll build" > /dev/null && git push --force ${REMOTE_REPO} master:gh-pages

  echo -e "\njob completed"

fi 
