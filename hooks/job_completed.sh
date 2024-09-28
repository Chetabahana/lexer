#!/usr/bin/env bash
# Structure: Cell Types – Modulo 6

hr='------------------------------------------------------------------------------------'

echo -e "\n$hr\nFinal Space\n$hr"
df -h

if [ -d /mnt/disks/platform/usr/local/sbin ]; then
    
  echo -e "\n$hr\nDocker images\n$hr"
  /mnt/disks/platform/usr/bin/docker image ls

  cd /home/runner/_site && rm -rf .github
  set -a && . /home/runner/_site/.env && set +a

  #Jekyll Quick Reference https://gist.github.com/DrOctogon/bfb6e392aa5654c63d12
  REMOTE_REPO="https://${GITHUB_ACTOR}:${GITHUB_ACCESS_TOKEN}@github.com/${TARGET_REPOSITORY}.git"
  git remote set-url origin ${REMOTE_REPO} && git config --global --add safe.directory "/home/runner/_site"
  #JEKYLL_GITHUB_TOKEN=${GITHUB_ACCESS_TOKEN} DISABLE_WHITELIST=true jekyll build --profile -t -p /home/runner/_site/_plugins -d /home/runner/_site/docs
  
  echo -e "\n$hr\nBuilded Pages\n$hr"
  if [[ "${TARGET_REPOSITORY}" == "eq19/eq19.github.io" ]]; then echo "www.eq19.com" > /home/runner/_site/docs/CNAME; fi
  touch /home/runner/_site/docs/.nojekyll && ls -al /home/runner/_site/docs

  echo -e "\n$hr\nFinal Network\n$hr"
  /mnt/disks/platform/usr/bin/docker network inspect bridge

  echo -e "\n$hr\nNext Workflow\n$hr"
  git config --global user.name "${GITHUB_ACTOR}"
  git config --global user.email "${GITHUB_ACTOR}@users.noreply.github.com"
  git add . && git commit --allow-empty -m "${LATEST_COMMIT}" > /dev/null && git push

  if [ $? -eq 0 ]; then
    echo -e "\njob completed"
  else
    REMOTE_REPO="https://${GITHUB_ACTOR}:${GITHUB_ACCESS_TOKEN}@github.com/${GITHUB_REPOSITORY}.git"
    cd ${GITHUB_WORKSPACE} && git add . && git commit --allow-empty -m "rerun actions due to commit rejection" && git push
  fi

fi
