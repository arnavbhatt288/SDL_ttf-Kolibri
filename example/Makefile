CC = kos32-gcc
LD = kos32-ld
OBJCOPY = kos32-objcopy

SDK_DIR = ../../..
LDFLAGS = -nostdlib -static --image-base 0 -T $(SDK_DIR)/sources/newlib/app.lds --subsystem native
CFLAGS = -c -fno-ident -O2 -fomit-frame-pointer -U__WIN32__ -U_Win32 -U_WIN32 -U__MINGW32__ -UWIN32 -D_KOLIBRI
LIBS = -lSDL2_ttf -lSDL2 -lfreetype -lgcc -lc.dll -lc -lsound

INCLUDES = -I $(SDK_DIR)/sources/newlib/libc/include -I../ -I../../SDL-2.30.3/include/
LIBPATH = -L $(SDK_DIR)/lib -L /home/autobuild/tools/win32/mingw32/lib

default: examples

examples: $(OBJECTS) Makefile
	$(CC) $(CFLAGS) $(INCLUDES) -o showfont.o showfont.c
	$(LD) $(LDFLAGS) $(LIBPATH) --subsystem native -o showfont showfont.o $(LIBS)
	kos32-strip -s showfont -o showfont
	kos32-objcopy showfont -O binary
	rm showfont.o

clean:
	rm showfont
