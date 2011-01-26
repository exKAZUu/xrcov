require 'xrcov'

def create_coverage_inserter()
  inserter = CoverageInserter.new()
  inserter.initialize_eval()
  # measurement targets in evaluated string corresponding to ids (-1, -2, ...)
  #def inserter.get_next_id()
  #  @id = @id - 1
  #end
end

$coverage_file ||= File.open('coverage_output', 'ab')
$inserter ||= create_coverage_inserter()

def write(id, type, value)
  $coverage_file.write(id)
  $coverage_file.write(',')
  $coverage_file.write(type)
  $coverage_file.write(',')
  $coverage_file.write(value)
  $coverage_file.write("\n")
  #packed = [id >> 24, id >> 16, id >> 8, id, value].pack('C*')
  #$coverage_file.write(packed)
end

def stmt_cov(id, type)
  puts 'stmt_cov: ' + id.to_s + ',' + value.to_s
  write(id, type, value)
  value
end

def pred_cov(id, type, value)
  puts 'pred_cov: ' + id.to_s + ',' + value.to_s
  write(id, type, value ? 2 : 1)
  value
end

def eval_cov(id, path, str)
  puts 'eval_cov: ' + id.to_s
  return str unless str.instance_of?(String)
  $inserter.insert_coverage_in_eval(id, str, path)
end
