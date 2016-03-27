#!/usr/local/bin/lua

function split(source, delimiters)
   local elements = {}
   local pattern = '([^'..delimiters..']+)'
   string.gsub(source, pattern, function(value) elements[#elements + 1] = value; end);
   return elements
end

for line in io.lines(arg[1]) do
   numbers = split(line, ',')
   test1 = bit32.band(numbers[1],2^(numbers[2]-1))
   test2 = bit32.band(numbers[1],2^(numbers[3]-1))
   if (test1 > 0 and test2 > 0) or test1 == test2 then
      io.write('true\n')
   else
      io.write('false\n')
   end
end
