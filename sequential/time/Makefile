
CC := gcc
OLVL := 3
OFLAGS := -O$(OLVL) -march=native
CFLAGS := -Wall -Wextra -gdwarf-4
CFLAGS += $(OFLAGS) 

EXE := conversion double_reduc

.PHONY: clean all

all: $(EXE)

%: %.c
	$(CC) $(CFLAGS) $< -o $@

clean: 
	@rm -f $(EXE)
