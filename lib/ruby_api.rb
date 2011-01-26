module RubyAPI
  def get_obj
    return self.block[1] if self.class == Ruby::Method     
    self
  end
  
  def find_module(name)
    get_obj.select(Ruby::Module, :identifier => name).first
  end

  def find_class(name, options = {})
    options.merge!(:identifier => name)
    get_obj.select(Ruby::Class, options).first    
  end

  def find_call(name, options = {})
    options.merge!(:identifier => name)
    get_obj.select(Ruby::Call, options).first    
  end 

  def find_block(name, options = {})
    options.merge!(:identifier => name)
    options.merge!(:block => true) if !options.has_key?(:block_params)    
    get_obj.select(Ruby::Call, options).first    
  end 


  def find_def(name, options = {})
    options.merge!(:identifier => name)
    get_obj.select(Ruby::Method, options).first    
  end 

  def inside_block(name, options = {}, &block)
    s = find_block(name, options)
    block.arity < 1 ? s.instance_eval(&block) : block.call(s)
  end 

  def inside_module(name, &block)
    s = find_modle(name)
    block.arity < 1 ? s.instance_eval(&block) : block.call(s)
  end

  def inside_class(name, options = {}, &block)
    s = find_class(name, options)
    block.arity < 1 ? s.instance_eval(&block) : block.call(s)
  end

  def inside_def(name, options = {}, &block)
    s = find_def(name, options)
    block.arity < 1 ? s.instance_eval(&block) : block.call(s)
  end


end

module Ruby
  class Node
    include RubyAPI
  end
end