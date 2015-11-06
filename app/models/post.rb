require 'friendly_id'

class Post < ActiveRecord::Base
belongs_to :user
has_many :comments
extend FriendlyId
  friendly_id :title, use: :slugged
 validates :title, presence: true, length: { minimum: 3 }
    validates :body, presence: true, length: { minimum: 30 }
	self.per_page = 5
	scope :visible, -> { where :visible => false }
	
 def self.by_date(date, period = nil)
    if date.is_a?(Hash)
      keys = [:day, :month, :year].select {|key| date.include?(key) }
      period = keys.first.to_s
      date = DateTime.new(*keys.reverse.map {|key| date[key].to_i })
    end

  end	


  def self.organize_posts
    Hash.new.tap do |entries|
      years.each do |year|
        months_for(year).each do |month|
          date = DateTime.new(year, month)
          entries[year] ||= []
          entries[year] << [date.strftime("%B"), self.by_date(date, :month)]
        end
      end
    end
  end
	
	def self.years
    visible.map {|e| e.published_at.year }.uniq
  end

  def self.months_for(year)
    visible.select {|e| e.published_at.year == year }.map {|e| e.published_at.month }.uniq
  end
	
end
