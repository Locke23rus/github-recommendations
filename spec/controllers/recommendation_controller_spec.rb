require 'spec_helper'

describe RecommendationController do

  describe "GET 'skip'" do
    it "returns http success" do
      get 'skip'
      response.should be_success
    end
  end

end
