#!/usr/bin/php
<?php
$fh = fopen($argv[1], "r");
while ($test = fgets($fh)) {
    $test = trim($test, "\n");
    if (!strlen($test)) continue;
    printf("%b\n", (int)$test);
}
?>
