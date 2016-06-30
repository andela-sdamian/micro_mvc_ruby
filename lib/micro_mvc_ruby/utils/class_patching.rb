class Class 
  def getter_setter(*args) 
    args.each do |arg|
     self.class_eval("def #{arg}; @#{arg};end") 
     self.class_eval("def #{arg}=(val); @#{arg}=val; end") 
    end
  end
end

