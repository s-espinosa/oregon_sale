require 'spec_helper'

describe "Sessions", js: true do
  let!(:p1) {Product.create( name: "Rations", price: 24,
  description: "Good for one 'splorer.")}
  let!(:p2) {Product.create( name: "Eggs", price: 5,
  description: "Farm fresh and ready to consume.")}
  let!(:p3) {Product.create( name: "Apples", price: 19,
  description: "Great for a snack!")}

  context "when user logs in" do
    context "if user exists" do
      it "logs in user" do

        User.create email: 'user@oregonsale.com',
          password: 'password',
          password_confirmation: 'password',
          role: 'admin'

        visit '/login'
        fill_in 'email', with: 'user@oregonsale.com'
        fill_in 'password', with: 'password'
        click_button "Log in"

        expect(current_path).to eq root_path
      end
    end

    context "if user does not exist" do
      it "returns error message" do
        visit '/login'
        fill_in 'email', with: 'user@oregonsale.com'
        fill_in 'password', with: 'password'
        click_button "Log in"

        page.should have_content "Email or password was invalid"
      end
    end
  end

  context "when user is logged in" do
    it "can log out" do
      User.create email: 'user@oregonsale.com',
          password: 'password',
          password_confirmation: 'password',
          role: 'admin'

      visit '/login'
      fill_in 'email', with: 'user@oregonsale.com'
      fill_in 'password', with: 'password'
      click_button "Log in"

      click_link "Log out"

      page.should have_content "Logged out."
    end
  end
end