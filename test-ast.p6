use v6;

my $source-code = q:to/END/;
  my $var = 1;
  sub foo {
    say "Hello, World!";
    say 1;
  }
END
"foofoo.p6".IO.spurt: $source-code;
LEAVE "foofoo.p6".IO.unlink;

my $output = qq:x{perl6 --target=parse foofoo.p6};
# say $output;

# my @routines = find("'routine_declarator'").map( { $_{'name'} } );

for $output.lines -> $line {
  if $line ~~ /'routine_declarator'/ {
    say $line;
  }
  if $line ~~ /'identifier:' \s+ (.+?)$/ {
    say "Identifier => " ~ ~$/[0]
  } elsif $line ~~ /'quote:' \s+ (.+?)$/ {
    say "Quote      => " ~ ~$/[0]
  } elsif $line ~~ /'variable:' \s+ (.+)$/ {
    say "Variable   => " ~ ~$/[0]
  } elsif $line ~~ /'integer:' \s+ (.+)$/ {
    say "Integer    => " ~ ~$/[0]
  }
}
