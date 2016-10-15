class Question < ActiveRecord::Base
  belongs_to :survey
  has_one :answer
end
