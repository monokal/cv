cv: cv.asm
	nasm -o $@ $<
	chmod +x cv

.PHONY: clean
clean:
	-rm -vf cv

.PHONY: test
test: cv
	./cv
