# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Message, 'messageモデルに関するテスト', type: :model do
  describe 'messageモデルのテスト' do
    it '有効なメッセージの場合に保存されるか' do
      expect(FactoryBot.build(:message)).to be_valid
    end
    context 'バリデーション確認' do
      it 'contentが空欄の場合にエラー表示されるか' do
        message = Message.new(content: '')
        expect(message).to be_invalid
      end
    end
  end
end
