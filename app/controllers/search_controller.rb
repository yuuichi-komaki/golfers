class SearchController < ApplicationController

  def search
		@content = params[:content]
		@method = params[:method]
		@records = Course.search_for(@content, @method)
  end

end
