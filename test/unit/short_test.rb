require 'test_helper'

class ShortTest < ActiveSupport::TestCase
  test "f randomizable" do
    short = shorts(:railsguide)
    assert short.f() != short.f(), "Randomizing doesnt work"
  end

  test "cannot write the same shorts hashes" do
    sameshorter = 2
    short1 = Short.new(:longer => 'http://thesamelong.com', :shorter => sameshorter)
    short2 = Short.new(:longer => 'http://thesamelong.com', :shorter => sameshorter)

    assert short1.save, 'Database should be empty'
    assert short1.shorter == sameshorter, 'Conditional generating shorter doesnt work'

    assert !short2.save, "It shouldnt be possible to save shorts with the same :shorten fields"
    assert short1.shorter == short2.shorter, 'Conditional generating shorter doesnt work, shorter fields should be the same'
  end

  test 'busy' do
    short = Short.new(:longer => 'http://longer.com', :shorter => rand.hash)
    assert Short.busy(short.shorter).empty?, 'Database should be empty'
    assert short.save, 'Cannot save object'
    assert ! Short.busy(short.shorter).empty?, 'Cannot find saved object'
  end
end
