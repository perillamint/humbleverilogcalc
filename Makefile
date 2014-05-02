COMPILER := iverilog
SIMULATOR := vvp
VIEWER := gtkwave

COMFLAGS := 
SIMFLAGS := -v

SRCS = $(wildcard *_tb.v)
VVPS = $(patsubst %.v,%.vvp,$(SRCS))
VCDS = $(patsubst %.v,%.vcd,$(SRCS))

all: $(VVPS)

simulate: $(VCDS)

clean:
	rm $(wildcard *.vvp) $(wildcard *.vcd)

$(VVPS): %_tb.vvp: %_tb.v
	$(COMPILER) $(COMFLAGS) -o $@ $<

$(VCDS): %.vcd: %.vvp
	$(SIMULATOR) $(SIMFLAGS) $<
