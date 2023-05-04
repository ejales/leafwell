# To write your crontab file for your jobs, execute this command:
# whenever --update-crontab

every 1.day do
  runner "CheckPatients.new.call"
end