Given /^I am logged in as an administrator$/ do
  @admin = FactoryGirl.create(:user, email: "admin@example.com", :password => "please123", :password_confirmation => "please123")
  @admin.add_role :admin
  @visitor ||= { :email => "admin@example.com",
                 :password => "please123", :password_confirmation => "please123" }
  sign_in
end

When /^I visit the users page$/ do
  visit users_path
end

Then /^I should see a list of users$/ do
  page.should have_content @visitor[:email]
end

Then /^I should see an access denied message$/ do
  page.should have_content "Not authorized as an administrator"
end