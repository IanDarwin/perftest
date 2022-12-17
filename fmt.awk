#! /usr/bin/awk -f
# Format text from stdin to be lines containing no more than the specified
# number of characters.
# Written in awk

# process command line options
BEGIN {
    linelen = 0
    maxlinelen = 72
    if ( ARGC == 1 || ARGC == 3 ) {
      if (ARGC == 3) {
        if (ARGV[1] == "-c" && ARGV[2] ~ /^[0-9]+/) {
            maxlinelen=ARGV[2]
            ARGV[1] = ""
            ARGV[2] = ""
        }
        else {    
            printusage();
            exit 1
        }
      }
    }
    else {
        printusage()
        exit 1
    }
}

# format the input
/[^ \t]/ {         # non-blank line
    for (i = 1; i <= NF; i++) {
        word = $i
        wordlen = length($i)
        if (linelen == 0) {
            printf "%s", word
            linelen = wordlen
        }
        else {
            newlinelen = linelen + 1 + wordlen
            if (newlinelen > maxlinelen) {
                printf "\n%s", word
                linelen = wordlen
            }
            else {
                printf " %s", word
                linelen = newlinelen
            }
        }
    }
}
/^[ \t]*$/ {    # blank line
    printf "\n\n"
    linelen = 0
}
END {
    printf "\n"
    exit 0
}

function printusage() {
    msg = "Usage: " ARGV[0] " [-c columns]"
    print msg 
}

