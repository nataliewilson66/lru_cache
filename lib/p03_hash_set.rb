class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    if !include?(key)
      resize! if @count >= num_buckets
      self[key] << key
      @count += 1
    end
  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
    if include?(key)
      self[key].delete(key)
      @count -= 1
    end
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num.hash % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    temp_arr = []
    @store.each do |bucket|
      bucket.each do |elem|
        temp_arr << elem
      end
    end
    prev_count = num_buckets
    @store = Array.new(prev_count * 2) { Array.new }
    temp_arr.each { |elem| self.insert(elem) }
    @count = prev_count
  end
end
