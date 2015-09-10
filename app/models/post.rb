class Post < ActiveRecord::Base
belongs_to :user
has_many :comments

 validates :title, presence: true, length: { minimum: 3 }
    validates :body, presence: true, length: { minimum: 30 }
	self.per_page = 5
end
