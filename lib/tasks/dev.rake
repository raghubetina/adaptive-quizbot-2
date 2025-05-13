desc "Fill the database tables with some sample data"
task({ :sample_data => :environment }) do
  if Rails.env.development?
    Quiz.destroy_all
    Message.destroy_all
  end

  q = Quiz.new
  q.topic = "Ruby"
  q.save

  q = Quiz.new
  q.topic = "Python"
  q.save
  
  q = Quiz.new
  q.topic = "CSS"
  q.save

  Quiz.all.each do |a_quiz|
    rand(3..5).times do
      m = Message.new
      m.body = "Can you assess my Ruby proficiency?"
      m.role = ["user", "assistant", "system"].sample
      m.quiz_id = a_quiz.id
      m.save
    end
  end
end
