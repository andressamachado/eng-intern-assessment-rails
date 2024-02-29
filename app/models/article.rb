# frozen_string_literal: true

# Article model
#   author: string
#   title: string (required)
#   content: string (required)
#   date: date (default value: Date.today)
#   comments: Comment instances
#   created_at: datetime
#   updated_at: datetime
class Article < ApplicationRecord
  has_many :comments, dependent: :destroy

  # Ensure Title and Content fields are present.
  validates :title, :content, :author, :date, presence: true
  # Ensure Content is unique.
  validates :content, uniqueness: true
  # Ensure Title is unique per Author.
  validates :title, uniqueness: { scope: :author, message: "must be unique per author" }

  class << self
    # Create a new Article instance.
    def create(title:, content:, author:, date: Time.zone.today)
      article = Article.new(author: author, title: title, content: content, date: date)
      article.save

      article
    end

    # Search for articles by Title or Content.
    def search(term)
      Article.where("title LIKE ? OR content LIKE ?", "%#{term}%", "%#{term}%")
    end
  end
end
