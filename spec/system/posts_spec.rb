# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '機能テスト', type: :system do
  describe '投稿テスト' do
    before do
      @user = FactoryBot.create(:user)
      sign_in @user
    end
    let!(:post) { create(:post, title:"hoge", body:"hoge", rate:5, lat:50, lng:50) }
    describe 'トップ画面テスト' do
      before do
        visit root_path
      end
      context '表示の確認' do
        it 'トップ画面に「ようこそ」が表示されているか' do
          expect(page).to have_content'ようこそ'
        end
        it '「root_path」がURL"/"であるか' do
          expect(current_path).to eq('/')
        end
      end
    end
    describe '投稿画面のテスト' do
      before do
        visit new_post_path
      end
      context '表示のテスト' do
        it '「new_post_path」がURL"/posts/new"であるか' do
          expect(current_path).to eq('/posts/new')
        end
        it '投稿ボタンが表示されているか' do
          expect(page).to have_button '投稿'
        end
      end
      context '投稿処理のテスト' do
        it '投稿後のリダイレクト先は正しいか' do
          fill_in 'post[title]', with: 'hoge'
          fill_in 'post[body]', with: 'hoge'
          choose 5
          fill_in 'post[lat]', with: Faker::Number.between(from:-90, to:90)
          fill_in 'post[lng]', with: Faker::Number.between(from:-90, to:90)
          click_button '投稿'
          expect(page).to have_current_path post_path(Post.last)
        end
      end
    end
  end
end