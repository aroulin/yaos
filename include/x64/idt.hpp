#include "common_types.hpp"


enum class SystemSegmentType {
    INTR_GATE = 0xE,
    TRAP_GATE = 0xF,
};

namespace IDT {

// TODO: Make sure it is packed ?
struct Descriptor {
    u32 reserved;
    u32 offset_hi32; // Offset 63..32
    u16 offset_hi16; // Offset 31..16
    u16 attrs;
    u16 segment_selector;
    u16 offset_lo16; // Offset 15..0
};

};