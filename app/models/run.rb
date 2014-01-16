class Run < ActiveRecord::Base
  belongs_to :user

  validates :user_id, presence: true
  validates :distance, presence: true
  validates :run_time, presence: true
  validates :workout_datetime, presence: true

  validates_uniqueness_of :workout_datetime

  # THINGS WE NEED:
  # FOR SINGLE RUN:
  # 1. distance in miles check
  # 2. time in hours, minutes, seconds (1:03:23)
  # 3. mile pace in minutes, seconds (6:35)

  # FOR ALL A USERS RUNS:
  # 1. total distance in miles over last 14 days
  # 2. average mile pace for all runs over last 14 days
  # 3. mile pace for fastest run in last 14 days
  # 4. longest run in miles in last 14 days


  def miles
    result = self.distance / 1609.34
    result.round(2)
  end

  def time_in_minutes
    format_seconds_for_views(self.run_time)
  end

  def mile_pace_in_minutes
    format_seconds_for_views((self.run_time / self.miles))
  end

  def format_seconds_for_views(seconds)
    hours = (seconds / 3600).to_i
    # subtract the seconds that are already part of hours
    minutes = (seconds / 60).to_i.to_s
    seconds = (seconds % 60).round.to_s
    seconds = "0" + seconds if seconds.length == 1
    if hours >= 1
      minutes = "0" + minutes if minutes.length == 1
      "#{hours}:#{minutes}:#{seconds}"
    else
      "#{minutes}:#{seconds}"
    end
  end

  def self.longest_run_for(id)
    all_runs_for(id).order(:distance).last
  end

  # def self.average_mile_pace_for(id)
  #   run_count = all_runs_for(id).count


  # end

  # def self.total_distance_for(id)
    
  # end

  # def self.all_runs_for(id)
  #   all.where(user_id: id)
  # end

  #  def format_seconds_for_views(seconds)
  #   seconds = (seconds % 60)
  #   minutes = (seconds / 60)
  #   binding.pry
  #   hours = (minutes / 60).to_i
  #   minutes_left = (minutes % 60).to_i.to_s
  #   seconds = seconds.round.to_s
  #   seconds = "0" + seconds if seconds.length == 1
  #   if hours >= 1
  #     minutes_left = "0" + minutes_left if minutes_left.length == 1
  #     "#{hours}:#{minutes_left}:#{seconds}"
  #   else
  #     "#{minutes.to_i.to_s}:#{seconds}"
  #   end
  # end

end
