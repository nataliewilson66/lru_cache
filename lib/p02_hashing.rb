class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    pow = self.length - 1
    int = 0
    self.each do |elem|
      int += elem * (10 ** pow)
      pow -= 1
    end
    int.hash
  end
end

class String
  def hash
    pow = self.length - 1
    int = 0
    self.each_char do |char|
      int += char.ord * (10 ** pow)
      pow -= 1
    end
    int.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    arr = []
    self.each do |k, v|
      arr << "#{k} => #{v}".hash
    end
    arr.sort!
    arr.hash
    #0
  end
end
