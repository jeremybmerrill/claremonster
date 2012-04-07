class Upvote < ActiveRecord::Base

  validates_presence_of :user_id

  belongs_to :user 
  belongs_to :wish
end
