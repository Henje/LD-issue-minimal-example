void print(const char *str) {
	short *video = (short*) 0xb8000;
	for(int i = 0; str[i]; i++) {
		video[i] = 0x0700 | str[i];
	}
}

extern "C"
void init() {
	const char *msg = "Hello World!";
	print(msg);
	while(1);
}
