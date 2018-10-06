#!/usr/bin/env perl6

use v6;

my $debug-file-name = $*SPEC.catdir(
  $?FILE.IO.parent,
  "perl6-langserver.log"
);
my $debug-file = $debug-file-name.IO.open(:w);
while my $line = prompt() {
  $debug-file.say("Read: $line");
  $debug-file.flush;
}
