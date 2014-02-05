require "informal"

module StyleGuide
  class TestObject
    include Informal::Model
    attr_accessor :text, :name
  end
end
