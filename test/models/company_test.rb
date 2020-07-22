require "test_helper"

class CompanyTest < ActiveSupport::TestCase
  test "Company with valid email" do
    company = Company.new(name: "Marcus Paint", email: "hello@getmainstreet.com", zip_code: 123456, phone: "555-808-8888")
    assert company.valid?, true
  end

  test "Company with invalid email" do
    company = Company.new(name: "Marcus Paint", email: "test@abc.com", zip_code: 123456, phone: "555-808-8888")
    assert_not_nil company.errors[:email]
  end

  test "Company with blank email" do
    company = Company.new(name: "Marcus Paint", email: "", zip_code: 123456, phone: "555-808-8888")
    assert company.valid?, true
  end
end
