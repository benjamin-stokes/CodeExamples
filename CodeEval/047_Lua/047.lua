#!/usr/local/bin/lua

function split(source, delimiters)
   local elements = {}
   local pattern = '([^'..delimiters..']+)'
   string.gsub(source, pattern, function(value) elements[#elements + 1] = value; end);
   return elements
end


for line in io.lines(arg[1]) do
   numbers = split(line, ' ')
   numbers[1] = math.floor(numbers[1])
   numbers[2] = math.floor(numbers[2])
   numinterest = 0
   for i=numbers[1],numbers[2] do
      for j=i, numbers[2] do
         numpal = 0
         for k=i,j do
            if tostring(k) == string.reverse(tostring(k)) then
               numpal = numpal+1
            end
         end
         if numpal%2 == 0 then
            numinterest = numinterest + 1
         end
      end
   end
   print(numinterest)


end
