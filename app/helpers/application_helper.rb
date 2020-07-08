module ApplicationHelper
    def working(task)
    now = Time.now
    task.update_attribute(:finished, "対応中")
    task.update_attribute(:start_achievement_date, now)
  end

  def finished(task)
    now = Time.now
    task.update_attribute(:finished, "完了")
    task.update_attribute(:finish_achievement_date, now)
  end

end
