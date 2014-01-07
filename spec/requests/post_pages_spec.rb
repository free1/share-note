require 'spec_helper'

describe "文章功能" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "显示所有分类文章" do

    let!(:topic1) { FactoryGirl.create(:post, user_id: user.id, title: "aa", content: "topic1", kind: "tool") }
    let!(:topic2) { FactoryGirl.create(:post, user_id: user.id, title: "bb", content: "topic2", kind: "suibi") }

    before { visit root_path }

    it { should have_content(topic1.content) }
    it { should have_content(topic2.content) }
    it { should have_content(user.posts.count) }

    describe "点击文章分类显示其下的文章，不显示其他分类文章" do
      before { visit "?kind=tool" }

      it { should have_content(topic1.content) }
      it { should_not have_content(topic2.content) }
      it { should have_content(user.posts.count) }
    end
  end


  describe "创建文章" do

    before { visit "/posts/post_kind?kind=suibi" }

    context "输入无效的内容时" do
      it "不应该创建文章" do
        expect { click_button "分享笔记" }.not_to change(Post, :count)
      end

      describe "显示错误信息" do
        before { click_button "分享笔记" }
        it { should have_content("文章标题和内容都不可以为空哦！") }
      end
    end

    context "输入有效的内容时" do
      before do
        fill_in "主题",     with: "测试"
        fill_in "内容",     with: "文章内容"
      end

      it "应该创建文章" do
        expect { click_button "分享笔记" }.to change(Post, :count).by(1)
      end
    end
  end


  describe "显示单个文章" do
    let!(:topic1) { FactoryGirl.create(:post, user_id: user.id, title: "aa", content: "topic1", kind: "tool") }

    before { visit post_path(topic1) }

    it { should have_content(topic1.content) }
    it { should have_link("收藏") }
    it { should have_link("赞") }

    describe "当点击收藏文章时" do
      before { click_link "收藏" }

      it { should have_link("取消收藏") }
    end

    describe "当点击赞文章时" do
      before { click_link "赞" }

      it { should have_link("已赞") }
    end
  end

end