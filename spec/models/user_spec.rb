# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, 'userモデルに関するテスト', type: :model do
  describe 'userモデルのテスト' do
    it '有効なユーザー登録の場合に保存されるか' do
      expect(FactoryBot.build(:user)).to be_valid
    end
    context 'バリデーション確認' do
      it 'nameが空欄の場合にエラー表示されるか' do
        user = User.new(name:'', password:'testtest', email:'test@test.com')
        expect(user).to be_invalid
      end
      it 'passwordが空欄の場合にエラー表示されるか' do
        user = User.new(name:'hoge', password:'', email:'test@test.com')
        expect(user).to be_invalid
      end
      it 'emailが空欄の場合にエラー表示されるか' do
        user = User.new(name:'hoge', password:'testtest', email:'')
        expect(user).to be_invalid
      end
    end
  end
end