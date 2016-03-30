#!/usr/bin/lua

function split(source, delimiters)
   local elements = {}
   local pattern = '([^'..delimiters..']+)'
   string.gsub(source, pattern, function(value) elements[#elements + 1] = value; end);
   return elements
end

for line in io.lines(arg[1]) do
    
   numbers = split(line, ',')
   summax = 0
   nummax = table.maxn(numbers)
   if nummax == 0 then
      print(summax)
   else
	summax = -1000000 
   	for i=1,nummax do
       	    for j=i, nummax do
       	    	sum = 0
	   	for k=i,j do
	       	    sum = sum + numbers[k]
	    	end
	   	if sum > summax then
	       	   summax = sum
	   	end
	    end
       	end
    	print(summax)
    end
end
