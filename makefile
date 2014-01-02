CXX ?= g++
PKG_CONFIG ?= pkg-config

CXXFLAGS ?= -O2
CXXFLAGS += -std=c++0x -Wall -fPIC
CXXFLAGS += $(shell $(PKG_CONFIG) --cflags mozjs-24) \
			$(shell $(PKG_CONFIG) --cflags hexchat-plugin)
LDFLAGS += -shared
LIBS += $(shell $(PKG_CONFIG) --libs mozjs-24)
OUTFILE := javascript.so
INSTALLDIR := $(DESTDIR)$(shell $(PKG_CONFIG) --variable=hexchatlibdir hexchat-plugin)

all:
	$(CXX) $(CXXFLAGS) $(LDFLAGS) javascript.cpp -o $(OUTFILE) $(LIBS)

clean:
	rm $(OUTFILE)

install:
	install -m644 -D $(OUTFILE) "$(INSTALLDIR)/$(OUTFILE)"

uninstall:
	rm -f "$(INSTALLDIR)/$(OUTFILE)"
