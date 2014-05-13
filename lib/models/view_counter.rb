class ViewCounter
  include Mongoid::Document

  field :shorten_id
  field :views, type: Integer

  class << self
    def find_and_increment_or_create shorten_id
      view = ViewCounter.where(:shorten_id => shorten_id).first
      view and view.inc(:views, 1) or create(shorten_id: shorten_id, views: 1)
    end
  end
end