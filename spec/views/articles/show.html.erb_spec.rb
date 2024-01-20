require 'rails_helper'

# Specify desired behaviour for the ArticlesController#show action.
RSpec.describe "articles/show", type: :view do

  # Article instance used throughout the tests
  before(:all) do
    @article = Article.create(
                          title: 'Diversity',
                          content: 'People get built differently.
                                    We do not need to figure it out, we just need to respect it!',
                          author: 'Princess Bubblegum')
    assign(:object, @article)
  end

  after(:all) do
    Article.destroy_all
  end

  it "renders _article partial for an Article instance" do
    render
    # view.should render_template(:partial => "_article", :count => 1)
    expect(view).to render_template(:partial => "_article", :count => 1)
  end

  it "displays Article title" do
    render
    expect(rendered).to have_css("h1", text: @article.title)
  end

  it "displays Article author" do
    render
    expect(rendered).to have_css("p", text: @article.author)
  end

  it "displays Article content" do
    render
    expect(rendered).to have_css("p", text: @article.content)
  end

  it "displays published date" do
    render
    expect(rendered).to have_css("p", text: @article.date)
  end

  it "displays a link to edit Article" do
    render
    expect(rendered).to have_link('Edit this article', href: edit_article_path(@article))
  end

  it "displays a link to go back to Articles" do
    render
    expect(rendered).to have_link('Back to articles', href: articles_path)
  end

  it "displays a link to destroy Article" do
    render
    expect(rendered).to have_button('Destroy this article')
  end
end
