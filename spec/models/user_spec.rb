require 'rails_helper'

RSpec.describe User, type: :model do

  subject {
    User.new(
        first_name: "Michael",
        last_name: "Smith",
        category: "High Priority",
    )}

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a first_name" do
    subject.first_name=nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a last_name" do
    subject.last_name=nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a category" do
    subject.category=nil
    expect(subject).to_not(be_valid)
  end

  it "returns the correct full_name" do
    expect(subject.full_name).to eq("Michael Smith")
  end

end
