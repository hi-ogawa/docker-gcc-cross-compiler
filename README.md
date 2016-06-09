GCC cross compiler for i686-elf following http://wiki.osdev.org/GCC_Cross-Compiler.

```
$ docker build -f Dockerfile.slim -t hiogawa/i686-elf:4.9.3 .
$ docker images
REPOSITORY              TAG                 IMAGE ID            CREATED             SIZE
hiogawa/i686-elf        4.9.3               588d6a8e1a3f        51 minutes ago      864.8 MB
$ docker run --rm hiogawa/i686-elf:4.9.3 i686-elf-gcc --version
i686-elf-gcc (GCC) 4.9.3
Copyright (C) 2015 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
```
