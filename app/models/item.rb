class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  # <<バリデーション>>

  # 値が入っているか検証
  with_options presence: true do
    validates :image
    validates :name
    validates :info
    validates :price
  end

  # 金額の範囲
  validates_inclusion_of :price, in: 300..9_999_999, message: 'Out of setting range'
 # ..:rubyの範囲オブジェクト　https://docs.ruby-lang.org/ja/latest/class/Range.html

  # 選択関係で「---」のままになっていないか検証
  with_options numericality: { other_than: 0, message: 'Select' } do
    validates :category_id
    validates :sales_status_id
    validates :shipping_fee_status_id
    validates :prefecture_id
    validates :scheduled_delivery_id
  end

  #　<<アクティブハッシュの設定関連>>
  belongs_to_active_hash :category
  belongs_to_active_hash :sales_status
  belongs_to_active_hash :shipping_fee_status
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :scheduled_delivery

  # <<アクティブストレージの設定関連>>
  has_one_attached :image

  # <<アソシエーション>>
  belongs_to :user

end