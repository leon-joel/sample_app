class String
  def string_shuffle
    self.split('').shuffle.join
  end

end

puts "string".string_shuffle