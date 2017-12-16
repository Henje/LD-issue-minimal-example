#!/bin/bash

clang++ -ffreestanding -target i386-unknown-elf -o main.o main.cpp -c
clang -ffreestanding -target i386-unknown-elf -o start.o start.S -c

ld -T linker.ld *.o -o kernel -melf_i386
gold -T linker.ld *.o -o kernel2

if hash ld.lld 2>/dev/null; then
	ld.lld -T linker.ld *.o -o kernel3 || true
elif hash ld.lld-4.0 2>/dev/null; then
	ld.lld-4.0 -T linker.ld *.o -o kernel3 || true
elif hash ld.lld-5.0 2>/dev/null; then
	ld.lld-5.0 -T linker.ld *.o -o kernel3 || true
elif hash ld.lld-6.0 2>/dev/null; then
	ld.lld-6.0 -T linker.ld *.o -o kernel3 || true
fi

readelf -l kernel*
