get_data_files() {
  DATE=${1:-$(date '+%Y-%m-%d')}
  echo "download data files for $DATE"
  files=($(ssh varner-upload@tatooine.hyper.no ls -l | grep $DATE))
  for file in $files; do
    scp varner-upload@tatooine.hyper.no:$file ~/Downloads/varner
  done
}

get_file_reports () {
  DATE=${1:-$(date '+%Y-%m-%d')}
  SERVER=${2:-production}
  echo "download file reports for $DATE in $SERVER"
  s3cmd ls s3://myshop-backend-${SERVER}/uploads/logs/imports/varner/ |
  grep $DATE |
  sed -n 's_.*\(s3://.*\)_\1_p' |
  xargs s3cmd get --skip-existing
}
