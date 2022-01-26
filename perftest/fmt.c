/* Format text from stdin to be lines of no more than the specified
   number of characters. */
/* C language version */

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <unistd.h>

#ifdef DEBUG
#define debug(s, v) fprintf(stderr, s, v)
#else
#define debug(s, v) 
#endif

#define MAXLINELEN 70

void printusage() {
	char msg[] = "Usage: $0 [-c columns]\n";
	fprintf(stderr, msg, sizeof msg);
}

int main(int argc, char *argv[]) {
	long int maxlinelen = MAXLINELEN;
	int status = 0;

	/* process command line options */
	int option;
	opterr = 0;	/* supress getopt error messages */
	while ((option=getopt(argc, argv, ":c:")) != EOF) {
		switch (option) {
			case 'c': 
			  	errno = 0;
			  	maxlinelen = strtol(optarg, NULL, 10);
			  	if ( errno != 0 ) 
					status = 1;
				break;
			default:	
			  	status = 1;
			  	break;
		}
	}
	argv += optind;
	argc -= optind;

	if (status != 0 || argc != 0) 
	  printusage();
	else {
		char line[BUFSIZ] = "";
		int linelen = 0;
		int newlinelen = 0;
	  	char *word = NULL;
		int wordlen = 0;
		while (fgets(line, sizeof line, stdin)) {
		  	word = strtok(line, " \t\n");	/* get the first word */
			if (word == NULL) {
				printf("\n\n");	/* end current line and leave a blank line */
				linelen = 0;
			}
			else 
			  while (word != NULL) {
				wordlen = strlen(word);
				if (linelen == 0) {	/* first word of new paragraph */
					printf("%s", word);
					linelen = wordlen;
				}
				else {
					newlinelen = linelen + 1 + wordlen;
					if (newlinelen > maxlinelen) {
						printf("\n%s", word);
						linelen = wordlen;
					}
					else {
						printf(" %s", word);
						linelen = newlinelen;
					}
				}
				word = strtok(NULL, " \t\n");	/* get the next word */
			}
		}
		if (linelen > 0)
		  putchar('\n');
	}
	return status;
} 
