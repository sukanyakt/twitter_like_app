class PhoneNumber < ApplicationRecord
  belongs_to :user

  validates :phonenumber, numericality: {only_integer: true, greater_than_or_equal_to: 1111111111, less_than_or_equal_to: 9999999999, allow_nil: true},
                           uniqueness: {message: 'Phone Number Already exist'}
end
