class ContentItem < ActiveRecord::Base
  CONTENT_TYPES = ["BlogPost", "NewsItem", "RadioShow", "Event", "Untyped"]
  belongs_to :person, :foreign_key => "author"

  validates_presence_of :title, :url, :body
  validates_uniqueness_of :title

  acts_as_url :title
#  , :only_when_blank => true

  def to_param
    url # or whatever you set :url_attribute to
  end

end
