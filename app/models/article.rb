class Article < ApplicationRecord
  validates :title, presence: true, length: { in: 5..100 }, uniqueness: true
  validates :discription, presence: true, length: { minimum: 10, maximum: 200 }
  validates :testing, numericality: { even: true }
end