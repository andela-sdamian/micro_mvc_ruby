require_relative 'string_patching'

class Object
  def self.const_missing(const)
    require const.to_s.snake_case
    Object.const_get(const)
  end
end
