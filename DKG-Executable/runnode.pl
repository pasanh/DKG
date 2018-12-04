#!/usr/bin/perl

use strict;
use File::Basename;
use File::Path qw(make_path remove_tree);
use Cwd 'abs_path';
use Getopt::Long;

my ($log, $share, $benchmark, $phase, $clist);

GetOptions(
    'r:s'   => \$share,
	'l'     => \$log,
	'b'     => \$benchmark,
	'h:i'   => \$phase,
	'c:s'   => \$clist,
);

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
my $timeout_value = "/dev/null";
my $contactlist = "$exe_dir/contlist";

my $node = shift;
print_usage() unless($node);

my $certfile = "$exe_dir/certs/$node.pem";
my $keyfile = "$exe_dir/certs/$node-key.pem";

if($log || $benchmark) {
	remove_tree($log_dir);
	make_path($log_dir);
}

if($clist) {
	$contactlist = "$exe_dir/$clist";
}

my $log_param = '';
if($log) {
	$log_param = "-m $message_log -i $timeout_log";
}

my $benchmark_param = '';
if($benchmark) {
	$benchmark_param = "-t -b $log_dir";
}

my $phase_param = '';
if($phase) {
	$phase_param = "-h $phase";
}

my $share_param = '';
#$share_param .= "-r" if(defined($share));
$share_param .= " -e $share" if(length($share) > 0);

my $cmd = "$node_cmd -a $pairing_param -s $system_param -v $timeout_value $phase_param $log_param $benchmark_param $share_param -d $exe_dir $certfile $keyfile $contactlist";
print "$cmd\n";
exec $cmd;

sub print_usage {
	my $file_name = basename($0);
	die "Run DKG Node:\nUsage $file_name [-l] [-r[share]] node_id\n";
}
