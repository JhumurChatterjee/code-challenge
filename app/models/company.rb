class Company < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@getmainstreet\.com\z/i.freeze

  has_rich_text :description

  before_validation :set_city_state, if: :zip_code_changed?

  before_validation do
    self.name.to_s.squish!
    self.email.to_s.squish!
    self.phone.to_s.squish!
    self.zip_code.to_s.squish!
  end

  validates :email, format: { with: VALID_EMAIL_REGEX, message: "should belong to getmainstreet.com domain" }, allow_blank: true
  validates :zip_code, :state, :city, presence: true

  def address
    "#{city}, #{state}"
  end

  private

  def set_city_state
    hash = ZipCodes.identify(zip_code)

    if hash.present?
      self.state = hash[:state_code]
      self.city = hash[:city]
    else
      errors.add(:zip_code, "is invalid")
      throw :abort
    end
  end
end
