// Avoid C++ name mangling
extern "C" {
    int boot1_main();
}

int boot1_main() {
    char *terminal = (char *)0xB8000;
    for (auto i = 0; i < 85*25; ++i) {
        terminal[2*i] = 'A';
        terminal[2*i+1] = 0x07;
    }
    return 0;
}
