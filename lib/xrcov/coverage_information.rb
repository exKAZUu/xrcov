class CoverageInformation
  # target elements
  attr_accessor :elems
  # to separate static eval ids from dynamic eval ids
  attr_accessor :static_eval_id

  def initialize()
    @elems = []
  end

  def ==(that)
    @elems == that.elems && @static_eval_id == that.static_eval_id
  end

  def append(f)
    @elems.each { |e|
      e.write(TsvWriter.new(f))
    }
  end

  def write(f)
    f.puts @static_eval_id
    append(f)
  end

  def self.read(f)
    info = CoverageInformation.new
    info.static_eval_id = f.readline().chomp.to_i
    until f.eof?
      ss = f.readline().split("\t")
      info.elems << CoverageElement.read(ss)
    end
    info
  end

  def read_coverage_data(f)
    until f.eof?
      id, type, value = f.readline.split(',')
      elems[id.to_i].state |= value.to_i
    end
  end

  def stmt_elems()
    @elems.select{ |e| e.type == ElementType::STATEMENT }
  end

  def branch_elems()
    @elems.select{ |e| (e.type & ElementType::BRANCH) != 0 }
  end
end
