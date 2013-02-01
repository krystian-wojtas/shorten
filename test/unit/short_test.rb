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

  test 'presence' do
    short = Short.new
    assert ! short.save, 'Object is not set properly'

    short.longer = 'http://url.com'
    assert short.save, 'Cannot save object'
  end

  test 'url' do
    short = Short.new(:longer => 'without_protocol.com')
    assert ! short.save, 'Url should specify http protocol'

    short.longer = 'https://encrypted_connection.com'
    assert ! short.save, 'Https is not supported'

    short.longer = 'http://url_ok.com'
    assert short.save, 'Cannot save object'
  end
end
