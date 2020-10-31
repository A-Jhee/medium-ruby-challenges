def is_palindrome?(n)
  n.to_s == n.to_s.reverse
end

result = []

(10..99).to_a.repeated_combination(2) do |f1, f2|
  result << [f1*f2, f1, f2] if is_palindrome?(f1*f2)
end



p result.keep_if { |x, y, z| x == 9009 }