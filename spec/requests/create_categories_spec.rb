require 'rails_helper'

RSpec.describe "CreateCategories", type: :request do
  describe "GET /create_categories" do
    it "works! (now write some real specs)" do
      get create_categories_path
      expect(response).to have_http_status(200)
    end
  end
end
