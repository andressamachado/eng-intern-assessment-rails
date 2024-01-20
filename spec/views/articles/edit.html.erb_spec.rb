require 'rails_helper'

# RSpec Style Guide [https://github.com/rubocop/rspec-style-guide]
# Specify desired behaviour for the ArticlesController#edit action.
RSpec.describe "articles/edit", type: :view do

  # Article instance used throughout the tests
  before(:all) do
    @article = Article.create(
                          title: 'I love code, but I suck at it',
                          content: 'Dude, sucking is the first step to being sorta good at something',
                          author: 'Finn the Human')
    assign(:object, @article)
  end

  after(:all) do
    Article.destroy_all
  end

  it "displays page heading" do
    render
    expect(rendered).to have_css("h1", text: "Editing article")
  end

  it "renders _form partial for an Article instance" do
    render
    expect(view).to render_template(:partial => "_form", :count => 1)
  end

  it "renders _form partial with filled in values for Article`s title" do
    render
    expect(rendered).to have_field('article_title', :with => 'I love code, but I suck at it')
  end

  it "renders _form partial with filled in values for Article`s content" do
    render
    expect(rendered).to have_field('article_content', :with => 'Dude, sucking is the first step to being sorta good at something')
  end

  it "renders _form partial with filled in values for Article`s author" do
    render
    expect(rendered).to have_field('article_author', :with => 'Finn the Human')
  end

  it "renders _form partial with filled in values for Article`s date" do
    render
    # Date format from ISO 8601 documentation: https://apidock.com/ruby/DateTime/strftime
    expect(rendered).to have_field('article_date', :with => Date.today.strftime('%FT%T'))
  end

  it "displays a button to update Article" do
    render
    expect(rendered).to have_button('Update Article')
  end

  it "displays a link to show the Article" do
    render
    expect(rendered).to have_link('Show this article', href: article_path(@article))
  end

  it "displays a link to go back to Articles" do
    render
    expect(rendered).to have_link('Back to articles', href: articles_path)
  end
end
