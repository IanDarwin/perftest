#!/local/bin/perl -w

# Test suite for Chapter 7.
sub trying {
        print "Trying items $_[0]\n";
}

&trying("Caveats, page 10");
$favbird = "Ostrich";
print $favbird"\n";
print "item is $favbird\n" if defined $favbird;

# &trying("Perl's Special Variables", page 18");
#@a = ("gone", "with", "the", "wind");
#foreach (@a) {
#       print
#}

&trying("Other Control Expressions, page 20");
$n = 41;
$n < 42 && print "$n\n";
$n >= 42 || print "$n\n";

#&trying("Extensibility 1: Subroutines, p 22");
#sub x {
#       $_[0] +1;
#}
#print "x(42) is ", &x(42), "\n";


# # who | wc -l, but we do the counting
#foreach $_ (`who`) {
#        ++$nusers
#}
#print "We counted $nusers users logged in\n";

# # who | wc -l, very inefficiently
#open(WHO, "who|");
#open(WC, "|wc -l");
#print "Wc -l counted...\n";
#while(<WHO>) {
#	print WC $_
#}

&trying("Network client");
require "sys/socket.ph";
$sockaddr = 'S n a4 x8';
chop($host = `hostname`);
($name, $aliases, $proto) = getprotobyname('tcp');
($name, $aliases, $port) = getservbyname('daytime', 'tcp');
($name, $aliases, $type, $len, $thisaddr) = gethostbyname($host);
$servport = pack($sockaddr, &AF_INET, $port, $thisaddr);
socket(S, &PF_INET, &SOCK_STREAM, $proto) || die("socket");
connect(S, $servport) || die("connect");
while (<S>) {
	print;
}
exit 0;
