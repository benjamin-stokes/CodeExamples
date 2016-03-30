var fs  = require("fs");
fs.readFileSync(process.argv[2]).toString().split('\n').forEach(function (line) {
    if (line != "") {
	var number = line;
	var count = 0;
	if (number == 0){
	    console.log(count);
	}else{
	    var trymax = Math.floor(Math.log(number)/Math.log(2));
	    for (var i = 0; i <= trymax; i++)
		if(number & Math.pow(2,i)) count++;
	    console.log(count);
	}
    }
});
