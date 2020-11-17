FactoryBot.define do
  factory :item do
    name { 'サンプル商品' }
    info { 'サンプル商品の説明' }
    price { 1000 }
    category_id { 1 }
    sales_status_id { 1 }
    shipping_fee_status_id { 1 }
    prefecture_id { 1 }
    scheduled_delivery_id { 1 }
    association :user

    trait :image do
      image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/sample.png')) }
  # chatappと同様にサンプル画像の準備を忘れないようにしましょう
    end


  end
end