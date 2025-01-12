package Machinery::Pump;

use 5.006;
use strict;
use warnings;

use Carp qw( croak );

=head1 NAME

Machinery::Pump - A general pump 

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

Quick summary of what the module does.

Perhaps a little code snippet.

    use Machinery::Pump;

    my $foo = Machinery::Pump->new();
    ...

=head1 SUBROUTINES/METHODS

=head2 new( \%options )

Creates a new pump. For C<%options>, only  I<pump_id> is required, see below for more details.

=over 4

=item designed_flowrate => $numerical

The designed flowrate of the pump

=item rps => $integer

The blade spin rate in round per second

=item remote_control => $bool

The ability to control the pump through the DCS

=item status = 0

The status of the pump. This value is always set to 0 upon creation to indicate it is not running. This value can be changed by calling the I<status> method.

=back

=cut

sub new {
    my ( $class, $pump_details ) = @_;
    
    # required keys
    if ( !$pump_details->{ pump_id } ) {
        croak "Missing key: pump_id";
    }
    
    # optional keys
    $pump_details->{ designed_flowrate } = 13 if not exists $pump_details->{ designed_flowrate };
    $pump_details->{ rps } = 2900 if not exists $pump_details->{ rps };
   
   $pump_details->{ remote_control } = "yes" if not exists $pump_details->{ remote_control };
   
   if ( $pump_details->{ remote_control } ne "yes" && $pump_details->{ remote_control } ne "no" ) {
        croak "Invalid value for remote_control";
   }
   
   $pump_details->{ status } = 0 if not exists $pump_details->{ status };
   croak "Danger! Can't run pump during creation..." if $pump_details->{ status };
   
   bless $pump_details, $class;
}


=head2 pump_id

Returns the pump id

=cut

sub pump_id {
    my $pump = shift;
    $pump->{ pump_id };
}

=head2 designed_flowrate( [ $numerical ] )

Gets or sets the designed flowrate, the unit is assumed to be I<m^3 / h>

=cut

sub designed_flowrate {
    my ( $class, $flowrate ) = @_;
    
    if ( $flowrate ) {
        $class->{ designed_flowrate } = $flowrate;
    } else {
        $class->{ designed_flowrate }
    }
    
}

=head2 rps( [ $integer ] )

Gets of sets the rps, the unit is assumed to be in I<seconds>

=cut

sub rps {
    my ( $class, $rps ) = @_;
    
    if ( $rps ) {
        $class->{ rps } = $rps;
    } else {
        $class->{ rps }
    }
    
}

=head2 remote_control( [ "yes" | "no" ] )

Gets of sets the ability to control the pump remotely.

=cut

sub remote_control {
    my ( $class, $remote_control ) = @_;
    
    if ( defined $remote_control) {
        if ( $remote_control eq "yes" || $remote_control eq "no" ) {
            $class->{ remote_control } = $remote_control;
        } else {
            croak "Invalid value for remote_control";
        }
        
    } else {
        $class->{ remote_control }
    }
}

=head1 AUTHOR

Raphael Jong Jun Jie, C<< <ellednera at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-machinery-pump at rt.cpan.org>, or through
the web interface at L<https://rt.cpan.org/NoAuth/ReportBug.html?Queue=Machinery-Pump>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Machinery::Pump


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<https://rt.cpan.org/NoAuth/Bugs.html?Dist=Machinery-Pump>

=item * CPAN Ratings

L<https://cpanratings.perl.org/d/Machinery-Pump>

=item * Search CPAN

L<https://metacpan.org/release/Machinery-Pump>

=back


=head1 ACKNOWLEDGEMENTS

Besiyata d'shmaya

=head1 LICENSE AND COPYRIGHT

This software is Copyright (c) 2025 by Raphael Jong Jun Jie.

This is free software, licensed under:

  The Artistic License 2.0 (GPL Compatible)


=cut

1; # End of Machinery::Pump
