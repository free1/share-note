require 'spec_helper'

describe "评论与站内提醒功能" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  let(:other_user) { FactoryGirl.create(:user) }
  let!(:topic) { FactoryGirl.create(:post, user_id: user.id, title: "aa", content: "topic", kind: "tool") }
  before do
    sign_in other_user
    visit post_path(topic) 
  end

  it { should have_selector("h3", text: "还没有回复哦") }
  it { should have_link("0") }


  describe "创建显示评论并查看顶部站内提醒变化" do
    before do
      fill_in "添加回复",      with: "评论内容"
      click_button "回复"
    end

    it { should have_content(other_user.name) }
    it { should have_content("评论内容") }

    describe "查看用户的提醒情况" do
      before do
        click_link "退出"
        sign_in user
        visit root_path
      end

      it { should have_link("1") }

      describe "查看最近收到的提醒" do
        before { visit notifications_path }

        it { should have_link(other_user.name) }
        it { should have_link("评论内容") }
      end
    end
  end
 
end