require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できない時' do
      it 'nicknameが空では保存できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが空では保存できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'emailが一意性でなければ保存できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'emailは、@を含んでいなければ保存できない' do
        @user.email = 'testexample'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'パスワードが空では保存できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'パスワードは、6文字以上でなければ保存できない' do
        @user.password = 'abc12'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'パスワードは、半角英字だけでは保存できない' do
        @user.password = 'abcdef'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end
      it 'パスワードは、半角数字だけでは保存できない' do
        @user.password = '012345'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end
      it 'パスワードは、確認用も入力しなければ保存できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('Password confirmation is invalid')
      end
      it 'パスワードは、確認用だけの入力では保存できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end
      it 'パスワードとパスワード（確認用）、の値が一致しなければ保存できない' do
        @user.password_confirmation = '98765xyz'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'パスワードは全角では登録できない' do
        @user.password = '１２３４ＡＢＣＤ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end
      it 'ユーザー本名は、名字だけでは保存できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it 'ユーザー本名は、名前だけでは保存できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it 'ユーザー本名（名前）は、半角英字では保存できない' do
        @user.first_name = 'tarou'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name is invalid')
      end
      it 'ユーザー本名（姓）は、半角英字では保存できない' do
        @user.last_name = 'tanaka'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name is invalid')
      end
      it 'ユーザー本名のフリガナは、名字だけでは保存できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end
      it 'ユーザー本名のフリガナは、名前だけでは保存できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end
      it 'ユーザー本名（名前）のフリガナは、全角（カタカナ）での入力が必須であること' do
        @user.first_name_kana = 'tarou'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana is invalid')
      end
      it 'ユーザー本名（姓）のフリガナは、全角（カタカナ）での入力が必須であること' do
        @user.last_name_kana = 'tanaka'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana is invalid')
      end
      it '生年月日が必須であること' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
    context '新規登録できる時' do
      it 'nickname,first_name,last_name,first_name_kana,last_name_kana,birthdayがあれば保存できる' do
        expect(@user).to be_valid
      end
      it 'メールアドレスは＠が含まれていれば保存できる' do
        @user.email = 'a@b'
        expect(@user).to be_valid
      end
      it 'パスワードは6文字以上であれば保存できる' do
        @user.password = '123abc'
        @user.password_confirmation = @user.password
        expect(@user).to be_valid
      end
      it 'パスワードは半角英数混合であれば保存できる' do
        @user.password = '12345abcde'
        @user.password_confirmation = @user.password
        expect(@user).to be_valid
      end
      it 'first_nameは全角（漢字・ひらがな・カタカナ）であれば保存できる' do
        @user.first_name = '太郎'
        expect(@user).to be_valid
      end
      it 'last_nameは全角（漢字・ひらがな・カタカナ）であれば保存できる' do
        @user.last_name = '田中'
        expect(@user).to be_valid
      end
      it 'first_name_kanaは全角（カタカナ）であれば保存できる' do
        @user.first_name_kana = 'タロウ'
        expect(@user).to be_valid
      end
      it 'last_name_kanaは全角（カタカナ）であれば保存できる' do
        @user.last_name_kana = 'タナカ'
        expect(@user).to be_valid
      end
    end
  end
end
