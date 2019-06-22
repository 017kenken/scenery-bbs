class Post < ApplicationRecord
    has_many :comments
    has_many_attached :images
    belongs_to :user
    validates :user_id, presence: true
    acts_as_likeable
end
