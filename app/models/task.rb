class Task < ApplicationRecord
    validates :title, presence: true
    validates :content, presence: true

    enum status: { 完了: "完了", 着手中: "着手中", 未着手: "未着手" }
    enum priority: { 高: 1, 中: 2, 低: 3 }

    scope :search_by_task_title, -> (search){where('title like ?', "%#{search}%" )}
    scope :search_by_status, -> status { where(status: status) }
    belongs_to :user, optional: true
    has_many :labellings, dependent: :destroy
    has_many :labels, through: :labellings
end