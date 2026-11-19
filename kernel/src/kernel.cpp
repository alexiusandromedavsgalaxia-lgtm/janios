#include <stdint.h>

namespace {

constexpr uintptr_t kPl011Base = 0x09000000UL;
constexpr uintptr_t kUartData = kPl011Base + 0x00;
constexpr uintptr_t kUartFlag = kPl011Base + 0x18;
constexpr uint32_t kTransmitFifoFull = 1U << 5;

inline volatile uint32_t& mmio(uintptr_t address) {
    return *reinterpret_cast<volatile uint32_t*>(address);
}

void serial_putc(char value) {
    while ((mmio(kUartFlag) & kTransmitFifoFull) != 0U) {
        asm volatile("yield");
    }
    mmio(kUartData) = static_cast<uint32_t>(value);
}

void serial_write(const char* text) {
    if (text == nullptr) {
        return;
    }

    while (*text != '\0') {
        if (*text == '\n') {
            serial_putc('\r');
        }
        serial_putc(*text);
        ++text;
    }
}

} // namespace

extern "C" [[noreturn]] void kernel_main() {
    serial_write("\nJanOS kernel: ARM64 bring-up\n");
    serial_write("Target: QEMU virt / PL011 UART\n");
    serial_write("State: freestanding kernel entry reached\n");
    serial_write("Next: exception vectors, timer and memory manager\n");

    for (;;) {
        asm volatile("wfe");
    }
}
