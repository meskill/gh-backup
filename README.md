# Repositories backup

## How does it work

- uses [ghorg](https://github.com/gabrie30/ghorg) to copy all of the repos from github to local folder
- walks from all of the repos and pushes it to sourcehut (if repo not exists on sourcehut it will be automatically created)
- it stores bare git minimum to restore repository from the backup
- script copies only repositories with topic `gh-backup`

## Usage

### Run backup

1. Make sure you have ssh keys for sourcehut added to your local ssh instance
2. Create and copy [Github Personal Access Token](https://github.com/settings/tokens) with every `repo` access. Make it live for short time
3. Run script `./backup.sh`
4. Enter PAT when asked
5. Verify the output
6. Delete token after usage from the github page

### Add a new repo to backup

1. Go to the github page of the repo
2. Click gear icon on the right, next to about
3. Add topic `gh-backup`

### Restore repository from the backup

1. Run command `git clone <path_to_backup_repo> <target_path_to_folder>`
2. Run `git remote rm origin` to remove link to backup repo or `git remote set-url origin <url_to_new_origin>`
