class Stats
  attr_reader :runs

  def initialize(runs)
    @runs = runs
  end

  def total_distance
    convert(calc.total_distance)
  end

  def longest_run
    convert(calc.longest_run)
  end

  def average_pace
    seconds = calc.total_average_pace_per_mile
    Formatter.new.format_for_seconds(seconds)
  end

  def logged_runs
    runs.map do |run|
      LoggedRun.new(run)
    end
  end

  private

  def calc
    @calc ||= Calculator.new(runs)
  end

  def convert(meters)
    DistanceConverter.new(meters).miles
  end
end
