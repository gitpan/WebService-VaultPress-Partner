package WebService::VaultPress::Partner::Response;
use Moose;
use namespace::autoclean;

our $VERSION = '0.02';
$VERSION = eval $VERSION;

has is_success  => ( is => 'ro', isa => 'Str', required => 1 );
has api_call    => ( is => 'ro', isa => 'Str' );
has error       => ( is => 'ro', isa => 'Str' );
has ticket      => ( is => 'ro', isa => 'Str' );
has unused      => ( is => 'ro', isa => 'Int' );
has basic       => ( is => 'ro', isa => 'Int' );
has premium     => ( is => 'ro', isa => 'Int' );
has email       => ( is => 'ro', isa => 'Str' );
has lname       => ( is => 'ro', isa => 'Str' );
has fname       => ( is => 'ro', isa => 'Str' );
has created     => ( is => 'ro', isa => 'Str' );
has type        => ( is => 'ro', isa => 'Str' );
has redeemed    => ( is => 'ro', isa => 'Str' );

__PACKAGE__->meta->make_immutable;

1;

=head1 NAME

WebService::VaultPress::Partner::Response - The VaultPress Partner API Client Response Object

=head1 VERSION

version 0.01.00

=head1 SYNOPSIS

  #!/usr/bin/perl
  use warnings;
  use strict;
  use Carp;
  use WebService::VaultPress::Partner;

  my $VP = WebService::VaultPress::Partner->new(
      key => 'Your Key Goes Here',
  );

  sub handle_error {
      my ( $res ) = @_;
      croak "Failed during " . $res->api_call . " with error: " . $res->error
          unless $res->is_success;
  }

  # How many people signed up.
  my $result = $VP->GetUsage; 
  
  handle_error($result);

  printf( "%7s => %5d\n", $_, $result->$_ ) for qw/ unused basic premium /;


  # Print A Nice History Listing
  printf( "\033[1m| %-20s | %-20s | %-30s | %-19s | %-19s | %-7s |\n\033[0m", 
      "First Name", "Last Name", "Email Address", "Created", "Redeemed", "Type");

  my @results = $VP->GetHistory; 
  
  handle_error( $results[0] );

  for my $obj ( $VP->GetHistory ) {
      printf( "| %-20s | %-20s | %-30s | %-19s | %-19s | %-7s |\n", $obj->fname, 
          $obj->lname, $obj->email, $obj->created, $obj->redeemed, $obj->type );
  }


  # Give Alan Shore a 'Golden Ticket' to VaultPress

  my $ticket = $VP->CreateGoldenTicket(
      fname => 'Alan',
      lname => 'Shore',
      email => 'alan.shore@gmail.com',
  ); handle_error( $ticket );

  print "You can sign up for your VaultPress account <a href=\"" 
      . $ticket->ticket ."\">Here!</a>\n";

=head1 DESCRIPTION

This document outlines the methods available through the
WebService::VaultPress::Partner::Response class.  You should not instantiate
an object of this class yourself when using WebService::VaultPress::Partner,
it is returned in response to a request.  Please extend this class when
adding new methods to WebService::VaultPress::Partner. 

WebService::VaultPress::Partner is a set of Perl modules that provide a simple and 
consistent Client API to the VaultPress Partner API.  The main focus of 
the library is to provide classes and functions that allow you to quickly 
access VaultPress from Perl applications.

The modules consist of the WebService::VaultPress::Partner module itself as well as a 
handful of WebService::VaultPress::Partner::Request modules as well as a response object,
WebService::VaultPress::Partner::Response, that provides consistent error and success 
methods.

=head1 METHODS

=over 4

=item is_success

=over 4

=item Set By

WebService::VaultPress::Partner->CreateGoldenTicket
WebService::VaultPress::Partner->GetHistory
WebService::VaultPress::Partner->GetRedeemedHistory
WebService::VaultPress::Partner->GetUsage

=item Value Description

Set 0 or 1.  1 Indicates a successful execution of the request and a successful response
from the VaultPress API server.  0 indicates a failure to execute the request or a failure
returned by the VaultPress API Server.  When set to 0 the response object is guaranteed
to have an error method.

=back

=item api_call

=over 4

=item Set By

WebService::VaultPress::Partner->CreateGoldenTicket
WebService::VaultPress::Partner->GetHistory
WebService::VaultPress::Partner->GetRedeemedHistory
WebService::VaultPress::Partner->GetUsage

=item Value Description

The name of the request type for which this is a response of.  "CreateGoldenTicket"
or a response to ->CreateGoldenTicket, "GetHistory" for a response to ->GetHistory 
and so on.

