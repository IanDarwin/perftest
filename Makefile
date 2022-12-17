report:	large fmt Fmt.class
	runall | tee report

fmt:	fmt.c
	$(CC) $? -o $@

Fmt.class:	Fmt.java
	javac Fmt.java

large:
	for n in 1 2 3 4 5; do cat verona.txt >> large; done

clean:
	@rm -f large fmt Fmt.class
