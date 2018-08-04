require 'spec_helper'

describe User do
  before{ @user = User.new(name:"xjw",email:"xjw@sohu.com")}

  subject{ @user }

  it {should respond_to(:name)}
  it {should respond_to(:email)}
  it {should be_valid}

  describe "when name is not present" do
    before {@user.name = ''}
    it {should_not be_valid}
  end

  describe "when name is too long" do
    before {@user.name = 'a'*51}
    it {should_not be_valid}
  end

  describe "when email is not present" do
    before {@user.email = ''}
    it {should_not be_valid}
  end

  describe "when email format is invalid" do
    it "should be invalid" do
        addresses = %w[user@foo 123%a@sina.com zs_li^+@sina.com]
        addresses.each{|invalid_add|
            @user.email = invalid_add
            expect(@user).not_to be_valid
        }

    end
  end

  describe "when email format is valid" do
    it "should be valid" do
        addresses = %w[user@foo.com a123a@sina.com zs_li@sina.com.cn]
        addresses.each{|valid_add|
            @user.email = valid_add
            expect(@user).to be_valid
        }

    end
  end

  describe "when email addresses is already taken" do
    before do
        user_with_same_email = @user.dup
        user_with_same_email.save
    end    
    it {should_not be_valid}
  end
  
end
