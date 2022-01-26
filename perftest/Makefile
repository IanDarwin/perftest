report:	large fmt Fmt.class
	rm -f /tmp/id
	runall >/tmp/id 2>&1
	mkreport < /tmp/id

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
