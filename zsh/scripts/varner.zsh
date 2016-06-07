alias get_file_reports="s3cmd ls s3://myshop-backend-production/uploads/logs/imports/varner/ | grep $(date '+%Y-%m-%d') | sed -n 's_.*\(s3://.*\)_\1_p' | xargs s3cmd get"

alias get_file_reports_staging="s3cmd ls s3://myshop-backend-staging/uploads/logs/imports/varner/ | grep $(date '+%Y-%m-%d') | sed -n 's_.*\(s3://.*\)_\1_p' | xargs s3cmd get"

get_data_files() {
  files=($(ssh varner-upload@tatooine.hyper.no ls -l | grep $(date '+%Y-%m-%d')))
  for file in $files; do
    scp varner-upload@tatooine.hyper.no:$file ~/Downloads/varner
  done
}
