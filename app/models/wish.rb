class Wish < ActiveRecord::Base

validates_uniqueness_of :description, :scope => :title
validates_presence_of :title, :description, :threshold

belongs_to :user
has_many :upvotes
has_many :comments, :dependent => :destroy

end
