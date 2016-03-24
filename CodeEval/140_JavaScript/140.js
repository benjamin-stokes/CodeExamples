var fs  = require("fs");
fs.readFileSync(process.argv[2]).toString().split('\n').forEach(function (line) {
    if (line != "") {
        var names = (line.split(';')[0]).split(' ');
        var names2 = [names.length];
        var index = (line.split(';')[1]).split(' ');
        index = index.map(Number);
        for (var i = 0; i < index.length; i++)
        {
            names2[index[i]-1] = names[i];
        }
        for (i = 0; i < names.length; i++)
            if (names2[i] == null)
                names2[i] = names[index.length];
        var newstring = names2[0];
        for ( i = 1; i < names2.length; i++)
            newstring += ' ' + names2[i];
        console.log(newstring);
    }
});