=back

=item error

=over 4

=item Set By

WebService::VaultPress::Partner->CreateGoldenTicket
WebService::VaultPress::Partner->GetHistory
WebService::VaultPress::Partner->GetRedeemedHistory
WebService::VaultPress::Partner->GetUsage

=item Value Description

An error string.  This is guaranteed to be set when ->is_success returns 0.
Otherwise may be undef or may be "".

=back

=item ticket

=over 4

=item Set By

WebService::VaultPress::Partner->CreateGoldenTicket

=item Value Description

Upon a successful execution and return of ->CreateGoldenTicket this will hold a string
for whose value is  theURL for the user to redeem her Golden Ticket.

=back

=item unused

=over 4

=item Set By

WebService::VaultPress::Partner->GetUsage

=item Value Description

Upon a successful execution and return of ->GetUsage this will hold an 
integer whose value is the number of Golden Tickets created for which there
has yet to be a redemption.

=back

=item basic

=over 4

=item Set By

WebService::VaultPress::Partner->GetUsage

=item Value Description

Upon a successful execution and return of ->GetUsage this will hold an 
integer whose value is the number of Golden Tickets created for which there
was redemption of as an account type 'basic'.

=back

=item premium

=over 4

=item Set By

WebService::VaultPress::Partner->GetUsage

=item Value Description

Upon a successful execution and return of ->GetUsage this will hold an 
integer whose value is the number of Golden Tickets created for which there
was redemption of as an account type 'premium'.

=back

=item email

=over 4

=item Set By

WebService::VaultPress::Partner->GetHistory
WebService::VaultPress::Partner->GetRedeemedHistory

=item Value Description

Upon successful execution and return of ->GetHistory or ->GetRedeemedHistory
this will hold a string whose value is the email address of the user for whom a 
Golden Ticket was issued.

=back

=item fname

=over 4

=item Set By

WebService::VaultPress::Partner->GetHistory
WebService::VaultPress::Partner->GetRedeemedHistory

=item Value Description

Upon successful execution and return of ->GetHistory or ->GetRedeemedHistory
this will hold a string whose value is the first name of the user for whom a 
Golden Ticket was issued.

=back

=item lname

=over 4

=item Set By

WebService::VaultPress::Partner->GetHistory
WebService::VaultPress::Partner->GetRedeemedHistory

=item Value Description

Upon successful execution and return of ->GetHistory or ->GetRedeemedHistory
this will hold a string whose value is the last name of the user for whom a 
Golden Ticket was issued.

=back

=item created

=over 4

=item Set By

WebService::VaultPress::Partner->GetHistory
WebService::VaultPress::Partner->GetRedeemedHistory

=item Value Description

Upon successful execution and return of ->GetHistory or ->GetRedeemedHistory
this will hold a string whose value is the date and time when the Golden Ticket
was created.  The format is 'YYYY-MM-DD HH:MM:SS'

=back

=item <ype

=over 4

=item Set By

WebService::VaultPress::Partner->GetHistory
WebService::VaultPress::Partner->GetRedeemedHistory

=item Value Description

Upon successful execution and return of ->GetHistory or ->GetRedeemedHistory
this will hold a string whose value is the type of service for which the Golden Ticket
was redeemed for.  'basic' or 'premium'.  In a case where the Golden Ticket has
not been redeemed this will be "".

=back

=item redeemed

=over 4

=item Set By

WebService::VaultPress::Partner->GetHistory
WebService::VaultPress::Partner->GetRedeemedHistory

=item Value Description

Upon successful execution and return of ->GetHistory or ->GetRedeemedHistory
this will hold a string whose value is the date and time when the Golden Ticket
was created.  The format is 'YYYY-MM-DD HH:MM:SS'

If the Golden Ticket has not been redeemed the value will be '0000-00-00 00:00:00'.

GetRedeemedHistory will not return results in the set which has not been redeemed.

=back

=back

=head1 SEE ALSO

WebService::VaultPress::Partner VaultPress::Partner::Request::History VaultPress::Partner::Usage
WebService::VaultPress::Partner::GoldenTicket

=head1 AUTHOR

SymKat I<E<lt>symkat@symkat.comE<gt>>

=head1 COPYRIGHT AND LICENSE

This is free software licensed under a I<BSD-Style> License.  Please see the
LICENSE file included in this package for more detailed information.

=head1 AVAILABILITY

The latest version of this software is available through GitHub at
https://github.com/mediatemple/webservice-vaultpress-partner/

=cut
