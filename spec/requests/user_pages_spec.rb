require 'spec_helper'

describe "用户系统功能" do

  subject { page }


  describe "注册页面" do
    before { visit signup_path }

    it { should have_content("注册") }

    describe "注册功能" do
      let(:submit) { "创建我的帐号" }

      context "输入无效的信息时" do
        it "不应该创建用户" do
          expect { click_button submit }.not_to change(User, :count)
        end

        describe "点击创建按钮" do
          before { click_button submit }

          it { should have_content('注册') }
        end
      end

      context "输入有效的信息时" do
        before do
          fill_in "电子邮件地址",      with: "free1@qq.com"
          fill_in "创建密码",         with: "111111"
          fill_in "确认密码",         with: "111111"
          fill_in "选择你的用户名",    with: "free1"
        end

        it "应该创建一个新用户" do
          expect { click_button submit }.to change(User, :count).by(1)
        end

        describe "点击创建按钮" do
          before { click_button submit }

          it { should have_selector('div.alert.alert-success', text: '恭喜你注册帐号成功！') }
        end
      end
    end
  end


  describe "登录页面" do
    before { visit signin_path }

    it { should have_content("登录") }

    context "输入无效的信息时" do
      before { click_button "登录" }

      it { should have_content("登录") } 
    end

    context "输入有效的信息时" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in "电子邮件地址",     with: user.email.upcase
        fill_in "输入密码",        with: user.password
        click_button "登录"
      end

      it { should have_content(user.name) }
      it { should have_link('我的主页', href: user_path(user)) }
      it { should have_link('退出', href: signout_path) }
      it { should_not have_link('登录', href: signin_path) }

      describe "用户退出" do
        before { click_link "退出" }
        it { should have_content("登录") }
      end
    end
  end


  describe "编辑用户资料页面" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit edit_user_path(user) 
    end

    it { should have_content("个人资料设置") }
    it { should have_content(user.name) }

    context "直接点击更新资料按钮后" do
      before { click_button "更新资料" }

      it { should have_selector('div.alert.alert-success', text: '更新资料成功!') }
    end

    context "修改一些资料点击更新按钮后" do
      let(:qq_num) { 747549945 }
      let(:city) { "jinan" }
      before do
        fill_in "QQ",    with: qq_num
        fill_in "城市",   with: city
        click_button "更新资料"
      end

      it { should have_selector('div.alert.alert-success', text: '更新资料成功!') }
      specify { expect(user.reload.qq).to  eq qq_num }
      specify { expect(user.reload.city).to  eq city }
    end
  end


  describe "显示个人用户资料页面" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_content(user.name) }
    it { should have_content(user.email) }
  end


  describe "显示所有用户资料页面" do
    before do
      sign_in FactoryGirl.create(:user)
      FactoryGirl.create(:user, name: "aa", email: "aa@qq.com")
      FactoryGirl.create(:user, name: "bb", email: "bb@qq.com")
      visit users_path
    end

    it { should have_content("目前已经有 3 位会员加入了share") }

    it "所有用户列表" do
      User.all.each do |user|
        expect(page).to have_selector('li', text: user.name)
      end
    end

    describe "分页" do
      before(:all) { 30.times { FactoryGirl.create(:user) } }
      after(:all) { User.delete_all }

      it { should have_selector('div.pagination') }

      it "所有用户列表" do
        User.paginate(page: 1).each do |user|
          expect(page).to have_selector('li', text: user.name)
        end
      end
    end
  end
  
end