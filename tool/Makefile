.PHONY: all clean

CC := gcc
CFLAGS := -O3 -std=c99 -Wall -Wextra -Wno-missing-field-initializers

tools := \
	gbstrim
all: $(tools)
	@:

clean:
	rm -f $(tools)

%: %.c
	$(CC) $(CFLAGS) -o $@ $<
