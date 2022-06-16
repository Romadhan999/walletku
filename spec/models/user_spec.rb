require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is not valid without a email' do
    user = User.new(email: nil)
    expect(user).to_not be_valid
  end

  it 'is not valid with username length less than 6' do
    user = User.new(username: 'mr123')
    expect(user).to_not be_valid
  end

  it 'is not valid with username length more than 25' do
    user = User.new(username: 'mr_jorge_antonio112233999123')
    expect(user).to_not be_valid
  end
end
