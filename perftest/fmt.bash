#! /usr/local/bin/bash
# Format text from stdin to be lines containing no more than the specified
# number of characters.
# Written in Bash shell using built-in string operators; no filters needed

PATH=/usr/bin
maxlinelen=72
status=0    # initialize exit status

# process command line options
usage="Usage: $0 [-c columns]"
if [[ $# -ne 0 && $# -ne 2 ]] ; then
    echo "$usage" 
    status=1
elif [[ $# -eq 2 ]] ; then
    case $1 in
        -c)    maxlinelen=$2    
            shift 2
            ;;
        *)    echo "$usage" 
            status=1
            ;;
    esac
fi

# do the formatting
if [[ $status -eq 0 ]] ; then
    linelen=0
    while read line ; do
        if [[ $line == "" ]] ; then    # blank line, so end this paragraph 
            echo        # end current line
            echo        # leave a blank line
            linelen=0
        else
            for word in $line; do
                wordlen=${#word}
                if [[ $linelen -eq 0 ]] ; then    # first word of new paragraph
                    echo -n "$word"
                    linelen=$wordlen
                else
                    (( newlinelen = $linelen + 1 + $wordlen ))
                    if [[ $newlinelen -gt $maxlinelen ]] ; then
                        echo
                        echo -n "$word"
                        linelen=$wordlen
                    else
                        echo -n " $word"
                        linelen=$newlinelen
                    fi
                fi
            done
        fi
    done
    if [[ $linelen -gt 0 ]] ; then
            echo    # finish final line
    fi
fi
exit $status
