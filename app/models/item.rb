class Item < ApplicationRecord
  validates :title, presence: true, uniqueness: { message: "%{attribute} has to be unique" }
  validates :description, presence: true
  validates :price,  presence: true, numericality: { greater_than: 0 }

  has_attached_file :picture, styles: { medium: "50x50#" }, default_url: "default_item_pic.jpg"
  validates_attachment_content_type :picture, content_type: /\Aimage/
  validates_attachment_file_name :picture, matches: [/png\z/, /jpe?g\z/]
  validates_attachment_size :picture, less_than: 2.megabytes

  has_many :variations, class_name: "Item", foreign_key: "parent_item_id"
  belongs_to :item, class_name: "Item"
  has_many :options, dependent: :destroy
  has_many :order_items
  has_many :category_items
  has_many :categories, through: :category_items
  belongs_to :user

  accepts_nested_attributes_for :variations, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :options, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :category_items, reject_if: :all_blank

  searchkick
end
