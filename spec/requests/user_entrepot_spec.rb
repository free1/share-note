require 'spec_helper'

describe "用户日常功能" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }


  describe "关注与被关注功能" do
    let(:other_user) { FactoryGirl.create(:user) }

    describe "关注被关注者数量显示" do

      before do
        other_user.follow!(user)
        visit user_path(user)
      end

      it { should have_link("0 关注", href: following_user_path(user)) }
      it { should have_link("1 粉丝", href: followers_user_path(user)) }
    end

    describe "关注与取消关注按钮" do

      describe "点击关注一个用户" do
        before { visit user_path(other_user) }

        it "关注的用户数量加一" do
          expect { click_button "关注" }.to change(user.followed_users, :count).by(1)
        end

        it "被关注用户的粉丝列表加一" do
          expect { click_button "关注" }.to change(other_user.followers, :count).by(1)
        end
      end

      describe "点击取消关注一个用户" do
        before do
          user.follow!(other_user)
          visit user_path(other_user)
        end

        it "关注的用户数量减一" do
          expect { click_button "取消关注" }.to change(user.followed_users, :count).by(-1)
        end

        it "被关注用户的粉丝列表减一" do
          expect { click_button "取消关注" }.to change(other_user.followers, :count).by(-1)
        end
      end
    end

    describe "关注列表和粉丝列表页面" do
      before { user.follow!(other_user) }

      describe "关注列表显示" do
        before { visit following_user_path(user) }

        it { should have_selector('h2', text: '关注') }
        it { should have_link(other_user.name, href: user_path(other_user)) }
      end

      describe "粉丝列表显示" do
        before { visit followers_user_path(other_user) }

        it { should have_selector('h2', text: '粉丝') }
        it { should have_link(user.name, href: user_path(user)) }
      end
    end
  end


  describe "签到功能" do
    before { visit qiandao_user_path(user) }

    it { should have_content("已连续签到 0 天") }

    describe "点击签到链接" do
      before { visit qiandao_execute_user_path(user) }
      
      describe "连续点击签到链接" do
        before { visit qiandao_execute_user_path(user) }

        it { should have_link("今天已签到") }
        it { should have_selector('div.alert.alert-error', text: '今天已经签到了哦!') }
        it { should have_content("已连续签到 1 天") }
      end

      describe "再次访问签到页面"  do
        before { visit qiandao_user_path(user) }

        it { should have_link("今天已签到") }
        it { should have_content("已连续签到 1 天") }
      end
    end
  end


  # describe "站内提醒" do
  #   let!(:topic) { FactoryGirl.create(:post, user_id: user.id, title: "aa", content: "topic", kind: "tool") }
  #   before { visit post_path(topic) }
      
    
  # end


  describe "我的收藏功能" do
    let!(:topic) { FactoryGirl.create(:post, user_id: user.id, title: "aa", content: "topic", kind: "tool") }
    before do 
      visit post_path(topic)
      click_link "收藏" 
    end

    it { should have_link("取消收藏") }

    describe "查看我的收藏" do
      before { visit favorite_user_path(user) }

      it { should have_content("我的收藏") }
      it { should have_link("aa") }
      it { should have_content("topic") }
    end
  end
  
end