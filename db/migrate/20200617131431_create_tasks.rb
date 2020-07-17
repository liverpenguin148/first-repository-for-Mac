class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :finished, default: "未着手", null: "未着手"
      t.text :content
      t.references :user, foreign_key: true
      t.datetime :start_expected_date
      t.datetime :finish_expected_date
      t.datetime :start_achievement_date
      t.datetime :finish_achievement_date
      t.timestamps
    end
  end
end
