module Intervalable
  extend ActiveSupport::Concern

  UNITS = {
      1 => :day,
      2 => :week,
      3 => :month,
      4 => :year
  }

  UNITS_JPN = {
      1 => '日',
      2 => '週間',
      3 => '月',
      4 => '年'
  }

  included do

    validates :times, :time_unit, :presence => true
    validates_inclusion_of :time_unit, :in => UNITS.keys

    # ex: :month
    def time_unit_symbol
      UNITS[time_unit]
    end

    # ex: "3 Months"
    def time_title
      "#{times} #{UNITS_JPN[time_unit]}"
    end

    # ex: 3.months
    def time
      times.try(time_unit_symbol)
    end

  end
end
