require 'xrcov'

module XrcovOut
  module_function
  def initialize()
    @ins = CoverageInserter.new($xrcov_out_path)
    @ins.initialize_eval()

    path = File.join($xrcov_out_path, OUT_SUFFIX)
    @out = TsvStream.new(File.open(path, 'a'))
  end

  initialize()

  def out()
    @out
  end

  def write(id, type, value)
    @out.write(id, type, value)
    #packed = [id >> 24, id >> 16, id >> 8, id, value].pack('C*')
    #$coverage_file.write(packed)
  end

  def stmt(id, type)
    puts 'stmt: ' + id.to_s
    write(id, type, 3)
  end

  def pred(id, type, value)
    puts 'pred: ' + id.to_s + ',' + value.to_s
    write(id, type, value ? 2 : 1)
    value
  end

  def eval(id, str)
    puts 'eval: ' + id.to_s
    return str unless str.instance_of?(String)
    @ins.insert_coverage_in_eval(id, str, __FILE__)
  end
end
