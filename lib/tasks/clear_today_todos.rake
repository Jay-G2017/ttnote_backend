namespace :redis do
  desc '每天零点清除掉已经完成的今日任务'
  task clear_today_todos_crontab: :environment do
    User.find_each do |user|
      user.clear_finished_today_todos
    end
    puts 'success'
  end
end