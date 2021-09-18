class Task < ApplicationRecord
    validates :title, presence: true
    validates :content, presence: true

    enum status: { 完了: "完了", 着手中: "着手中", 未着手: "未着手" }

    scope :search_by_task_title, -> (search){where('title like ?', "%#{search}%" )}
    scope :search_by_status, -> status { where(status: status) }
end  