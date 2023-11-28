require 'rails_helper'

RSpec.describe Bill, type: :model do

  subject {
    Bill.new(
      :measure => "AB75",
      :subject => "Cleanliness",
      :author => "Mr. Smith",
      :status => "Passed",
      :user => FactoryBot.create(:user)
    )
  }

  it "is valid with valid attributes" do
    expect(subject).to(be_valid)
  end

  it "is not valid without a measure" do
    subject.measure=nil
    expect(subject).to_not(be_valid)
  end

  it "is not valid without a subject" do
    subject.subject=nil
    expect(subject).to_not(be_valid)
  end

  it "is not valid without an author" do
    subject.author=nil
    expect(subject).to_not(be_valid)
  end

  it "is not valid without a status" do
    subject.status=nil
    expect(subject).to_not(be_valid)
  end

  it 'is not valid without a user' do
    subject.user = nil
    expect(subject).to_not(be_valid)
  end

end
