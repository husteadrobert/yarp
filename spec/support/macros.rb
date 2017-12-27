def sign_in(user=nil)
  user ||= Fabricate(:user)
  visit login_path
  fill_in "email", with: user.email
  fill_in "password", with: user.password
  click_button "Sign In"
end