# Makefile for building parser using bison, flex, and g++

# Files
BISON_FILE = P1.y
FLEX_FILE  = P1.l
BISON_OUT  = P1.tab.c
BISON_HDR  = P1.tab.h
FLEX_OUT   = lex.yy.c
EXEC       = P1
INPUT      = X.Java
OUTPUT	   = P1.output

# Build executable
$(EXEC): $(BISON_OUT) $(FLEX_OUT)
	$(CXX) $(CXXFLAGS) $(BISON_OUT) $(FLEX_OUT) -o $(EXEC)

# Generate bison files
$(BISON_OUT) $(BISON_HDR): $(BISON_FILE)
	bison -d -v $(BISON_FILE)

# Generate flex file (depends on Bison header)
$(FLEX_OUT): $(FLEX_FILE) $(BISON_HDR)
	flex $(FLEX_FILE)

# Clean build files
clean:
	rm -f $(BISON_OUT) $(BISON_HDR) $(FLEX_OUT) $(EXEC) $(OUTPUT)
