#! /usr/bin/env nu

let gh_token = (input -s "Input Github Personal Access Token: ")

print "\nCloning all the repos from github to local folder"

./ghorg clone meskill --config ./ghorg-config.yml --ghorgignore-path ./ghorgignore --path $env.PWD --token $gh_token

print "\nPushing all the repos to the sourcehut"

ls ./**/HEAD | each {|it|
  let dir = ($it.name | path dirname)

  cd $dir

  try {
    ^git remote get-url sourcehut err> /dev/null
  } catch {|err|
    let parsed = (^git remote get-url origin | parse -r "git@[^:]+:(?<repository_name>[^.]+).git");

    ^git remote add sourcehut $"git@git.sr.ht:~($parsed.repository_name.0)"
  }

  ^git push sourcehut --all
} | ignore