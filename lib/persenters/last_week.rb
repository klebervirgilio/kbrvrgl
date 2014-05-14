class LastWeekPresenter
  attr_reader :stats
  def intialize
    @stats = Stat.where(created_at: 1.week.ago..Date.today)
  end
end
