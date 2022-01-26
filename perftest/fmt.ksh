#! /bin/ksh
# Format text from stdin to be lines containing no more than the specified
# number of characters.
# Written in KornShell; no filters required

function printusage {
    msg="Usage: $0 [-c columns]"
    print "$msg" 
    status=1
}

PATH=/usr/bin
maxlinelen=72
status=0    # initialize exit status

# process command line options
while getopts ":c:" option
do
    case $option in
        c)    if [[ $OPTARG != +([0-9]) ]] ; then
                printusage
            else
                maxlinelen=$OPTARG
            fi
            ;;
        *)    printusage
            ;;
    esac
done
shift $(( OPTIND - 1 ))
if [[ $# -ne 0 ]] ; then
    printusage
fi

# do the formatting
if [[ $status -eq 0 ]] ; then
    linelen=0
    while read line ; do
        if [[ $line == *([    ]) ]] ; then # blank line, so end this paragraph 
            print        # end current line
            print        # leave a blank line
            linelen=0
        else
            for word in $line; do
                wordlen=${#word}
                if [[ $linelen -eq 0 ]] ; then  # first word of new paragraph
                    print -nr -- "$word"
                    linelen=$wordlen
                else
                    (( newlinelen = linelen + 1 + wordlen ))
                    if [[ $newlinelen -gt $maxlinelen ]] ; then
                        print
                        print -nr -- "$word"
                        linelen=$wordlen
                    else
                        print -nr -- " $word"
                        linelen=$newlinelen
                    fi
                fi
            done
        fi
    done
    if [[ $linelen -gt 0 ]] ; then
            print    # finish final line
    fi
fi
exit $status
