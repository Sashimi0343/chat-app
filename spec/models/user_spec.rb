require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    before do
      @user = FactoryBot.build(:user)
    end

    it 'name,emai,password,password_confirmationがあれば登録できる。' do
      expect(@user).to be_valid
    end

    it 'nameが空では登録ができない' do
      @user.name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Name can't be blank")
    end

    it 'emailが空では登録できない' do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it 'パスワードが空では登録できない' do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'passwordが6文字以上あれば登録ができる' do
      @user.password = '1111111'
      @user.password_confirmation = @user.password
      expect(@user).to be_valid
    end

    it 'passwordが5文字以下では登録ができない' do
      @user.password = '11111'
      @user.password_confirmation = @user.password
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end

    it 'passwordとpassword_confirmationが不一致では登録ができない' do
      @user.password = '111111'
      @user.password_confirmation = '222222'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it '重複したemailがあると登録ができない' do
      @user.save
      @user2 = FactoryBot.build(:user)
      @user2.email = @user.email
      @user2.valid?
      expect(@user2.errors.full_messages).to include("Email has already been taken")
    end
  end
end