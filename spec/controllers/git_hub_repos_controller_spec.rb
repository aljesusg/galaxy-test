require 'rails_helper'

RSpec.describe GitHubReposController, type: :controller do

  describe "GET #show" do
    it "returns http success" do
      get :show
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #refresh" do
    it "returns http success" do
      get :refresh
      expect(response).to have_http_status(:success)
    end
  end

end
