require 'friendly_id'

class Post < ActiveRecord::Base
belongs_to :user
has_many :comments
extend FriendlyId
  friendly_id :title, use: :slugged
 validates :title, presence: true, length: { minimum: 3 }
 validates :body, presence: true, length: { minimum: 30 }

 before_save :set_published_at
	self.per_page = 10
	scope :visible, -> { where :visible => false }
	
 def self.by_date(date, period = nil)
    if date.is_a?(Hash)
      keys = [:day, :month, :year].select {|key| date.include?(key) }
      period = keys.first.to_s
      date = DateTime.new(*keys.reverse.map {|key| date[key].to_i })
    end
    time = date.to_time.in_time_zone
    
  end	


  def self.organize_posts
    Hash.new.tap do |entries|
      years.each do |year|
        months_for(year).each do |month|
          date = DateTime.new(year, month)
          entries[year] ||= []
          entries[year] << [date.strftime("%B"), self.visible.by_date(date, :month)]
		  puts entries[0]
        end
      end
    end
  end
  
private	

	def self.years
    visible.map {|e| e.published_at.year }.uniq
  end

  def self.months_for(year)
    visible.select {|e| e.published_at.year == year }.map {|e| e.published_at.month }.uniq
  end
  
  

  def set_published_at
    self.published_at = Time.now if published_at.blank?
  end
end
