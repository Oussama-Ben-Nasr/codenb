class Post < ApplicationRecord
  scope :ordered, -> { order(created_at: :desc) }
  validates_presence_of :title
  has_rich_text :content
  has_many :comments, dependent: :destroy
end
