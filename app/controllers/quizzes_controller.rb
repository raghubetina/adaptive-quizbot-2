class QuizzesController < ApplicationController
  def index
    matching_quizzes = Quiz.all

    @list_of_quizzes = matching_quizzes.order({ :created_at => :desc })

    render({ :template => "quizzes/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_quizzes = Quiz.where({ :id => the_id })

    @the_quiz = matching_quizzes.at(0)

    render({ :template => "quizzes/show" })
  end

  def create
    the_quiz = Quiz.new
    the_quiz.topic = params.fetch("query_topic")

    if the_quiz.valid?
      the_quiz.save

      system_message = Message.new
      system_message.quiz_id = the_quiz.id
      system_message.role = "system"
      system_message.body = "You are a #{the_quiz.topic} tutor. Ask the user five questions to assess their #{the_quiz.topic} proficiency. Start with an easy question. After each answer, increase or decrease the difficulty of the next question based on how well the user answered.

In the end, provide a score between 0 and 10."
      system_message.save

      user_message = Message.new
      user_message.quiz_id = the_quiz.id
      user_message.role = "user"
      user_message.body = "Can you assess my #{the_quiz.topic} proficiency?"
      user_message.save

      chat = OpenAI::Chat.new
      chat.model = "o3"
      chat.system(system_message.body)
      chat.user(user_message.body)
      llm_content = chat.assistant!

      assistant_message = Message.new
      assistant_message.quiz_id = the_quiz.id
      assistant_message.role = "assistant"
      assistant_message.body = llm_content
      assistant_message.save

      redirect_to("/quizzes/#{the_quiz.id}", { :notice => "Quiz created successfully." })
    else
      redirect_to("/quizzes", { :alert => the_quiz.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_quiz = Quiz.where({ :id => the_id }).at(0)

    the_quiz.topic = params.fetch("query_topic")

    if the_quiz.valid?
      the_quiz.save
      redirect_to("/quizzes/#{the_quiz.id}", { :notice => "Quiz updated successfully."} )
    else
      redirect_to("/quizzes/#{the_quiz.id}", { :alert => the_quiz.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_quiz = Quiz.where({ :id => the_id }).at(0)

    the_quiz.destroy

    redirect_to("/quizzes", { :notice => "Quiz deleted successfully."} )
  end
end
