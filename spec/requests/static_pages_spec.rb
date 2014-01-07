require 'spec_helper'

describe "静态页面" do

  subject { page }

  describe "不同首页的不同情况" do

    it "当用户没有登录时" do
      visit root_path
      expect(page).to have_content('欢迎来到 NODE。')
    end

    context "当用户已经登录时" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        sign_in user
        visit root_path 
      end
      
      it { should have_content('首页') }
    end

  end

end