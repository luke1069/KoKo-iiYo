require 'rails_helper'

RSpec.describe 'user機能テスト', type: :system do
  describe 'ユーザーテスト' do
    let!(:user) { create(:user, name: 'hoge', email: 'hoge@hoge.com', password: 'hogehoge', introduction: 'hoge') }

    describe 'ユーザー登録のテスト' do
      before do
        visit new_user_registration_path
      end

      context '画面表示のテスト' do
        it 'ユーザー登録画面のURLが正しいか' do
          expect(current_path).to eq('/users/sign_up')
        end
        it 'アカウント名を入力する欄があるか' do
          expect(page).to have_field 'user[name]'
        end
        it 'メールアドレスを入力する欄があるか' do
          expect(page).to have_field 'user[email]'
        end
        it 'パスワードを入力する欄があるか' do
          expect(page).to have_field 'user[email]'
        end
        it '登録ボタンがあるか' do
          expect(page).to have_button '登録'
        end
      end

      context '登録処理のテスト' do
        it '登録成功後のリダイレクト先は正しいか' do
          fill_in 'user[name]', with: Faker::Name.name
          fill_in 'user[email]', with: Faker::Internet.email
          fill_in 'user[password]', with: 'hogehoge'
          fill_in 'user[password_confirmation]', with: 'hogehoge'
          click_button '登録'
          expect(current_path).to eq('/')
        end
        it '登録成功後にflashが表示されるか' do
          fill_in 'user[name]', with: Faker::Name.name
          fill_in 'user[email]', with: Faker::Internet.email
          fill_in 'user[password]', with: 'hogehoge'
          fill_in 'user[password_confirmation]', with: 'hogehoge'
          click_button '登録'
          expect(page).to have_content 'アカウント登録が完了しました。'
        end
        it '登録失敗後にエラーが表示されるか' do
          click_button '登録'
          expect(page).to have_content '入力してください'
          expect(current_path).to eq('/users')
        end
      end
    end

    describe 'ユーザー編集のテスト' do
      before do
        sign_in user
        visit edit_user_path(user)
      end

      context '画面表示のテスト' do
        it 'ユーザー編集画面のURLが正しいか' do
          expect(current_path).to eq('/users/' + user.id.to_s + '/edit')
        end
        it 'アカウント名を変更する欄があるか' do
          expect(page).to have_field 'user[name]', with: user.name
        end
        it '都道府県を変更する欄があるか' do
          expect(page).to have_field 'user[prefecture]'
        end
        it '自己紹介を変更する欄があるか' do
          expect(page).to have_field 'user[introduction]'
        end
        it '熟練度を変更する欄があるか' do
          expect(page).to have_field 'user[skill]'
        end
        it 'マイバイクを変更する欄があるか' do
          expect(page).to have_field 'user[mybike]'
        end
        it 'プロフィール画像を変更する欄があるか' do
          expect(page).to have_field 'user[profile_image]'
        end
        it '変更完了ボタンがあるか' do
          expect(page).to have_button '完了'
        end
        it '退会ボタンがあるか' do
          expect(page).to have_link '', href: unsubscribe_path(user)
        end
      end

      context '編集処理のテスト' do
        it '編集成功後のリダイレクト先は正しいか' do
          click_button '完了'
          expect(current_path).to eq('/users/' + user.id.to_s)
        end
        it '編集成功後にflashが表示されるか' do
          click_button '完了'
          expect(page).to have_content 'プロフィール情報を変更しました。'
        end
        it '編集失敗後にエラーが表示されるか' do
          fill_in 'user[name]', with: ''
          click_button '完了'
          expect(page).to have_content '入力してください'
          expect(current_path).to eq('/users/' + user.id.to_s)
        end
      end
    end

    describe 'ユーザー退会のテスト' do
      before do
        sign_in user
        visit unsubscribe_path(user)
      end

      context '画面表示のテスト' do
        it '退会画面のURLが正しいか' do
          expect(current_path).to eq('/users/' + user.id.to_s + '/unsubscribe')
        end
        it '退会ボタンがあるか' do
          expect(page).to have_link '', href: withdraw_path(user)
        end
        it '戻るボタンがあるか' do
          expect(page).to have_link '', href: user_path(user)
        end
      end

      context '退会処理のテスト' do
        it '戻るボタンのリダイレクト先が正しいか' do
          click_link '戻る'
          expect(current_path).to eq('/users/' + user.id.to_s)
        end
        it '退会後のリダイレクト先が正しいか' do
          click_link '退会'
          expect(current_path).to eq('/')
        end
        it '退会後にflashが表示されるか' do
          click_link '退会'
          expect(page).to have_content '退会処理を完了しました。'
        end
      end
    end
  end
end
