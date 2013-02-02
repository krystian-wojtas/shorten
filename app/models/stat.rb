class Stat < ActiveRecord::Base
  belongs_to :short
  attr_defaults :chrome => 0, :firefox => 0, :ie => 0, :opera => 0, :other => 0, :safari => 0
end
