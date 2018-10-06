#!/usr/bin/env perl6

use v6;
use JSON::Fast;

my $debug-file-name = $*SPEC.catdir(
  $?FILE.IO.parent,
  "..",
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
      debug-log("\c[BELL]: {$request.perl}");

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
        when 'textDocument/didSave' {
          text-document-did-save($request<params>);
        }
        when 'textDocument/didChange' {
          text-document-did-change($request<params>);
        }
        when 'textDocument/didClose' {
          text-document-did-close($request<params>);
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

sub send-json-request($method, %params) {
  my %request = %(
    jsonrpc  => "2.0",
    'method' => $method,
    params   => %params,
  );
  my $json-request = to-json(%request, :!pretty);
  debug-log(to-json(%request, :pretty));
  my $content-length = $json-request.chars;
  my $request = "Content-Length: $content-length\r\n\r\n$json-request\r\n";
  print($request);
  debug-log("\c[BELL]: {$request.perl}");
}

sub initialize(%params) {
  debug-log("\c[Bell]: initialize({%params.perl})");
  debug-log("-" x 80);
  %(
    capabilities => {
      # TextDocumentSyncKind.Full
      # Documents are synced by always sending the full content of the document.
      textDocumentSync => 1,
      # textDocument => {
      #   synchronization => {
      #     didSave => 1
      #   },
      # },
      workspace => {
        applyEdit => False,
        workspaceEdit => {
          documentChanges => False
        },
      }
    }
  )
}

sub text-document-did-open(%params) {
  debug-log("\c[Bell]: text-document-did-open({%params.perl})");
  debug-log("-" x 80);
  my %text-document = %params<textDocument>;
  %text-documents{%text-document<uri>} = %text-document;
  debug-log(%text-documents.perl);

  publish-diagnostics(%text-document<uri>);
}

sub publish-diagnostics($uri) {
  
	#TODO we need some lock protection

  my @errors;
  @errors.push: %(
    range => {
      start => {
        line => 1,
        character => 0
      },
      end   => {
        line => 1,
        character => 0
      },
    },
    # TODO see DiagnosticSeverity 1 => ERROR
    severity => 1,
    source  => 'perl6 -c',
    message => "Some weird Perl 6 Error message!",
  );

  my %parameters = %(
    uri         => $uri,
    diagnostics => @errors,
  );
  send-json-request('textDocument/publishDiagnostics', %parameters);
}


sub text-document-did-save(%params) {
  debug-log("\c[Bell]: text-document-did-save({%params.perl})");
  debug-log("-" x 80);

  my %text-document = %params<textDocument>;

  publish-diagnostics(%text-document<uri>);

  return;
}

sub text-document-did-change(%params) {
  debug-log("\c[Bell]: text-document-did-change{%params.perl})");
  debug-log("-" x 80);
  #TODO update textDocument with contentChanges
  my %text-document = %params<textDocument>;
  # %text-documents{%text-document<uri>} = %text-document;
  # debug-log(%text-documents.perl);

  publish-diagnostics(%text-document<uri>);

  return;
}

sub text-document-did-close(%params) {
  debug-log("\c[Bell]: text-document-did-close({%params.perl})");
  debug-log("-" x 80);
  my %text-document = %params<textDocument>;
  %text-documents{%text-document<uri>}:delete;
  debug-log(%text-documents.perl);

  return;
}

sub shutdown {
  debug-log("\c[Bell]: shutdown called, cya 👋");
  debug-log("-" x 80);
}
