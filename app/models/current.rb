# frozen_string_literal: true

# This class is used to store the current user in a thread-safe way.
class Current < ActiveSupport::CurrentAttributes
  attribute :user

  def user=(user)
    super
  end
end
