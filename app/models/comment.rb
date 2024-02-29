# frozen_string_literal: true

# Comment model class:
#   username:string
#   body:text
#   article:references
#   article_id:integer
#   created_at:datetime
#   updated_at:datetime
class Comment < ApplicationRecord
  belongs_to :article

  # Ensures the presence of Username and Body fields.
  validates :username, :body, presence: true

  class << self
    # Create a new Comment instance.
    def create(username:, body:, article_id:)
      comment = Comment.new(username: username, body: body, article_id: article_id)
      comment.save

      comment
    end
  end
end
