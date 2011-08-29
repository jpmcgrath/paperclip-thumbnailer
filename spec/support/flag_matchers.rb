require 'rspec/expectations'

RSpec::Matchers.define :have_flag do|flag|
  match do |actual|
    actual.has_flag?(flag) && (@value ? actual.flag(flag) == @value : true)
  end

  chain :set_to do |value|
    @value = value
  end
end
