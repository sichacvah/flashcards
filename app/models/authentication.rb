class Authentication < ActiveRecord::Base
  belongs_to :user, foreign_key: "authentication"
end
