class HomeController < ApplicationController
  def index
    @posts = Post.search do
      fulltext params[:search]
    end.results
  end
end
