require 'rails_helper'

RSpec.describe "Texts", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/texts/index"
      expect(response).to have_http_status(:success)
    end
  end

end
