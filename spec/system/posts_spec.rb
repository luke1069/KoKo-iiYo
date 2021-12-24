# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'post機能テスト', type: :system do

  describe '投稿テスト' do

    before do
      @user = FactoryBot.create(:user)
      sign_in @user
    end
    let!(:post) { create(:post, user_id: @user.id, title:"hoge", body:"hoge", rate:5, lat:50, lng:50) }

    describe 'トップのテスト' do
      before do
        visit root_path
      end
      context '画面表示のテスト' do
        it 'トップ画面に「ようこそ」が表示されているか' do
          expect(page).to have_content'ようこそ'
        end
        it 'トップ画面の「root_path」がURL"/"であるか' do
          expect(current_path).to eq('/')
        end
        it 'トップ画面に「新着の投稿一覧」へのリンクがあるか' do
          expect(page).to have_link '', href: posts_path
        end
        it 'トップ画面に「人気の投稿一覧」へのリンクがあるか' do
          expect(page).to have_link '', href: ranking_index_path
        end
      end
    end

    describe '新規投稿画面のテスト' do
      before do
        visit new_post_path
      end
      context '画面表示のテスト' do
        it '「new_post_path」がURL"/posts/new"であるか' do
          expect(current_path).to eq('/posts/new')
        end
        it '投稿ボタンが表示されているか' do
          expect(page).to have_button '投稿'
        end
      end
      context '投稿処理のテスト' do
        it '投稿成功後にflashが表示されるか' do
          fill_in 'post[title]', with: Faker::Lorem.characters(number:5)
          fill_in 'post[body]', with: Faker::Lorem.characters(number:10)
          find('#lng', visible: false).set 999999
          find('#lat', visible: false).set 999999
          find('#review_star', visible: false).set 5
          click_button '投稿'
          expect(page).to have_content '投稿を完了しました'
        end
        it '投稿失敗後にエラーが表示されるか' do
          click_button '投稿'
          expect(page).to have_content '入力してください'
          expect(current_path).to eq('/posts')
        end
        it '投稿後のリダイレクト先は正しいか' do
          fill_in 'post[title]', with: Faker::Lorem.characters(number:5)
          fill_in 'post[body]', with: Faker::Lorem.characters(number:10)
          find('#lng', visible: false).set 999999
          find('#lat', visible: false).set 999999
          find('#review_star', visible: false).set 5
          click_button '投稿'
          expect(page).to have_current_path post_path(Post.last)
        end
      end
    end

    describe '投稿一覧画面のテスト' do
      before do
        visit posts_path
      end
      context '画面表示のテスト' do
        it '投稿情報が表示されているか' do
          expect(page).to have_content post.title
          expect(page).to have_content post.body
          expect(page).to have_content post.image
        end
        it 'お気に入りボタンが表示されているか' do
          expect(page).to have_link '', href: post_favorites_path(post)
        end
        it '投稿ユーザー画面のリンクがあるか' do
          expect(page).to have_link '', href: user_path(post.user)
        end
        it '投稿詳細画面のリンクがあるか' do
          expect(page).to have_link '', href: post_path(post)
        end
      end
    end

    describe '投稿詳細画面のテスト' do
      before do
        visit post_path(post)
      end
      context '画面表示のテスト' do
        it '投稿情報が表示されているか' do
          expect(page).to have_content post.title
          expect(page).to have_content post.body
          expect(page).to have_content post.image
          expect(page).to have_content 'ポイントの地図'
          expect(page).to have_content 'コメントの投稿一覧'
        end
        it '投稿編集のリンクがあるか' do
          expect(page).to have_link '', href: edit_post_path(post)
        end
        it 'お気に入りボタンが表示されているか' do
          expect(page).to have_link '', href: post_favorites_path(post)
        end
        it '投稿ユーザー画面のリンクがあるか' do
          expect(page).to have_link '', href: user_path(post.user)
        end
      end
    end

    describe '投稿編集画面のテスト' do
      before do
        visit edit_post_path(post)
      end
      context '画面表示のテスト' do
        it '投稿情報が表示されているか' do
          expect(page).to have_field 'post[title]', with:post.title
          expect(page).to have_field 'post[body]', with:post.body
          expect(page).to have_content post.image
        end
        it '投稿編集ボタンが表示されているか' do
          expect(page).to have_button '編集'
        end
        it '投稿削除ボタンが表示されているか' do
          expect(page).to have_link '', href: post_path(post)
        end
      end
      context '編集処理のテスト' do
        it '編集成功後にflashが表示されるか' do
          fill_in 'post[title]', with: Faker::Lorem.characters(number:5)
          fill_in 'post[body]', with: Faker::Lorem.characters(number:10)
          find('#lng', visible: false).set 999999
          find('#lat', visible: false).set 999999
          find('#review_star', visible: false).set 5
          click_button '編集'
          expect(page).to have_content '投稿内容を変更しました。'
        end
        it '投稿失敗後にエラーが表示されるか' do
          fill_in 'post[title]', with: ''
          fill_in 'post[body]', with: ''
          click_button '編集'
          expect(page).to have_content '入力してください'
          expect(current_path).to eq('/posts/1')
        end
         it '編集後のリダイレクト先は正しいか' do
          fill_in 'post[title]', with: Faker::Lorem.characters(number:5)
          fill_in 'post[body]', with: Faker::Lorem.characters(number:10)
          find('#lng', visible: false).set 999999
          find('#lat', visible: false).set 999999
          find('#review_star', visible: false).set 5
          click_button '編集'
          expect(page).to have_current_path post_path(Post.last)
        end
        it '削除後のリダイレクト先は正しいか' do
          click_link '削除'
          expect(page).to have_current_path posts_path
        end

      end
    end

  end

end