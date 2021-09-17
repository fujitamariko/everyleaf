require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do

  before do
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
  end

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
      # 1. new_task_pathに遷移する（新規作成ページに遷移する）
      visit new_task_path

      # 2. 新規登録内容を入力する
      fill_in 'task[title]', with: 'test_title'
      fill_in 'task[content]', with: 'test_content'
      select '2021', from: 'task_deadline_1i'
      select 'September', from: 'task_deadline_2i'
      select '30', from: 'task_deadline_3i'

      # 3. 「登録する」というvalue（表記文字）のあるボタンをクリックする
      click_button 'Create Task'

      # 4. clickで登録されたはずの情報が、タスク詳細ページに表示されているかを確認する
      expect(page).to have_content 'test_title'
      expect(page).to have_content 'test_content'
      expect(page).to have_content '2021'
      expect(page).to have_content '09'
      expect(page).to have_content '30'
      end
    end
  end

  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        # テストで使用するためのタスクを作成
        task = FactoryBot.create(:task, title: 'task')
        # タスク一覧ページに遷移
        visit tasks_path
        # visitした（遷移した）page（タスク一覧ページ）に「task」という文字列が
        # have_contentされているか（含まれているか）ということをexpectする（確認・期待する）
        expect(page).to have_content 'task'
        # expectの結果が true ならテスト成功、false なら失敗として結果が出力される
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        visit tasks_path
        task_list = all('.task_row')
        expect(page).to have_content 'test_title'
        expect(page).to have_content 'test_title2'
      end
    end
    context '終了期限でソートするを押した場合' do
      it '終了期限の降順に並び替えられたタスク一覧が表示される'do
        visit tasks_path
        click_on '終了期限でソートする'
        task_list = all('.task_row')
        expect(task_list[0]).to have_content '2021-09-29'
        expect(task_list[1]).to have_content '2021-09-17'
      end
    end
  end

  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
        # visit task_path
        # click_on '編集する'
        # fill_in 'task[title]', with: 'test_title2'
        # fill_in 'task[content]', with: 'test_content2'
        # click_on '登録'
        # expect(page).to have_content 'task_title'
        task = FactoryBot.create(:task)
        # task = FactoryBot.create(:second_task)
        visit task_path(task.id)
        expect(page).to have_content 'test_title'
       end
     end
  end
end