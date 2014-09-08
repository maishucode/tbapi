class Checkin < ActiveRecord::Base
  attr_accessible :checkin_time, :journal_id, :latitude, :longitude, :note, :poi, :title
  belongs_to :journal
end
