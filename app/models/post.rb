# == Schema Information
#
# Table name: posts
#
#  id         :bigint(8)        not null, primary key
#  title      :string           not null
#  url        :string           not null
#  content    :string
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ApplicationRecord
  validates :title, :url, presence: true

  belongs_to :user

  has_many :postsubs,
    foreign_key: :post_id,
    class_name: :Postsub,
    inverse_of: :post

  has_many :subs,
    through: :postsubs,
    source: :sub

  has_many :comments
end
