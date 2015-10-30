require 'friendly_id'

class Post < ActiveRecord::Base
belongs_to :user
has_many :comments
extend FriendlyId
  friendly_id :title, use: :slugged
 validates :title, presence: true, length: { minimum: 3 }
    validates :body, presence: true, length: { minimum: 30 }
	self.per_page = 5
end
