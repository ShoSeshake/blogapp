class Article < ApplicationRecord
  has_many   :comments, dependent: :destroy
  belongs_to :user , optional: true

  validates :title , presence: true
  validates :content , presence: true 
end
