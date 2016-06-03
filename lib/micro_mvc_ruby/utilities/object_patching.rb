require_relative 'string_patching'

class Object
  def const_missing(const)
    require const.to_s.snake_case
    const.constantize
  end
end
