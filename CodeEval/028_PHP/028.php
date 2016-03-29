#!/usr/bin/php
<?php
$fh = fopen($argv[1], "r");
while ($test = fgets($fh)) {
    $test = trim($test, "\n");
    if (!strlen($test)) continue;
    $strings = explode(',', $test);
    $strings[1] = ltrim($strings[1], "*");
    if (!strlen($strings[1])) {
        echo "true\n";
        continue;
    }

    $pattern = "/$strings[1]/";
    $pattern = preg_replace ("/\*/", ".*", $pattern);
    $pattern = preg_replace ("/\\\./", "\\", $pattern);
    if (preg_match("$pattern", $strings[0])) echo "true\n";
    else echo "false\n";
}
?>
