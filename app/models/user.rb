class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

          # <<バリデーション>>
  validates :nickname, presence: true, uniqueness: { case_sensitive: true }
  # presence:指定された属性が「空でない」ことを確認
  # uniqueness: 保存される直前に、属性の値が一意（unique）であり重複していないかのチェック
  # case_sensitive:一意性制約で大文字小文字を区別するかどうか

  validates :birth_date, presence: true

  # パスワードの英数字混在を否定
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: 'Include both letters and numbers'

  # 全角のひらがなor漢字以外を使用していないか検証
  with_options presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]+\z/, message: 'Full-width characters' } do
    validates :first_name
    validates :last_name
  end
  # with_options:1つの条件を複数のバリデーションで共用できるときに使用する


  # 全角のカタカナ以外を使用していないか検証
  with_options presence: true, format: { with: /\A[\p{katakana}　ー－&&[^ -~｡-ﾟ]]+\z/, message: 'Full-width katakana characters' } do
    validates :first_name_kana
    validates :last_name_kana
  end

  # <<アソシエーション>>
  has_many :items
  has_many :orders
end
