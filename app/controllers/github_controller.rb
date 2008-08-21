require 'json'
class GithubController < Application

  def index
		payload = JSON.parse(params[:payload])
		handler = Unfuddle.new(payload)
		handler.unfuddle!

		display(:success => true)
  end
  
end
