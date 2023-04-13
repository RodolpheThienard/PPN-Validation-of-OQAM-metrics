
CC := aarch64-linux-gnu-gcc
OLVL := 3
OFLAGS := -O$(OLVL) -march=armv8-a
CFLAGS := -Wall -Wextra -gdwarf-4
CFLAGS += $(OFLAGS) 

EXE := conversion double_reduc

.PHONY: clean all

all: $(EXE)

%: %.c
	$(CC) $(CFLAGS) $< -o $@

clean: 
	@rm -f $(EXE)
