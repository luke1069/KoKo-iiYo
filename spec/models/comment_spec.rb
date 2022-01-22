# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, 'commentモデルに関するテスト', type: :model do
  describe 'commentモデルのテスト' do
    it '有効なコメントの場合に保存されるか' do
      expect(FactoryBot.build(:comment)).to be_valid
    end
    context 'バリデーション確認' do
      it 'commentが空欄の場合にエラー表示されるか' do
        comment = Comment.new(comment: '')
        expect(comment).to be_invalid
      end
    end
  end
end
