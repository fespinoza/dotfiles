alias get_file_reports="s3cmd ls s3://myshop-backend-production/uploads/logs/imports/varner/ | grep $(date '+%Y-%m-%d') | sed -n 's_.*\(s3://.*\)_\1_p' | xargs s3cmd get"

alias get_file_reports_staging="s3cmd ls s3://myshop-backend-staging/uploads/logs/imports/varner/ | grep $(date '+%Y-%m-%d') | sed -n 's_.*\(s3://.*\)_\1_p' | xargs s3cmd get"

_download_varner_import_data_files() {
  files=($(ssh varner-upload@tatooine.hyper.no ls -l | grep $(date '+%Y-%m-%d')))
  for file in $files; do
    scp varner-upload@tatooine.hyper.no:$file ~/Downloads/varner
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
  git not-released | pbcopy
}

replicate_production_db() {
  archive_development_db()
  rake db:drop db:create
  FILE=production_$(date '+%Y-%m-%d').dump
  if [[ -f $FILE ]]; then
    echo "$FILE already present, skipping"
  else
    echo "downloading $FILE"
    heroku pg:backups capture -r production;
    curl -o $FILE `heroku pg:backups public-url -r production`;
  fi
  echo "restoring $FILE"
  pg_restore --verbose --clean --no-acl --no-owner -h localhost -d myshop-backend_development $FILE
  rake db:migrate db:test:prepare
  rails runner debugging.rb
}

archive_development_db() {
  FILE=development_$(date '+%Y-%m-%d').dump
  pg_dump -Fp myshop-backend_development > $FILE
}

restore_development_db() {
  rake db:drop db:create
  FILE=development_$(date '+%Y-%m-%d').dump
  psql myshop-backend_development < development_2016-04-29.dump
  rake db:test:prepare
  rails runner debugging.rb
}

replicate_staging_db() {
  archive_development_db()
  rake db:drop db:create
  FILE=staging_$(date '+%Y-%m-%d').dump
  if [[ -f $FILE ]]; then
    echo "$FILE already present, skipping"
  else
    echo "downloading $FILE"
    heroku pg:backups capture -r staging;
    curl -o $FILE `heroku pg:backups public-url -r staging`;
  fi
  echo "restoring $FILE"
  pg_restore --verbose --clean --no-acl --no-owner -h localhost -d myshop-backend_development $FILE
  rake db:migrate db:test:prepare
  rails runner debugging.rb
}

run_varner_import() {
  date
  rake master_data:varner:import
  date
  say "master data import completed"
  osascript -e 'display notification "Import completed" with title "Master Data Import"'
}

run_staging_varner_import() {
  date
  staging run rake master_data:varner:import
  date
  say "STAGING: master data import completed"
  osascript -e 'STAGING display notification "Import completed" with title "Master Data Import"'
}

run_production_varner_import() {
  date
  production run rake master_data:varner:import
  date
  say "PRODUCTION: master data import completed"
  osascript -e 'PRODUCTION display notification "Import completed" with title "Master Data Import"'
}

r_server() {
  rails s -b lvh.me
}

gcop() {
  guard -P rubocop
}
