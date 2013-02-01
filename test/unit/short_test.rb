require 'test_helper'

class ShortTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "f randomizable" do
    short = shorts(:railsguide)
    assert short.f() != short.f(), "Randomizing doesnt work"
  end
end
