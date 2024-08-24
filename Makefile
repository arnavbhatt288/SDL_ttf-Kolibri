CC = kos32-gcc
AR = kos32-ar
LD = kos32-ld
STRIP = kos32-strip

LIBNAME=libSDL2_ttf

LIBS:= -lSDL2 -lfreetype -lgcc -lc.dll -ldll -lsound

LDFLAGS+= -shared -s -T dll.lds --entry _DllStartup --image-base=0 --out-implib $(LIBNAME).dll.a
LDFLAGS+= -L/home/autobuild/tools/win32/mingw32/lib -L../../lib

OBJS =	SDL_ttf.o

CFLAGS = -c -O2 -mpreferred-stack-boundary=2 -fno-ident -fomit-frame-pointer -fno-stack-check \
-fno-stack-protector -mno-stack-arg-probe -fno-exceptions -fno-asynchronous-unwind-tables \
-ffast-math -mno-ms-bitfields -march=pentium-mmx \
-U_Win32 -UWIN32 -U_WIN32 -U__MINGW32__ -U__WIN32__ \
-I../newlib/libc/include/ -I../SDL-2.30.3/include/ -I../freetype/include/ -I.. \

all:  $(LIBNAME).a $(LIBNAME).dll

$(LIBNAME).a: $(OBJS)
	$(AR) -crs  ../../lib/$@ $^

$(LIBNAME).dll: $(OBJS)
	$(LD) $(LDFLAGS) -o $@ $^ $(LIBS)
	$(STRIP) -S $@

%.o : %.c Makefile
	$(CC) $(CFLAGS) -o $@ $<

clean:
	rm -f $(OBJS) ../../lib/$(LIBNAME).a $(LIBNAME).dll $(LIBNAME).dll.a
