require 'spec_helper'

describe User do
  before{ @user = User.new(name:"xjw",email:"xjw@sohu.com",password:"abcabc",password_confirmation:"abcabc")}

  subject{ @user }

  it {should respond_to(:name)}
  it {should respond_to(:email)}
  it {should respond_to(:password)}
  it {should respond_to(:password_confirmation)}
  it {should respond_to(:password_digest)}
  it {should respond_to(:authenticate)}
  it {should respond_to(:remember_token)}
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
  
  describe "when password is not present" do
    before do
        @user = User.new(name: "hello123" , email: "hello123@sinas.com" , password:"" , password_confirmation:"")
    end    
    it {should_not be_valid}
  end
  
  describe "when password is does not match password_confirmation" do
    before do
        @user.password_confirmation = "mismatch"
    end    
    it {should_not be_valid}
  end

  describe "return value of authenticate method" do
    before {@user.save}

    let(:found_user){User.find_by(email: @user.email)}
    
    describe "with valid password" do
        it {should eq found_user.authenticate(@user.password)}
    end

    describe "with invalid password" do
        let(:user_for_invalid_password){ found_user.authenticate("invalid") }
        it {should_not eq user_for_invalid_password}
        it { expect(user_for_invalid_password).to be_falsey }
    end
  end

  describe "with a password that's too short" do
    before { @user.password = @user.password_confirmation = "a"*5}
    it  {should be_invalid}

  end

  # describe " remember_token should not be blank" do
  #   before { @user.save }
  #   its (:remember_token) {should_not be_blank }
  #   # 上述等同于 it { expect(@user.remember_token).not_to be_blank } 
  # end

  
end
