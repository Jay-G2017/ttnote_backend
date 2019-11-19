# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

project_names = ['项目1', '项目2', '项目3', '项目4', '项目5', '项目6']
user = User.first
ca_work = user.categories.find_by_name('工作')
unless ca_work
  ca_work = Category.create(name: '工作', user_id: user.id)
  project_names.each do |name|
    p = ca_work.projects.build(name: name, desc: name)
    p.user = user
    p.save
    p.todos.create(name: '完成工作', title_id: -1)
  end
end

ca_work = user.categories.find_by_name('生活')
unless ca_work
  ca_work = Category.create(name: '生活', user_id: user.id)
  project_names.each do |name|
    p = ca_work.projects.build(name: name, desc: name)
    p.user = user
    p.save
    p.todos.create(name: '享受生活', title_id: -1)
  end
end

puts 'finish'
