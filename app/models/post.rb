class Post < ActiveRecord::Base
  attr_accessible :content, :title
  searchable do
    text :title, :body
  end
end
