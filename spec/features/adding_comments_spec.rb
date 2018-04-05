require "rails_helper"

RSpec.feature "Adding reviews to articles" do
  before do
    @john = User.create(email: "john@example.com",password: "password")
    @marie = User.create(email: "marie@example.com",password: "password")
    @article = Article.create!(title: "The first article", body: "Lorem ipsum dolor sit amet, consecteur.",user: @john)
  end

  scenario "permits a signed in user to write a review" do
    login_as(@marie)

    visit "/"

    click_link @article.title
    fill_in "New Comment", with: "An amazing article"
    click_button "Add Comment"

    expect(page).to have_content("Comment has been created")
    expect(page).to have_content("An amazing article")
    expect(page.current_path).to eq(article_path(@article.id))
  end
end