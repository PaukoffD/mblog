class AddVisiblePublishedatAndSummaryToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :visible, :boolean, :default => false
    add_column :posts, :published_at, :datetime
    add_column :posts, :summary, :text
  end
end
