require 'test_helper'

class ShortAspectTest < ActiveSupport::TestCase
  include Aquarium::Aspects

  constF = 1
  Aspect.new :around, :calls_to => :f, :in_type => :Short do |jp, o, *args|
    constF
  end


  test "cannot write the same shorts hashes" do
    short1 = Short.new(:longer => 'http://thesamelong.com')
    short2 = Short.new(:longer => 'http://thesamelong.com')

    assert short1.save, 'Database should be empty'
    assert short1.shorter == constF, 'Aspect doesnt work'

    assert !short2.save, "It shouldnt be possible to save shorts with the same :shorten fields"
    assert short1.shorter == short2.shorter, 'After making f const, shorter fields should be the same'
  end
end
