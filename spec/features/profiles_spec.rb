require "rails_helper"

describe "Visiting profiles" do

  before do
    @user = create(:user_with_post_and_comment)
    @post = @user.posts.first
    @comment = @user.comments.first
  end

  describe "not signed in" do
    it "shows profile" do
      visit user_path(@user)
      expect(current_path).to eq(user_path(@user))

      expect(page).to have_content(@user.name)
      expect(page).to have_content(@post.title)
      expect(page).to have_content(@comment.body)
    end
  end

  describe "signed in" do
    include Warden::Test::Helpers

    before do
      Warden.test_mode!
      login_as @user, scope: :user
    end

    after { Warden.test_reset! }

    it "shows profile" do
      visit user_path(@user)
      expect(current_path).to eq(user_path(@user))

      expect(page).to have_content(@user.name)
      expect(page).to have_content(@post.title)
      expect(page).to have_content(@comment.body)

      Warden.test_reset!
    end
  end
end
