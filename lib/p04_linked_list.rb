class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
    @prev.next = @next
    @next.prev = @prev
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail ? true : false
  end

  def get(key)
    if include?(key)
      node = @head.next
      until node.key == key
        node = node.next
      end
      return node.val
    end
    nil
  end

  def include?(key)
    node = @head.next
    until node == @tail
      return true if node.key == key
      node = node.next
    end
    false
  end

  def append(key, val)
    node = Node.new(key, val)
    node.prev = @tail.prev
    node.next = @tail
    @tail.prev.next = node
    @tail.prev = node
  end

  def update(key, val)
    if include?(key)
      node = @head.next
      until node.key == key
        node = node.next
      end
      node.val = val
    end
    nil
  end

  def remove(key)
    if include?(key)
      node = @head.next
      until node.key == key
        node = node.next
      end
      node.remove
    end
    nil
  end

  def each(&prc)
    node = @head.next
    until node == @tail
      prc.call(node)
      node = node.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
