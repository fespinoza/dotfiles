alias get_file_reports="s3cmd ls s3://myshop-backend-production/uploads/logs/imports/varner/ | grep $(date '+%Y-%m-%d') | sed -n 's_.*\(s3://.*\)_\1_p' | xargs s3cmd get"

_download_varner_import_data_files() {
  files=($(ssh varner-upload@tatooine.hyper.no ls -l | grep $(date '+%Y-%m-%d') | sed 's/.*\(VG_.*\)/\1/'))
  for file in $files; do
    scp varner-upload@tatooine.hyper.no:$file ~/Downloads/varner
  done
  for file in $files; do
    LC_ALL=C sed -i.csv  's/;/,/g' $file
  done
}

alias get_data_files="_download_varner_import_data_files"

alias deploy-prod-changes="git log --merges master..develop --format='- %w(80, 2, 2)%b' | pbcopy"

