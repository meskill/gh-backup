#! /usr/bin/env fish

read -P "Input Github Personal Access Token: " gh_token

echo "Cloning all the repos from github to local folder"

./ghorg clone meskill \
  --config=./ghorg-config.yml \
  --ghorgignore-path=(pwd)/ghorgignore \
  --path=(pwd) \
  --token=$gh_token

and echo "Pushing all the repos to the sourcehut"

and for repo in ./**/HEAD
  set -l dir (dirname $repo)

  pushd $dir

  git remote get-url sourcehut 2> /dev/null

  if test $status -ne 0
    set -l github_url (git remote get-url origin)
    string match -riq "git@[^:]+:(?<repository_name>[^.]+).git" -- $github_url

    git remote add sourcehut "git@git.sr.ht:~$repository_name"
  end

  git push sourcehut --all
  popd
end