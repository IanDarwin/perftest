# Format text from stdin to be lines containing no more than the specified
# number of characters.
# Written in Bourne shell plus standard filters

# PATH=/usr/bin
maxlinelen=72
status=0    # initialize exit status

# process command line options
usage="Usage: $0 [-c columns]"
if [ "$#" -ne 0 -a "$#" -ne 2 ] ; then
    echo "$usage" 
    status=1
elif [ "$#" -eq 2 ] ; then
    case "$1" in
        -c)    maxlinelen="$2"    
            shift 2
            ;;
        *)    echo "$usage" 
            status=1
            ;;
    esac
fi

# do the formatting
if [ "$status" -eq 0 ] ; then
    linelen=0
    while read line ; do
        if [ "$line" = "" ] ; then    # blank line, so end this paragraph 
            echo        # end current line
            echo        # leave a blank line
            linelen=0
        else
            for word in $line; do
                wordlen=`echo -n "$word" | wc -c`
                if [ "$linelen" -eq 0 ] ; then    # first word of new paragraph
                    echo -n "$word"
                    linelen="$wordlen"
                else
                    # note that wc writes some tabs and spaces, which cause
                    # expr to see "$wordlen" as non-numeric. I omitted the
                    # double-quotes from the next line to allow the shell
                    # to consume that undesired whitespace
                    newlinelen=`expr $linelen + 1 + $wordlen`
                    if [ "$newlinelen" -gt "$maxlinelen" ] ; then
                        echo
                        echo -n "$word"
                        linelen="$wordlen"
                    else
                        echo -n " $word"
                        linelen="$newlinelen"
                    fi
                fi
            done
        fi
    done
    if [ $linelen -gt 0 ] ; then
            echo    # finish final line
    fi
fi
exit "$status"
