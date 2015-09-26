#include <type_traits>

#include "catch.hpp"
#include "x64/idt.hpp"

static_assert(std::is_pod<IDT::Descriptor>::value, "IDT::Descriptor is not POD.");

TEST_CASE("Can construct a sample IDT", "[IDT]")
{
    IDT::Descriptor idt_desc =
        IDT::ConstructDescriptor()
}