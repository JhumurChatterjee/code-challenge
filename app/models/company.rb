class Company < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@getmainstreet\.com\z/i.freeze
  has_rich_text :description

  validates :email, format: { with: VALID_EMAIL_REGEX, message: "should belong to getmainstreet.com domain" }, allow_blank: true
end
