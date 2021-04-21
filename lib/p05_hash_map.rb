require_relative 'p04_linked_list'

class HashMap
  include Enumerable
  attr_accessor :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
    if !include?(key)
      resize! if @count >= num_buckets
      bucket(key).append(key, val)
      @count += 1
    else
      bucket(key).update(key, val)
    end
    nil
  end

  def get(key)
    if include?(key)
      return bucket(key).get(key)
    end
    nil
  end

  def delete(key)
    if include?(key)
      bucket(key).remove(key)
      @count -= 1
    end
    nil
  end

  def each(&prc)
    @store.each do |bucket| 
      bucket.each do |node|
        prc.call(node.key, node.val)
      end
    end
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    temp_list = LinkedList.new
    @store.each do |bucket|
      bucket.each do |node|
        temp_list.append(node.key, node.val)
      end
    end
    prev_count = num_buckets
    @store = Array.new(prev_count * 2) { LinkedList.new }
    temp_list.each { |node| self.set(node.key, node.val) }
    @count = prev_count
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    @store[key.hash % num_buckets]
  end
end
