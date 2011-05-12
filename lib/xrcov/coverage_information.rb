class CoverageInformation
  # target elements
  attr_accessor :elems
  # to separate static eval ids from dynamic eval ids
  attr_accessor :static_eval_id

  def initialize()
    @elems = []
    @wrote_count = 0
  end

  def ==(that)
    @elems == that.elems && @static_eval_id == that.static_eval_id
  end

  def append(f)
    @elems[@wrote_count..-1].each { |e|
      e.write(TsvStream.new(f))
    }
    @wrote_count = @elems.count
  end

  def write(f)
    f.puts @elems.count
    append(f)
  end

  def self.read(f)
    info = CoverageInformation.new
    info.static_eval_id = f.readline().chomp.to_i
    TsvStream.new(f).read_all { |record|
      info.elems << CoverageElement.read(record)
    }
    info
  end

  def read_coverage_data(f)
    until f.eof?
      id, type, value = f.readline.split("\t")
      elems[id.to_i].state |= value.to_i
    end
  end

  def stmt_elems()
    @elems.select{ |e| e.type == ElementType::STATEMENT }
  end

  def branch_elems()
    @elems.select{ |e| (e.type & ElementType::BRANCH) != 0 }
  end

  def static_stmt_elems()
    @elems[0..@static_eval_id].select{ |e| e.type == ElementType::STATEMENT }
  end

  def static_branch_elems()
    @elems[0..@static_eval_id].select{ |e| (e.type & ElementType::BRANCH) != 0 }
  end
end
