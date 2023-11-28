require 'rails_helper'

RSpec.describe "UsersControllers", type: :request do

  describe "get users_path" do
    it "renders the index view" do
      FactoryBot.create_list(:user, 9)
      get(users_path) # users GET users#index
      expect(response).to render_template(:index)
    end
  end

  describe "get user_path" do
    it "renders the :show template" do
      user = FactoryBot.create(:user)
      get(user_path(:id => user.id)) # user GET users#show
      expect(response).to render_template(:show)
    end

    it "redirects to the index path if the user id is invalid" do
      get(user_path(:id => 5000)) #an ID that doesn't exist
      expect(response).to redirect_to(users_path)
    end
  end

  describe "get new_user_path" do
    it "renders the :new template" do
      get(new_user_path) # new_user GET users#new
      expect(response).to render_template(:new)
    end
  end

  describe "get edit_user_path" do
    it "renders the :edit template" do
      user = FactoryBot.create(:user)
      # ^ get a user before
      get(edit_user_path(:id => user.id)) #edit_user GET users#edit
      expect(response).to(render_template(:edit))
    end
  end

  describe "post users_path with valid data" do
    it "saves a new entry and redirects to the show path for the entry" do
      user_attributes = FactoryBot.attributes_for(:user)
      expect { post(users_path, params: {user: user_attributes})   }.to change(User, :count)
      expect(response).to redirect_to user_path(id: User.last.id)
    end
  end

  describe "post users_path with invalid data" do
    it "does not save a new entry or redirect" do
      user_attributes = FactoryBot.attributes_for(:user)
      user_attributes.delete(:first_name)
      expect { post users_path, params: {user: user_attributes}
    }.to_not change(User, :count)
      expect(response).to render_template(:new)
    end
  end

  describe "put user_path with valid data" do
    it "updates an entry and redirects to the show path for the user" do
       user = FactoryBot.create(:user)
       put(user_path(:id => user.id), :params => {:user => {:category => 'Low Priority'}})
       user.reload
       expect(user.category).to eq(user.category)
    end
  end

  describe "put user_path with invalid data" do
    it "does not update the user record or redirect" do
      user = FactoryBot.create(:user)
      put(user_path(:id => user.id), :params => {:user => {:category => 123}})
      user.reload
      expect(user.category).not_to eq(123)
    end
  end

  describe "delete a user record" do
    it "deletes a user record" do
      user = FactoryBot.create(:user)
      delete(user_path(user))
      expect(response).to redirect_to(users_path)
    end
  end

end
