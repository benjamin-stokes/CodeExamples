function nextPermutation(array) {
    var i = array.length - 1;
    while (i > 0 && array[i - 1] >= array[i])
        i--;
    if (i <= 0)
        return false;
    var j = array.length - 1;
    while (array[j] <= array[i - 1])
        j--;
    var temp = array[i - 1];
    array[i - 1] = array[j];
    array[j] = temp;
    j = array.length - 1;
    while (i < j) {
        temp = array[i];
        array[i] = array[j];
        array[j] = temp;
        i++;
        j--;
    }
    return true;
}

var fs  = require("fs");
fs.readFileSync(process.argv[2]).toString().split('\n').forEach(function (line) {
    if (line != "") {
        var numbers = line.split('');
        if (nextPermutation(numbers)){
            console.log(numbers.join(""));
        }
        else{
            numbers.sort();
            while (numbers[0] == 0) nextPermutation(numbers);
            for (i = numbers.length; i>1; i--) numbers[i] = numbers[i-1];
            numbers[1]=0;
            console.log(numbers.join(""));
        }

    }
});
