class Project < ActiveRecord::Base
  belongs_to :leader, class_name: 'User', foreign_key: 'leader_id'
  has_many :projects_users, dependent: :destroy
  has_many :users, through: :projects_users

  validates :name, presence: true
  validates :abbr, presence: true
  validates :team_id, presence: true
  validates :leader_id, presence: true
  validates :start_date, presence: true, date: { before: :end_date}
  validates :end_date, presence: true, date: { after: :start_date}

  before_save {self.abbr.upcase!}

  accepts_nested_attributes_for :projects_users,
    reject_if: ->attrs { attrs["member"] == "0" },
    allow_destroy: true
end