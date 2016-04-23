#!/usr/local/rvm/rubies/ruby-2.3.0/bin/ruby

class Array
  def sum
    inject { |sum, x| sum + x }
  end
end

File.open(ARGV[0]).each_line do |line|
#File.open("050.in").each_line do |line|
  stringlist = line.split(";")
  masterstring = stringlist[0]
  substrings = stringlist[1].strip.split(",")
  shadow = Array.new(masterstring.length, 0)
  i=0
  begin
    j = 0
    k = substrings[i].length
    k2 = substrings[i+1].length
    begin
      if masterstring[j,k] == substrings[i] && shadow[j,k].sum == 0
        masterstring[j,k] = substrings[i+1]
        shadow[j,k] = Array.new(k2,1)
        j += k2
      else
        j += 1
      end
    end while j <= masterstring.length - k
    i += 2
  end while i < substrings.length
  printf("%s\n", masterstring)

end
