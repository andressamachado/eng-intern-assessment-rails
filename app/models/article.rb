# Article model
class Article < ApplicationRecord
  # Ensure Title and Content fields are present.
  validates :title, :content, presence: true
  # Ensure Content is unique.
  validates :content, uniqueness: true
  # Ensure Title is unique per Author.
  validates :title, uniqueness: { scope: :author, message: 'must be unique per author' }

  # Create a new Article instance.
  def self.create(title:, content:, author: 'Anonymous', date: Date.today)
    article = Article.new(author: author, title: title, content: content, date: date)
    article.save

    return article
  end

  # TODO: Search for articles by Title or Content.
  def self.search(term) end
end
