class Task < ApplicationRecord
# データモデル
# +-------------------------+------------+------+-----+---------+----------------+
# | Field                   | Type       | Null | Key | Default | Extra          |
# +-------------------------+------------+------+-----+---------+----------------+
# | id                      | bigint(20) | NO   | PRI | NULL    | auto_increment |
# | finished                | tinyint(1) | YES  |     | NULL    |                |
# | content                 | text       | YES  |     | NULL    |                |
# | user_id                 | bigint(20) | YES  | MUL | NULL    |                |
# | start_expected_date     | datetime   | YES  |     | NULL    |                |
# | finish_expected_date    | datetime   | YES  |     | NULL    |                |
# | start_achievement_date  | datetime   | YES  |     | NULL    |                |
# | finish_achievement_date | datetime   | YES  |     | NULL    |                |
# | created_at              | datetime   | NO   |     | NULL    |                |
# | updated_at              | datetime   | NO   |     | NULL    |                |
# +-------------------------+------------+------+-----+---------+----------------+

  belongs_to :user
  validates :user_id, presence: true
  validates :content, presence: true
  validates :content, length: { maximum: 30 }
  validates :tart_expected_date, presence: true
  validates :finish_expected_date, presence: true

  # 開始予定日が、終了予定日より早い日付の場合、trueを返す
  def input_valid_expected_date?
    start_expected_date < finish_expected_date
  end
end
