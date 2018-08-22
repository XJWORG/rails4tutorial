require 'spec_helper'

describe "StaticPages" do


  describe "Home Page" do
    it "should have the content 'Sample App'" do
        visit '/static_pages/home'
        expect(page).to have_content('Sample App')
    end
    it "should have the title 'Sample App'" do
        visit '/static_pages/home'
        expect(page).to have_title('StaticPages#Sample App')
    end
  end

  describe "Help Page" do
    it "should have the content 'Help'" do
        visit help_path
        expect(page).to have_content('Help')
    end
    it "should have the title 'Help'" do
        visit help_path
        expect(page).to have_title('StaticPages#Help')
    end
  end

  describe "About" do
    it "should have the content 'About'" do
        visit '/static_pages/about'
        expect(page).to have_content('About')
    end
    it "should have the title 'About'" do
        visit '/static_pages/about'
        expect(page).to have_title('StaticPages#About') 
    end
  end

  describe "for signed-in users" do
    let(:user) { FactoryGirl.create(:user) }
    before do
        FactoryGirl.create(:micropost,user: user, content: "Lorem ipsum")
        FactoryGirl.create(:micropost,user: user, content: "Dolor sit amet")
        sign_in user
        visit root_path
    end

    it "should render the user's feed" do
        user.feed.each do |item|
            expect(page).to have_selector("li##{item.id}",text: item.content)
        end
    end
  end

end
