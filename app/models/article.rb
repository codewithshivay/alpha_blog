class Article < ApplicationRecord
  validates :title, presence: true, length: { in: 5..100 }, uniqueness: true
  validates :discription, presence: true, length: { minimum: 10, maximum: 200 }, format: { with: /\A[a-zA-Z ]+\z/, message: "allow only letters"}
  validates :bar_code, numericality: { even: true, message: "valid only even numbers" }
end