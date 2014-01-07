def sign_in(user, options={})
  if options[:no_capybara]
    remember_token = User.new_remember_token
    cookies[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.encrypt(remember_token))
  else
    visit signin_path
    fill_in "电子邮件地址",   with: user.email
    fill_in "输入密码",      with: user.password
    click_button "登录"
  end
end