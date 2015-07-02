class Post < ActiveRecord::Base
  belongs_to :user
  has_many :post_tags
  has_many :tags, through: :post_tags
  has_many :comments

  def tag_names
    # self.tags.map { |x| x.name }.join(", ")
    self.tags.map(&:name).join(", ")
  end

  def tag_names=(new_tags)
    new_tags = new_tags.split(", ")
    tag_models = new_tags.map { |tag| Tag.find_or_create_by(name: tag) }
    self.tags = tag_models
  end
end
