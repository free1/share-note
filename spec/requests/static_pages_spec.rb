require 'spec_helper'

describe "静态页面" do

  describe "首页" do

    it "当用户没有登录时,应该有 '欢迎来到 NODE。' 内容" do
      visit root_path
      expect(page).to have_content('欢迎来到 NODE。')
    end
  end
end