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

end
