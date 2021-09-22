require 'rails_helper'
RSpec.describe 'ラベル検索機能', type: :system do
let!(:user) { FactoryBot.create(:user) }
  describe 'ラベル検索機能' do
    before do
        FactoryBot.create(:task, user_id: user.id )
        @label = FactoryBot.create(:label)
        @label2 = FactoryBot.create(:label2)
        @label3 = FactoryBot.create(:label3)
        visit new_session_path
        fill_in 'session[email]', with: user.email
        fill_in 'session[password]', with: user.password
        click_on "Log in"
    end

    describe '新規タスクでのラベル作成' do
        context 'タスクの新規作成時に複数のラベルを登録した場合' do
            it 'タスク一覧詳細画面にラベルが表示される' do
                visit new_task_path
                fill_in 'task[title]', with: "SHINee"
                fill_in 'task[content]', with: "Lucifer"
                select '2021', from: 'task_deadline_1i'
                select 'September', from: 'task_deadline_2i'
                select '30', from: 'task_deadline_3i'
                select '完了', from: 'task_status'
                select '高', from: 'task_priority'
                check "task_label_ids_#{(@label.id)}"
                check "task_label_ids_#{(@label2.id)}"
                click_on 'Create Task'
                expect(page).to have_content 'KPOP'
                expect(page).to have_content 'CPOP'
            end
        end
    end
    describe 'ラベル検索機能' do
        before do
            visit new_task_path
            fill_in 'task[title]', with: "INTO1"
            fill_in 'task[content]', with: "风暴眼"
            select '2021', from: 'task_deadline_1i'
            select 'September', from: 'task_deadline_2i'
            select '15', from: 'task_deadline_3i'
            select '未着手', from: 'task_status'
            select '低', from: 'task_priority'
            check "task_label_ids_#{(@label.id)}"
            check "task_label_ids_#{(@label2.id)}"
            click_on 'Create Task'
            visit new_task_path
            fill_in 'task[title]', with: "TXT"
            fill_in 'task[content]', with: "0×1=LOVESONG"
            select '2021', from: 'task_deadline_1i'
            select 'September', from: 'task_deadline_2i'
            select '30', from: 'task_deadline_3i'
            select '完了', from: 'task_status'
            select '高', from: 'task_priority'
            check "task_label_ids_#{(@label3.id)}"
            click_on 'Create Task'
        end

        context 'ラベル検索をした場合' do
            it "ラベルを含むタスクで絞り込まれる" do
                visit tasks_path
                select "JPOP", from: "label_id"
                click_on 'Label Search'
                expect(page).to have_content 'JPOP'
            end
        end

    end
  end
end