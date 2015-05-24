class Movie < ActiveRecord::Base
  serialize :data, JSON
end
