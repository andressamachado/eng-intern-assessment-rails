# frozen_string_literal: true

# username:string
# email:string
# password_digest:string
#
# password:string virtual
# password_confirmation:string virtual
class User < ApplicationRecord
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/

  has_secure_password
  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :username,
    presence: true,
    allow_blank: false,
    length: {
      minimum: 3,
      maximum: 20,
      too_short: "must have at least 3 characters",
      too_long: "must have at most 20 characters",
    }

  validates :email,
    presence: true,
    allow_blank: false,
    format: {
      with: EMAIL_REGEX,
      message: "Must be a valid e-mail address",
    }
end
