#!/usr/bin/perl

open(MYFILE, "/etc/passwd") || die "Can't open passwd file";
while (<MYFILE>) {
	print;
}

