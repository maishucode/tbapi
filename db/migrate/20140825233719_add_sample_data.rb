class AddSampleData < ActiveRecord::Migration
  def up
    user = User.create :email=>'testuser@gmail.com', :password=>'testuser', :name=>'wayne'
    10.times do |index|
      journal = Journal.create user_id:user.id, title:"Trip to NYC #{index+1}", note:"It is a good place to go", start_time:Time.now - 10*index.day
      checkin_times = 3+rand(8)
      checkin_times.times do |cindex|
        Checkin.create journal_id:journal.id, title:"#{cindex+1} times checkin", note:"this is the #{cindex+1} times checkin of this trip.", checkin_time:journal.start_time+(cindex+1).day
      end
      journal.update_attribute :end_time, journal.start_time + checkin_times.day
    end
  end

  def down
  end
end
