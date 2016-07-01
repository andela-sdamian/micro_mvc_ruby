class Class
  def getter_setter(*args)
    args.each do |arg|
      class_eval("def #{arg}; @#{arg};end")
      class_eval("def #{arg}=(val); @#{arg}=val; end")
    end
  end
end
