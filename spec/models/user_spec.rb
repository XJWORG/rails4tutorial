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
  it {should respond_to(:admin) }
  it {should respond_to(:microposts)}
  it {should respond_to(:remember_token)}
  it {should respond_to(:feed)}
  it {should respond_to(:relationships)}
  it {should respond_to(:followed_users)}
  it {should respond_to(:reverse_relationships)}
  it {should respond_to(:following?)}
  it {should respond_to(:follow!)}
  it {should respond_to(:unfollowing!)}
  it {should respond_to(:followers)}
  it {should be_valid}
  it {should_not be_admin }

  describe "following" do
    let(:other_user) { FactoryGirl.create(:user)}
    before do
      @user.save
      @user.follow!(other_user)
    end

    it { should be_following(other_user)}
    its(:followed_users) { should include(other_user) }

    describe "followed user" do
      subject {other_user}
      its(:followers) { should include(@user)}
    end

    describe " and unfollowing" do
      before { @user.unfollowing!(other_user)}
      it { should_not be_following(other_user) }
      its(:followed_users) {should_not include(other_user)}
    end
  end

  describe "with admin attribute set to 'true' " do
    before do
      @user.save!
      @user.toggle!(:admin)
    end

    it {should be_admin}

  end

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

  describe "micropost associations" do
    before{ @user.save}
    let!(:old_micropost) do
      FactoryGirl.create(:micropost , user: @user , created_at: 1.day.ago)
    end
    let!(:new_micropost) do
      FactoryGirl.create(:micropost , user: @user , created_at: 1.hour.ago)
    end

    it "should have the right microposts in the right order" do
      expect(@user.microposts.to_a).to eq [new_micropost, old_micropost]
    end

    it "should destroy associated microposts" do
      microposts = @user.microposts.to_a
      @user.destroy
      expect(microposts).not_to be_empty
      microposts.each do |micropost|
        expect(Micropost.where(id: micropost.id)).to be_empty
      end
    end

    describe "status" do
      let(:unfollowed_post) do
        FactoryGirl.create(:micropost, user:FactoryGirl.create(:user))
      end

      its (:feed) { should include(new_micropost) }
      its (:feed) { should include(old_micropost) }
      its (:feed) { should_not include(unfollowed_post)}
    end
  end

end
