#!/usr/local/rvm/rubies/ruby-2.3.0/bin/ruby

for i in 1..12
  printf("%2d", i)
  for j in 2..12
    printf("%4d", i*j)
  end
  printf("\n")
end
