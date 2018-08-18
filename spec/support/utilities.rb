require 'spec_helper'

    # def sign_in(user, options={})
    #     if options[:no_capybara]
    #         remember_token = User.new_remember_token
    #         cookies.permanent[:remember_token] = remember_token
    #         user.update_attribute(:remember_token, User.encrypt(remember_token))
    #         #self.current_user = user
    #     else
    #         visit signin_path
    #         fill_in "Email" , with: user.email 
    #         fill_in "Password" , with: user.password 
    #         click_button "Sign in"
    #     end
    # end