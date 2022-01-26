#! /usr/bin/perl 
# Format text from stdin to be lines containing no more than the specified
# number of characters.
# Written in Perl

use Getopt::Std;

$usage = "Usage: $0 [-c columns]\n";

@ARGV == 0 || @ARGV == 2 or die $usage;

$status = 0;    # initialize exit status

# process command line options
$opt_c = "72";
if (!getopts('c:') || $opt_c !~ /^\d+$/) {
        die $usage;
}
else {
        $maxlinelen = $opt_c;
}

# do the formatting
if ($status == 0) {
    $linelen = 0;
    while (<>) {
      if  (/^\s+$/) {     # blank line, so end this paragraph 
            print "\n";        # end current line and leave a blank line
            $linelen = 0;
      }
      else {
            foreach $word (split()) {
                $wordlen = length($word);
                if ($linelen == 0) {    # first word of new paragraph
                    print "\n$word";
                    $linelen = $wordlen;
                }
                else {
                    $newlinelen = $linelen + 1 + $wordlen;
                    if ($newlinelen > $maxlinelen) {
                        print "\n$word";
                        $linelen = $wordlen;
                    }
                    else {
                        print " $word";
                        $linelen = $newlinelen;
                    }
                }
            }
        }
    }
    if ($linelen > 0) {
            print "\n";    # finish final line
    }
}
exit $status;
