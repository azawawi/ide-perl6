#!/usr/bin/env perl6

use v6;
use JSON::Fast;

my $debug-file-name = $*SPEC.catdir(
  $?FILE.IO.parent,
  "perl6-langserver.log"
);
my $debug-file = $debug-file-name.IO.open(:w);

sub debug-log($text) {
  $debug-file.say($text);
  $debug-file.flush;
}

loop {
  my %headers;
  for $*IN.lines -> $line {
    debug-log("Client: {$line.perl}");

    # we're done here
    last if $line eq '';

    # Parse HTTP-style header
    my ($name, $value) = $line.split(': ');
    if $name eq 'Content-Length' {
        $value = +$value;
    }
    %headers{$name} = $value;
  }
  debug-log("Headers found: {%headers.perl}");

  # Read JSON::RPC request
  my $content-length = 0 + %headers<Content-Length>;
  if $content-length > 0 {
      my $json    = $*IN.read($content-length).decode;
      my $request = from-json($json);
      debug-log("Client: {to-json($request, :pretty)}");
  }

}
