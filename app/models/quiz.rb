# == Schema Information
#
# Table name: quizzes
#
#  id         :bigint           not null, primary key
#  topic      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Quiz < ApplicationRecord
  # has_many :messages, :class_name => "Message", :foreign_key => "quiz_id"
  
  # has_many :messages, :foreign_key => "quiz_id"
  
  has_many  :messages, dependent: :destroy

  validates :topic, presence: true

end
