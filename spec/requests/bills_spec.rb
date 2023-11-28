require 'rails_helper'

RSpec.describe "Bills", type: :request do
  before(:all) do
    @user = FactoryBot.create(:user)
    @bill = FactoryBot.create(:bill)
  end

  describe "GET /index or get bills_path" do
    it "renders the index view" do
      FactoryBot.create_list(:bill, 10)
      get bills_path
      expect(response).to render_template(:index)
    end
  end

  describe "GET /show or get bill_path" do
    it "renders the :show template" do
      get bill_path(id: @bill.id)
      expect(response).to render_template(:show)
    end
    it "redirects to the index path if the bill id is invalid" do
      get bill_path(id: 5000) #an ID that doesn't exist
      expect(response).to redirect_to bill_path
    end
  end

  describe "GET /new or get new_bill_path" do
    it "renders the :new template"do
      get new_bill_path(@bill)
      expect(response).to render_template(:new)
    end
  end

  describe "post bills_path with invalid data" do
    it "does not save a new entry or redirect" do
      bill_attributes = FactoryBot.attributes_for(:bill)
      bill_attributes.delete(:measure)
      expect { post bills_path, params: {bill: bill_attributes}
      }.to_not change(Bill, :count)
      expect(response).to render_template(:new)
    end
  end

  describe "get edit_bill_path" do
    it "renders the :edit template"do
      get edit_bill_path(@bill)
      expect(response).to render_template(:edit)
    end
  end

  describe "put bill_path with valid data" do
    it "updates an entry and redirects to the show path for the bill"do
      expect { put bill_path(@bill.id), params: {bill: {measure: "AB81"}}
    }.not_to change(Bill, :count)
      expect(response).to redirect_to bill_path(id: Bill.last.id)
      @bill.reload
      expect(@bill.measure).to eq("AB81")
    end
  end

  describe "put bill_path with invalid data" do
    it "does not update the bill record or redirect"do
      bill_attributes = FactoryBot.attributes_for(:bill)
      bill_attributes.delete(:product_name)
      expect { post bills_path, params: {bill: bill_attributes}
      }.to_not change(Bill, :count)
      expect(response).to render_template(:new)
    end
  end

  describe "GET /delete or delete a bill record" do
    it "deletes a bill record"do
      delete bill_path(@bill)
      expect(response).to redirect_to(bills_path)
    end
  end


  describe "GET /index" do
    it "returns http success" do
      get "/bills/index"
      expect(response).to have_http_status(302)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get bill_path(@bill.id)
      expect(response).to render_template(:show)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/bills/new"
      expect(response).to have_http_status(200)
      expect(response).to render_template(:new)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get edit_bill_path(@bill.id)
      expect(response).to have_http_status(200)
      expect(response).to render_template(:edit)
    end
  end

  describe "GET /delete" do
    it "returns http success" do
      delete bill_path(@bill.id)
      get "/bills/delete"
      expect(response).to have_http_status(302)

    end
  end


end



