require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'should return error message when email is not unique' do
      User.create(
        first_name:"Joe",
        last_name:"Tester",
        email:"test@test.com",
        password:"testing",
        password_confirmation: "testing"
      )
      user = User.new(
        first_name:"Jane",
        last_name:"Tester",
        email:"TEST@TEST.com",
        password:"testing",
        password_confirmation:"testing"
      )
      user.valid?
      expect(user.errors[:email]).to include("has already been taken")
    end

    it 'should return error message when fisrt_name is nil' do
      user = User.new(
        first_name:nil,
        last_name:"Tester",
        email:"TEST@TEST.com",
        password:"testing",
        password_confirmation:"testing"
      )
      user.valid?
      expect(user.errors[:first_name]).to include("can't be blank")
    end

    it 'should return error message when last_name is nil' do
      user = User.new(
        first_name:"jane",
        last_name:nil,
        email:"TEST@TEST.com",
        password:"testing",
        password_confirmation:"testing"
      )
      user.valid?
      expect(user.errors[:last_name]).to include("can't be blank")
    end

    it 'should return error message when email is nil' do
      user = User.new(
        first_name:"Jane",
        last_name:"Tester",
        email:nil,
        password:"testing",
        password_confirmation:"testing"
      )
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

    it 'should return error message when password is nil' do
      user = User.new(
        first_name:"Jane",
        last_name:"Tester",
        email:"TEST@TEST.com",
        password:nil,
        password_confirmation:"testing"
      )
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end

    it 'should return error message when password_confirmation is nil' do
      user = User.new(
        first_name:nil,
        last_name:"Tester",
        email:"TEST@TEST.com",
        password:"testing",
        password_confirmation:nil
      )
      user.valid?
      expect(user.errors[:password_confirmation]).to include("can't be blank")
    end

    it "should return error message when password and password_confirmation doesn't match" do
      user = User.new(
        first_name:nil,
        last_name:"Tester",
        email:"TEST@TEST.com",
        password:"testing",
        password_confirmation:"sdjkasd"
      )
      user.valid?
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end

    it "should return error message when password length less than 6" do
      user = User.new(
        first_name:"Jane",
        last_name:"Tester",
        email:"TEST@TEST.com",
        password:"test",
        password_confirmation:"test"
      )
      user.valid?
      expect(user.errors[:password]).to include("is too short (minimum is 6 characters)")
    end

    describe '.authenticate_with_credentials' do
      it "spaces before email should successfully login user with same email" do
        User.create(
          first_name:"Joe",
          last_name:"Tester",
          email:"test@test.com",
          password:"testing",
          password_confirmation: "testing"
        )
        user = User.authenticate_with_credentials("test@test.com","testing")
        expect(user).to eql(User.find_by_email("test@test.com"))
      end

      it "user login Email shouldn't care about case (lower vs upper)" do
        User.create(
          first_name:"Joe",
          last_name:"Tester",
          email:"eXample@domain.COM",
          password:"testing",
          password_confirmation: "testing"
        )
        user = User.authenticate_with_credentials("EXAMPLe@DOMAIN.CoM","testing")
        expect(user).to eql(User.find_by_email("eXample@domain.COM"))
      end
    end

  end
end
