require 'rails_helper'

# RSpec Style Guide [https://github.com/rubocop/rspec-style-guide]
# Specify desired behaviour for the ArticlesController#index action.
RSpec.describe "articles/index", type: :view do

    # Article instances used throughout the tests
    before(:all) do
      @article1 = Article.create(
                            title: 'Is it weird that I love code?',
                            content: 'Something weird might just be something familiar viewed from a different angle.',
                            author: 'Marceline`s Mom')
      @article2 = Article.create(
                            title: 'We must learn to roll with the punches',
                            content: 'You won`t be able to tell if everything is going to be totally haywire.',
                            author: 'BMO')
      assign(:articles, Article.all)
    end

    after(:all) do
      Article.destroy_all
    end

    it "displays page heading" do
      render
      expect(rendered).to have_css("h1", text: "Articles")
    end

    it "displays a link to create a new Article" do
      render
      expect(rendered).to have_link('New article', href: new_article_path)
    end

    it "displays table header" do
      render
      expect(rendered).to have_css("thead", :count => 1)
    end

    it "displays table body" do
      render
      expect(rendered).to have_css("tbody", :count => 1)
    end

    # https://stackoverflow.com/questions/25300706/how-to-test-page-content-within-an-array-of-capybara-elements
    it "displays article titles in table" do
    end

end
