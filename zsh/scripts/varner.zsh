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

deploy_prod_changes() {
  g master
  g pull
  g back
  g develop
  g pull
  g back
  git log --merges master..develop --format='- %w(80, 2, 2)%b' | pbcopy
}

replicate_production_db() {
  rake db:drop db:create
  heroku pg:backups capture -r production;
  curl -o $(date '+%Y-%m-%d').dump `heroku pg:backups public-url -r production`;
  pg_restore --verbose --clean --no-acl --no-owner -h localhost -d myshop-backend_development $(date '+%Y-%m-%d').dump
  rake db:migrate db:test:prepare
}
