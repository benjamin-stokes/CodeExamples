#!/usr/local/rvm/rubies/ruby-2.3.0/bin/ruby


File.open(ARGV[0]).each_line do |line|
  numberlist = line.split(";")
  numbers = numberlist[0].split(",")
  i = 0
  sumflag = false
  begin
    j = i+1
    begin
      sum = numbers[i].to_i + numbers[j].to_i
#      printf("%d %d\n", sum, numberlist[1])
      if sum == numberlist[1].to_i
        if sumflag
          if numbers[i].to_i <= numbers[j].to_i
            printf(";%d,%d", numbers[i], numbers[j])
          else
            printf(";%d,%d", numbers[j], numbers[i])
          end
        else
          sumflag = true
          if numbers[i].to_i <= numbers[j].to_i
            printf("%d,%d", numbers[i], numbers[j])
          else
            printf("%d,%d", numbers[j], numbers[i])
          end
        end
      end
      j=j+1
    end while j < numbers.length
    i=i+1
  end while i < numbers.length-1
  if !sumflag
    printf("NULL")
  end
  printf("\n")
end
