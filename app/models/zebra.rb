# == Schema Information
#
# Table name: zebras
#
#  id         :bigint           not null, primary key
#  age        :integer
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Zebra < ApplicationRecord
end
