CC = gcc
CFLAGS = -Wall -O2
LDFLAGS = -O2
LDLIBS = -lstdc++ -lm

SOURCES = sassc.c
OBJECTS = $(SOURCES:.c=.o)
TARGET = bin/sassc

all: libsass $(TARGET)

$(TARGET): $(OBJECTS) libsass/libsass.a
	$(CC) $(LDFLAGS) -o $@ $^ $(LDLIBS)

libsass:
	$(MAKE) -C libsass

%.o: %.c
	$(CC) -c $(CFLAGS) $< -o $@

test: all
	ruby spec.rb spec/basic/

test_all: all
	ruby spec.rb spec/

clean:
	rm -f $(OBJECTS) $(TARGET)
	$(MAKE) -C libsass clean

.PHONY: clean libsass test test_all

