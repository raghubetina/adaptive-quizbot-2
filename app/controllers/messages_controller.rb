class MessagesController < ApplicationController
  def index
    matching_messages = Message.all

    @list_of_messages = matching_messages.order({ :created_at => :desc })

    render({ :template => "messages/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_messages = Message.where({ :id => the_id })

    @the_message = matching_messages.at(0)

    render({ :template => "messages/show" })
  end

  def create
    the_message = Message.new
    the_message.body = params.fetch("query_body")
    the_message.role = "user"
    the_message.quiz_id = params.fetch("query_quiz_id")

    if the_message.valid?
      the_message.save

      chat = OpenAI::Chat.new

      # Get all the old messages

      # Message.where({ :quiz_id => the_message.quiz_id })

      existing_messages = the_message.quiz.messages.order(:created_at)

      # Loop through, and for each one
      # Add it to the Chat
      existing_messages.each do |a_message|
        if a_message.role == "system"
          chat.system(a_message.body)
        elsif a_message.role = "user"
          chat.user(a_message.body)
        else
          chat.assistant(a_message.body)
        end
      end

      # Dispatch the next API request
      next_llm_content = chat.assistant!
  
      # Save it
      next_message = Message.new
      next_message.quiz_id = the_message.quiz_id
      next_message.role = "assistant"
      next_message.body = next_llm_content
      next_message.save

      redirect_to("/quizzes/#{the_message.quiz_id}", { :notice => "Message created successfully." })
    else
      redirect_to("/messages", { :alert => the_message.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_message = Message.where({ :id => the_id }).at(0)

    the_message.body = params.fetch("query_body")
    the_message.role = params.fetch("query_role")
    the_message.quiz_id = params.fetch("query_quiz_id")

    if the_message.valid?
      the_message.save
      redirect_to("/messages/#{the_message.id}", { :notice => "Message updated successfully."} )
    else
      redirect_to("/messages/#{the_message.id}", { :alert => the_message.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_message = Message.where({ :id => the_id }).at(0)

    the_message.destroy

    redirect_to("/messages", { :notice => "Message deleted successfully."} )
  end
end
