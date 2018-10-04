%.o: %.c *.h
	$(CC) -c $(CPPFLAGS) $(CFLAGS) -o $@ $<

obj-y += alpha.o

all: $(obj-y)

clean:
	@rm -f *.o

include $(CURDIR)/../scripts/objects.Makefile
