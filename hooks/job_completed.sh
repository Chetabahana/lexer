#!/usr/bin/env bash
# Structure: Cell Types – Modulo 6

hr='------------------------------------------------------------------------------------'

echo -e "\n$hr\nFinal Space\n$hr"
df -h

if [ -d /mnt/disks/platform/usr/local/sbin ]; then
    
  echo -e "\n$hr\nDocker images\n$hr"
  /mnt/disks/platform/usr/bin/docker image ls

  echo -e "\n$hr\nFinal Network\n$hr"
  /mnt/disks/platform/usr/bin/docker network inspect bridge

  echo -e "\n$hr\nNext Workflow\n$hr"
  cd /home/runner/_site && rm -rf .github
  set -a && . /home/runner/_site/.env && set +a

  echo -e "\n$hr\nBUILD\n$hr"
  #Jekyll Quick Reference https://gist.github.com/DrOctogon/bfb6e392aa5654c63d12
  JEKYLL_GITHUB_TOKEN=${GITHUB_ACCESS_TOKEN} DISABLE_WHITELIST=true jekyll build --profile -t -p /home/runner/_site/_plugins -d /home/runner/_site/docs
  
  touch /home/runner/_site/docs/.nojekyll
  if [[ "${TARGET_REPOSITORY}" == "eq19/eq19.github.io" ]]; then echo "www.eq19.com" > /home/runner/_site/docs/CNAME; fi

  git config --global user.name "${GITHUB_ACTOR}"
  git config --global --add safe.directory "/home/runner/_site"
  git config --global user.email "${GITHUB_ACTOR}@users.noreply.github.com"

  REMOTE_REPO="https://${GITHUB_ACTOR}:${GITHUB_ACCESS_TOKEN}@github.com/${TARGET_REPOSITORY}.git"
  rm -rf .git && git init --initial-branch=master > /dev/null && git remote add origin ${REMOTE_REPO}
  git add . && git commit -m "action pages jekyll build" > /dev/null && git push --force ${REMOTE_REPO} master:gh-pages

  echo -e "\njob completed"

fi
