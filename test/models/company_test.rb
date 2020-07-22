require "test_helper"

class CompanyTest < ActiveSupport::TestCase
  test "Company with valid email" do
    company = Company.new(name: "Marcus Paint", email: "hello@getmainstreet.com", zip_code: "30301", phone: "555-808-8888")
    assert company.valid?, true
  end

  test "Company with invalid email" do
    company = Company.new(name: "Marcus Paint", email: "test@abc.com", zip_code: "30301", phone: "555-808-8888")
    assert_not_nil company.errors[:email]
  end

  test "Company with blank email" do
    company = Company.new(name: "Marcus Paint", email: "", zip_code: "30301", phone: "555-808-8888")
    assert company.valid?, true
  end

  test "Company with valid zip code" do
    company = Company.new(name: "Marcus Paint", email: "", zip_code: "30301", phone: "555-808-8888")
    company.save

    place = ZipCodes.identify(company.zip_code)
    assert_equal "30301", company.zip_code
    assert_equal place[:state_code], company.state
    assert_equal place[:city], company.city
  end

  test "Company with invalid zip code" do
    company = Company.new(name: "Marcus Paint", email: "", zip_code: "123456", phone: "555-808-8888")
    company.save

    place = ZipCodes.identify(company.zip_code)
    assert_not_nil company.errors[:zip_code]
  end

  test "Company with blank zip code" do
    company = Company.new(name: "Marcus Paint", email: "", zip_code: "", phone: "555-808-8888")
    company.save

    place = ZipCodes.identify(company.zip_code)
    assert_not_nil company.errors[:zip_code]
  end


  test "Address" do
    company = Company.new(name: "Marcus Paint", email: "", zip_code: "30301", phone: "555-808-8888")
    company.save

    assert "#{company.city}, #{company.state}", company.address
  end

  test "All details should be squished before save" do
    company = Company.new(name: "Marcus Paint  ", email: "abc@getmainstreet.com   ", zip_code: "30301  ", phone: "555-808-8888  ")
    company.save

    assert "Marcus Paint", company.name
    assert "abc@getmainstreet.com", company.email
    assert "30301", company.zip_code
    assert "555-808-8888", company.phone
  end
end
