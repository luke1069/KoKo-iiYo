# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, 'postモデルに関するテスト', type: :model do
  describe 'postモデルのテスト' do
    it '有効な投稿内容の場合に保存されるか' do
      expect(FactoryBot.build(:post)).to be_valid
    end
    context 'バリデーションの確認' do
      it 'titleが空欄の場合、エラーが表示されるか' do
        post = Post.new(title: "", body: "hoge", rate: 5, lat: 50, lng: 50, post_prefecture: 48)
        expect(post).to be_invalid
      end
      it 'bodyが空欄の場合、エラーが表示されるか' do
        post = Post.new(title: "hoge", body: "", rate: 5, lat: 50, lng: 50, post_prefecture: 48)
        expect(post).to be_invalid
      end
      it 'rateが空欄の場合、エラーが表示されるか' do
        post = Post.new(title: "hoge", body: "hoge", rate: "", lat: 50, lng: 50, post_prefecture: 48)
        expect(post).to be_invalid
      end
      it 'latが空欄の場合、エラーが表示されるか' do
        post = Post.new(title: "hoge", body: "hoge", rate: 5, lat: "", lng: 50, post_prefecture: 48)
        expect(post).to be_invalid
      end
      it 'lngが空欄の場合、エラーが表示されるか' do
        post = Post.new(title: "hoge", body: "hoge", rate: 5, lat: 50, lng: "", post_prefecture: 48)
        expect(post).to be_invalid
      end
    end
  end
end
