class Tomato < ApplicationRecord
  belongs_to :todo
  belongs_to :user

end
