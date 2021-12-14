require 'rails_helper'

RSpec.describe User, type: :model do
  describe "User type test" do
    it 'return true if the user is admin' do
      user = User.new(username: "rspectest", email: "test@example.com", password_digest: "asds", user_type: 1)

      expect(user.is_admin?).to eq(true)
      expect(user.is_customer?).to eq(false)
    end

    it 'return true if the user is admin and customer' do
      user = User.new(username: "rspectest", email: "test@example.com", password_digest: "asds", user_type: 3)

      expect(user.is_admin?).to eq(true)
      expect(user.is_customer?).to eq(true)
    end

    it 'return true if the user is customer' do
      user = User.new(username: "rspectest", email: "test@example.com", password_digest: "asds", user_type: 2)

      expect(user.is_customer?).to eq(true)
      expect(user.is_admin?).to eq(false)
    end
  end

  describe "Validation test" do
    it 'username uniquness test' do
      username = "rspectest"
      User.new(username: username, email: "test@example.com", password_digest: "asdsss", user_type: 2).save!
      user = User.new(username: username, email: "test@example.com", password_digest: "asssds", user_type: 2)
      user.save
      expect(user).to_not be_valid
    end
  end
end
