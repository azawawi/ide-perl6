#!/usr/bin/env perl6

use v6;
use JSON::Fast;
use Data::Dump;

my $debug-file-name = $*SPEC.catdir(
  $?FILE.IO.parent,
  "perl6-langserver.log"
);
my $debug-file = $debug-file-name.IO.open(:w);

my %text-documents;

debug-log("🙂: Starting perl6-langserver... Reading/writing stdin/stdout.");

my $initialized = False;
loop {
  my %headers;
  for $*IN.lines -> $line {
    debug-log("\c[Bell]: {$line.perl}");

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
      my $id      = $request<id>;
      my $method  = $request<method>;
      debug-log("\c[BELL]: {Dump($request, :!color)}");
      
      #TODO throw an exception if a method is called before $initialized = True
      given $method {
        when 'initialize' {
          my $result = initialize($request<params>);
          send-json-response($id, $result);
        }
        when 'initialized' {
          # Initialization done
          debug-log("🙂: Initialized handshake!");
          $initialized = True;
        }
        when 'textDocument/didOpen' {
          text-document-did-open($request<params>);
        }
        when 'shutdown' {
          # Client requested server graceful shutdown
          shutdown;
          last;
        }
      }
  }

}
debug-log("Perl 6 Langserver is now off.");

sub debug-log($text) {
  $debug-file.say($text);
  $debug-file.flush;
}

sub send-json-response($id, $result) {
  my %response = %(
    jsonrpc => "2.0",
    id       => $id,
    result   => $result,
  );
  my $json-response = to-json(%response, :!pretty);
  my $content-length = $json-response.chars;
  my $response = "Content-Length: $content-length\r\n\r\n$json-response\r\n";
  print($response);
  debug-log("\c[BELL]: {$response.perl}");
}

sub initialize(%params) {
  debug-log("\c[Bell]: initialize({%params.perl})");
  debug-log("-" x 80);
  %(
    capabilities => {
      # TextDocumentSyncKind.Full
      # Documents are synced by always sending the full content of the document.
      textDocumentSync => 1,
    }
  )
#%(
  # capabilities => %(
  #   textDocument => %(
  #     synchronization => %(
  #       didSave => 1
  #     )
  #   )
  # )
#)
}

sub text-document-did-open(%params) {
  debug-log("\c[Bell]: text-document-did-open({%params.perl})");
  debug-log("-" x 80);
  my %text-document = %params<textDocument>;
  %text-documents{%text-document<uri>} = %text-document;
  debug-log(%text-documents.perl);
  return;
}

sub shutdown {
  debug-log("\c[Bell]: shutdown called, cya 👋");
  debug-log("-" x 80);
}
