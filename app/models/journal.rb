class Journal < ActiveRecord::Base
  attr_accessible :end_time, :is_current, :note, :start_time, :title, :user_id
  has_many :checkins
end
