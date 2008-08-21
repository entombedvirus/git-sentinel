require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

describe GithubController, "index action" do
  before(:each) do
    dispatch_to(GithubController, :index)
  end
end