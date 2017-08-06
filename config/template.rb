db = ask("Which do you use database adapter? 'mysql2' or 'pg'")
db = "sqlite3" if db == ""
gem db
copy_file "config/database.#{db}.yml", 'config/database.yml', force: true
