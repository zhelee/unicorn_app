class Post < ActiveRecord::Base
  attr_accessible :content, :title
  searchable do
    text :title, :content
  end
end
