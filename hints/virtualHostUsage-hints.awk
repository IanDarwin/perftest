#! /usr/bin/awk -f

# Pure-Awk Solution for computing virtual host usage

# Function: calculate total bytes transferred to each 
# virtual host, display results in kilobytes

BEGIN {
	# OPTIONAL: Check that two cmd-line args are present (hint: ARGC)
	# If NOT, print an error message and exit with a non-zero return
    }
}

{
# Process each line into one large associative array
# Hint: hostname is field 6, and byte count for this access is field 11.
}

END {
	# Iterate through the associative array, printing each bytecount (convert to KB or MB) {
		printf "%-30s %7.2f K\n", name, byteCount[name] / 1024 | "sort"
	}
}
