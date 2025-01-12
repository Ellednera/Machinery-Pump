#!/usr/bin/perl

use strict;
use warnings;

use Machinery::Pump;
use Test::More;

# pump with some details
ok (
    my $pump_01 = Machinery::Pump->new( {
        pump_id => "P-01",
        designed_flowrate => 13, # 13 m^3 / h
        rps => 2900,
        remote_control => "yes",
    } ),
    "Pump created successfully"
);

is ( ref $pump_01, "Machinery::Pump", "Correct class name" );

subtest "Checking P-01..." => sub {
    ok( $pump_01->pump_id, "pump_id method invoked successfully" );
    is( $pump_01->pump_id, "P-01", "Correct pump id" );
    
    ok( $pump_01->designed_flowrate, "designed_flowrate method invoked successfully" );
    is( $pump_01->designed_flowrate, 13, "Correct designed flowrate" );
    ok( $pump_01->designed_flowrate( 25 ), "Changed designed flowrate" );
    is( $pump_01->designed_flowrate, 25, "New designed flowrate is correct" );
    
    ok( $pump_01->rps, "rps method invoked successfully" );
    is( $pump_01->rps, 2900, "Correct rps" );
    ok( $pump_01->rps( 3500 ), "Changed rps" );
    is( $pump_01->rps, 3500, "New rps is correct" );
    
    ok( $pump_01->remote_control, "remote_control method invoked successfully" );
    is( $pump_01->remote_control, "yes", "Pump can be controlled remotely" );
    ok( $pump_01->remote_control( "no" ), "Removed remote control feature" );
    is( $pump_01->remote_control, "no", "Pump can't be controlled remotely anymore :(" );
    
    eval {
        $pump_01->remote_control( "huh?" );
    };
    like( $@, qr/Invalid value for remote_control/, "Detected strange value for remote_control" );
    
};


subtest "Checking P-02" => sub {
    my $pump_02;
    
    eval { my $pump_02 = Machinery::Pump->new };
    
    like( $@, qr/pump_id/, "Detected missing pump id" );
    is( $pump_02, undef, "Pump 2 not created" );
};


done_testing();

# besiyata d'shmaya
