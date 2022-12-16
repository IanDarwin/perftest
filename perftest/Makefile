report:	large fmt Fmt.class
	runall 

fmt:	fmt.c
	$(CC) $? -o $@

Fmt.class:	Fmt.java
	javac Fmt.java

large:
	cat ../verona.txt  > large
	cat ../verona.txt >> large
	cat ../verona.txt >> large
	cat ../verona.txt >> large
	cat ../verona.txt >> large

clean:
	@rm -f large fmt Fmt.class
