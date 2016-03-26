#!/usr/bin/php
<?php
$fh = fopen($argv[1], "r");
while ($test = fgets($fh)) {
    $test = trim($test);
    if (!strlen($test)) continue;
    $numbers = explode(',', $test);
    $x = (int)$numbers[0];
    $n = (int)$numbers[1];
    $i = 1;
    while(true){
        $b = $n*$i;
        if ($b >= $x) break;
        $i++;
    }
    echo "$b\n";
  }
?>
