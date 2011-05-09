class CoverageElement
  attr_reader :type, :child_range
  attr_accessor :path, :pos, :tag, :state

  def initialize(type, path, pos, tag, child_range = (0...0))
    @type = type
    @path = path
    @pos = pos # [line, column]
    @tag = tag
    @state = 0
    @child_range = child_range
  end

  def ==(that)
    @type == that.type && @path == that.path && @pos == that.pos &&
      @tag == tag && @state == state && @child_range == child_range
  end

  def children_or_self_state(info)
    # for condition coverage for the branch which has only one condition
    info.elems[@child_range].map{|e| e.state}.reduce(:&) || @state
  end

  def children_and_self_state(info)
    # for branch / condition coverage
    info.elems[@child_range].map{|e| e.state}.reduce(@state, :&)
  end

  def write(out)
    child_first = child_range.first
    child_last = child_range.last + (child_range.exclude_end? ? 0 : 1)
    out.write(type, path, pos[0], pos[1], tag, state, child_first, child_last)
  end

  def self.read(ss)
    type = ss[0].to_i
    path = ss[1]
    pos = [ss[2].to_i, ss[3].to_i]
    tag = ss[4]
    state = ss[5].to_i
    child_range = (ss[6].to_i ... ss[7].to_i)
    ret = self.new(type, path, pos, tag, child_range)
    ret.state = state
    ret
  end
end
