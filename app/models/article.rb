class Article < ApplicationRecord
  belongs_to :user
  has_many :article_categories
  has_many :categories, through: :article_categories
  validates :title, presence: true, length: { in: 5..100 }, uniqueness: true
  validates :discription, presence: true, length: { minimum: 10, maximum: 200 }
  validates :bar_code, numericality: { even: true, message: "valid only even numbers" }
end