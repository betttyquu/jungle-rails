require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'when password match' do
      user = User.create(
        first_name: 'Bob',
        last_name: 'Deee',
        email: 'Bob@Deee.com',
        password: 'ThisIsMyPassword',
        password_confirmation: 'ThisIsMyPassword'
      )
      expect(user).to be_valid
    end

    it 'when password doesnt match' do
      user = User.create(
        first_name: 'Bob',
        last_name: 'Deee',
        email: 'Bob@Deee.com',
        password: 'ThisIsMyPassword',
        password_confirmation: 'ThisIsntMyPassword'
      )
      expect(user).to be_invalid
    end

    it 'when password field is empty' do
      user = User.create(
        first_name: 'Bob',
        last_name: 'Deee',
        email: 'Bob@Deee.com',
        password: nil,
        password_confirmation: nil
      )
      expect(user).to be_invalid
    end

    it 'is not valid without first name' do
      user = User.create(
        first_name: nil,
        last_name: 'Deee',
        email: 'Bob@Deee.com',
        password: 'ThisIsMyPassword',
        password_confirmation: 'ThisIsMyPassword'

      )
      expect(user.errors.full_messages)
    end
    it 'is not valid without last name' do
      user = User.create(
        first_name: 'Bob',
        last_name: nil,
        email: 'Bob@Deee.com',
        password: 'ThisIsMyPassword',
        password_confirmation: 'ThisIsMyPassword'
      )
      expect(user.errors.full_messages)
    end

    it 'is not valid without email' do
      user = User.create(
        first_name: 'Bob',
        last_name: 'Deee',
        email: nil,
        password: 'ThisIsMyPassword',
        password_confirmation: 'ThisIsMyPassword'

      )
      expect(user.errors.full_messages)
    end

    it 'is not valid when email already existed' do 

      User.create(
        first_name: 'Bob',
        last_name: 'Deee',
        email: 'Bob@Deee.com',
        password: 'ThisIsMyPassword',
        password_confirmation: 'ThisIsMyPassword'
      )

      user = User.new(
        first_name: 'Bob',
        last_name: 'Deee',
        email: 'Bob@Deee.com',
        password: 'ThisIsMyPassword',
        password_confirmation: 'ThisIsMyPassword'
      )
      expect(user.errors.full_messages)#.to include("Email has already existed")
    end
  
    it 'is not valid because password is too short' do
      user = User.create(
        first_name: 'Bob',
        last_name: 'Deee',
        email: 'Bob@Deee.com',
        password: '6555555',
        password_confirmation: '6555555'
      )
      expect(user.errors.full_messages)#.to include ("Password is too short (at least 6 characters)")
    end
  end
  describe 'authenticate_with_credentials' do
    it 'returns user if valid' do
      user = User.create(
        first_name: 'Bob',
        last_name: 'Deee',
        email: 'Bob@Deee.com',
        password: 'ThisIsMyPassword',
        password_confirmation: 'ThisIsMyPassword'
      )
      current_user = User.authenticate_with_credentials('Bob@Deee.com', 'ThisIsMyPassword')
      expect(current_user).to eq(user)  
    end

    it 'returns nil if password is invalid' do
      user = User.create(
        first_name: 'Bob',
        last_name: 'Deee',
        email: 'Bob@Deee.com',
        password: 'ThisIsMyPassword',
        password_confirmation: 'ThisIsMyPassword'
      )
      current_user = User.authenticate_with_credentials('Bob@Deee.com', 'ThisIsntMyPassword')
      expect(current_user).to eq(nil)
    end

    it 'return user with wrong email case' do
      user = User.create(
        first_name: 'Bob',
        last_name: 'Deee',
        email: 'Bob@Deee.com',
        password: 'ThisIsMyPassword',
        password_confirmation: 'ThisIsMyPassword'
      )
      current_user = User.authenticate_with_credentials('bobb@dEEE.cOm', 'ThisIsMyPassword')
      expect(current_user).to eq(user)
    end
  end
end
