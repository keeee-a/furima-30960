require 'rails_helper'

RSpec.describe Form, type: :model do
  before do
    @user = FactoryBot.build(:user)
    @item = FactoryBot.build(:item)
    @form = FactoryBot.build(:form, user_id: @user.id, item_id: @item.id)
  end
  
  context "購入記録が保存できない時" do
    it "郵便番号がないと保存できない" do
      @form.postal_code = ""
      @form.valid?
      expect(@form.errors.full_messages).to include("Postal code can't be blank")
    end
    it "郵便番号にはハイフンが必要であること" do
      @form.postal_code = "0123456"
      @form.valid?
      expect(@form.errors.full_messages).to include("Postal code is invalid")
    end
    it "都道府県の情報がないと保存できない" do
      @form.prefecture_id = nil
      @form.valid?
      expect(@form.errors.full_messages).to include("Prefecture can't be blank")
    end
    it "都道府県の情報が選択されないと保存できない" do
      @form.prefecture_id = 1
      @form.valid?
      expect(@form.errors.full_messages).to include("Prefecture must be other than 1")
    end
    it "市区町村の情報がないと保存できない" do
      @form.city = ""
      @form.valid?
      expect(@form.errors.full_messages).to include("City can't be blank")
    end
    it "市区町村は半角英字だと保存できない" do
      @form.city = "abedefg"
      @form.valid?
      expect(@form.errors.full_messages).to include("City is invalid")
    end
    it "番地の情報がないと保存できない" do
      @form.address = ""
      @form.valid?
      expect(@form.errors.full_messages).to include("Address can't be blank")
      
    end
    it "番地は半角英語だと保存できない" do
      @form.address = "aiueo"
      @form.valid?
      expect(@form.errors.full_messages).to include("Address is invalid")
    end
    it "電話番号がないと保存できない" do
      @form.phone_number = ""
      @form.valid?
      expect(@form.errors.full_messages).to include("Phone number can't be blank")
    end
    it "電話番号が半角数字でないと保存できない" do
      @form.phone_number = "タナカタロウ"
      @form.valid?
      expect(@form.errors.full_messages).to include("Phone number is invalid")
    end
    it "電話番号は十一桁以内でないと保存できない" do
      @form.phone_number = "090123456789"
      @form.valid?
      expect(@form.errors.full_messages).to include("Phone number is too long (maximum is 11 characters)")
    end

  end

  context "購入記録が保存できる時" do
    it "必要な情報が全て揃っていれば保存できる" do
      expect(@form).to be_valid
    end
    it "郵便番号が三桁の数字とハイフンと四桁の数字であるならば保存できる" do
      @form.postal_code = "987-6543"
      expect(@form).to be_valid
    end
    it "都道府県が選択されていれば保存できる" do
      @form.prefecture_id = 40
      expect(@form).to be_valid
    end
    it "市区町村が全角ひらがな、カタカナあるいは漢字で入力されていれば保存できる" do
      @form.city = "福岡市"
      expect(@form).to be_valid
    end
    it "番地が全角ひらがな、カタカナ、漢字あるいは数字で入力されていれば保存できる" do
      @form.address = "青木あいうえおカキクケコ12345" 
      expect(@form).to be_valid
    end
    it "電話番号が全て半角数字なら保存できる" do
      @form.phone_number = "87654321090"
      expect(@form).to be_valid
    end
    it "電話番号が十一桁以内であれば保存できる" do
      @form.phone_number = "09012345678"
      expect(@form).to be_valid
    end
    it "建物名が空でも保存できる" do
      @form.building = ""
      expect(@form).to be_valid
    end
  end
end