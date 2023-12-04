require 'rails_helper'

RSpec.describe "Measures", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/measures/index"
      expect(response).to have_http_status(:success)
    end
  end

end
