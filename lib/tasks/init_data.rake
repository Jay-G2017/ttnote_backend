namespace :init_data do
  task init_tomato_user_id: :environment do
    Tomato.find_each do |tomato|
      puts "processing tomato: #{tomato.id}"
      user = tomato.todo.project.user
      tomato.user = user
      tomato.save
    end
  end
end