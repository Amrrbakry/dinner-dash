class Option < ApplicationRecord
  validates :name, presence: true
  validates :description, length: { maximum: 400 }
  has_attached_file :o_picture, styles: { medium: "120x120#" }
  validates_attachment_content_type :o_picture, content_type: /\Aimage/
  validates_attachment_file_name :o_picture, matches: [/png\z/, /jpe?g\z/]
  validates_attachment_size :o_picture, less_than: 2.megabytes
  belongs_to :item
  has_many :values

  accepts_nested_attributes_for :values, reject_if: :all_blank, allow_destroy: true
end
