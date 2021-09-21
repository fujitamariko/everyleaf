require 'rails_helper'
RSpec.describe '​ユーザ登録・ログイン・ログアウト機能​・管理画面テスト', type: :system do

  describe '​ユーザ登録のテスト​' do
    context '​ユーザのデータがなくログインしていない場合​' do
      it '​ユーザ新規登録のテスト​' do
        visit new_user_path
        fill_in 'user[name]', with: 'sample'
        fill_in 'user[email]', with: 'sample@example.com'
        fill_in 'user[password]', with: '00000000'
        fill_in 'user[password_confirmation]', with: '00000000'
        click_on 'Create my account'
        expect(page).to have_content 'sample@example.com'
      end
      it '​ログインしていない時はログイン画面に飛ぶテスト​' do
        visit tasks_path
        expect(current_path).to eq new_session_path
      end
    end
  end

  describe "セッション機能のテスト" do
    before do
      @user = FactoryBot.create(:user)
    end
    context "ユーザーのデータがあってログインしていない場合" do
      it "ログインができること" do
        visit new_session_path
        fill_in 'session[email]', with: 'general_user@example.com'
        fill_in 'session[password]', with: '12345678'
        click_on "Log in"
        expect(current_path).to eq user_path(id: @user.id)
      end
    end

    context "ユーザーのデータがあってログインしている場合" do
      before do
        visit new_session_path
        fill_in 'session[email]', with: 'general_user@example.com'
        fill_in 'session[password]', with: '12345678'
        click_on "Log in"
      end

      it "自分の詳細画面(マイページ)に飛べること" do
        visit user_path(id: @user.id)
        expect(current_path).to eq user_path(id: @user.id)
      end

      it "一般ユーザが他人の詳細画面に飛ぶとタスク一覧ページに遷移すること" do
        @admin_user = FactoryBot.create(:admin_user)
        visit user_path(id: @admin_user.id)
        expect(page).to have_content "他の人のページへアクセスは出来ません"
      end

      it "ログアウトができること" do
        visit user_path(id: @user.id)
        click_on "Logout"
        expect(page).to have_content "ログアウトしました"
      end
    end
  end

  describe "管理画面のテスト" do
    context "アドミンユーザーがない場合" do
      it "管理者は管理画面にアクセスできること" do
        FactoryBot.create(:admin_user)
        visit new_session_path
        fill_in 'session[email]', with: 'admin_test@example.com'
        fill_in 'session[password]', with: '12345678'
        click_on "Log in"
        visit admin_users_path
        expect(page).to have_content "ユーザ一覧"
      end
    end

    context "一般ユーザーでログインしている場合" do
      it "一般ユーザは管理画面にアクセスできないこと" do
        FactoryBot.create(:user)
        visit new_session_path
        fill_in 'session[email]', with: 'general_user@example.com'
        fill_in 'session[password]', with: '12345678'
        click_on "Log in"
        visit admin_users_path
        expect(page).to have_content "管理者以外はアクセスできません。"
      end
    end

    context "管理者でログインしている場合" do
      before do
        FactoryBot.create(:admin_user)
        visit new_session_path
        fill_in 'session[email]', with: 'admin_test@example.com'
        fill_in 'session[password]', with: '12345678'
        click_on "Log in"
        visit admin_users_path
      end

      it "管理者はユーザを新規登録できること" do
        click_on "新規ユーザー作成"
        fill_in 'user[name]', with: 'test111'
        fill_in 'user[email]', with: 'test111@example.com'
        fill_in 'user[password]', with: '12345678'
        fill_in 'user[password_confirmation]', with: '12345678'
        click_on 'Create User'
        expect(page).to have_content 'test111'
      end

      it  "管理者はユーザの詳細画面にアクセスできること" do
        @user = FactoryBot.create(:user)
        visit admin_user_path(id: @user.id)
        expect(page).to have_content 'general_user'
      end

      it "管理者はユーザの編集画面からユーザを編集できること" do
        @user = FactoryBot.create(:user)
        visit edit_admin_user_path(id: @user.id)
        fill_in 'user[name]', with: 'test222'
        fill_in 'user[email]', with: 'test222@example.com'
        fill_in 'user[password]', with: '12345678'
        fill_in 'user[password_confirmation]', with: '12345678'
        click_on 'Update User'
        expect(page).to have_content 'test222'
      end

      it "管理者はユーザの削除をできること" do
        @user = FactoryBot.create(:user)
        visit admin_users_path
        click_on 'Delete', match: :first
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content '管理権限者は、最低でも１人は必要です'
      end
    end
  end

end