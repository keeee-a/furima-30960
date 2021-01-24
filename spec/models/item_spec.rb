require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe "商品出品機能" do
    context "新規出品登録できない時" do
      it "商品画像が空だと保存できない" do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image は必須です")
      end
      it "商品名が空だと保存できない" do
        @item.name = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it "商品の説明が空だと保存できない" do
        @item.explanation = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Explanation can't be blank")
      end
      it "カテゴリーの情報が無いと保存できない" do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Category must be other than 1")
      end
      it "商品の状態についての情報がないと保存できない" do
        @item.product_condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Product condition must be other than 1")
      end
      it "配送料の負担についての情報が無いと保存できない" do
        @item.burden_shipping_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Burden shipping must be other than 1")
      end
      it "発送元の地域についての情報がないと保存できない" do
        @item.shipping_area_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping area must be other than 1")
      end
      it "発送までの日数についての情報がないと保存できない" do
        @item.days_to_ship_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Days to ship must be other than 1")
      end
      it "価格についての情報がないと保存できない" do
        @item.price = "" 
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it "価格が¥300未満だと保存できない" do
        @item.price = 299 
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be greater than 300")
      end
      it "価格が¥10000000以上だと保存できない" do
        @item.price = 10000000
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be less than 9999999")
      end
      it "販売価格は半角数字でなければ保存できない" do
        @item.price = "abcde"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end
      it "全角文字では登録できない" do
        @item.price = "１２３４５"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end
      it "半角英数混合では登録できない" do
        @item.price = "1234abcd"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end
    end
    context "新規出品登録できる時" do
      it "価格が¥300~¥9,999,999の範囲であれば保存できる" do
        @item.price = 5000
        expect(@item).to be_valid
      end
      it "販売価格は半角数字であれば保存できる" do
        @item.price = 10000
        expect(@item).to be_valid
      end
    end
  end
end
