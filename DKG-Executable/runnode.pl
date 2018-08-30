#!/usr/bin/perl

use strict;
use File::Basename;
use File::Path qw(make_path remove_tree);
use Cwd 'abs_path';

my $username = $ENV{LOGNAME} || $ENV{USER};

my $exe_dir = dirname(abs_path($0));
my $base_dir = dirname($exe_dir);
my $src_dir = "$base_dir/src";
my $log_dir = "/tmp/$username/dkg";

my $node_cmd = "$src_dir/node";
my $pairing_param = "$exe_dir/pairing.param";
my $system_param = "$exe_dir/system.param";
my $message_log = "$log_dir/message.log";
my $timeout_log = "$log_dir/timeout.log";
my $contactlist = "$exe_dir/contlist";

my $node = shift;
print_usage() unless($node);

my $certfile = "$exe_dir/certs/$node.pem";
my $keyfile = "$exe_dir/certs/$node-key.pem";

remove_tree($log_dir);
make_path($log_dir);

my $cmd = "$node_cmd -a $pairing_param -s $system_param -m $message_log -t $timeout_log -h 0 -c 0 -l 0 $certfile $keyfile $contactlist";
print "$cmd\n";
exec $cmd;

sub print_usage {
	my $file_name = basename($0);
	die "Run DKG Node:\nUsage $file_name node_id\n";
}
