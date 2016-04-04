var opopts = ['+', '-', ''];
var fs  = require("fs");
function isUgly(num){
    if (num == 0) return true;
    if (num % 2 == 0) return true;
    if (num % 3 == 0) return true;
    if (num % 5 == 0) return true;
    if (num % 7 == 0) return true;
    return false;

}
var numbers = new Array();
var i = 0;
var j = 0;
var evstrint = new String;
var expatt = /([^\d.]|^)0(\d+)/g;
var maincount = 0;
var counter = new Array();

fs.readFileSync(process.argv[2]).toString().split('\n').forEach(function (line) {
    if (line != "") {
        numbers = line.split('');
        maincount = 0;
        for (i = 0; i < numbers.length-1; i++) counter[i]=0;
        i=0;
        j=0;
        while (i < Math.pow(3,(numbers.length-1)) ){
            evstring = numbers[0].toString();
            for(j=1; j<numbers.length; j++){
                evstring = evstring + opopts[counter[j-1]] +
                    numbers[j].toString();
            }
            evstring = evstring.replace(expatt, "$1$2");
            if (isUgly(eval(evstring))) maincount++;
            counter[0]++;
            i++;
            for (j=1; j < numbers.length; j++){
                if (counter[j-1] == 3){
                    counter[j]++;
                    counter[j-1] = 0;
                }
            }
        }
        console.log(maincount);
    }
});
