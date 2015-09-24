#include "catch.hpp"
#include "io/terminal.hpp"
#include <cstring>

class TestTerminalFormat : public IO::TerminalFormat
{
	unsigned int GetWidth() const
	{
		return 5;
	}

	unsigned int GetHeight() const
	{
		return 6;
	}
};

char buffer[5 * 6];
TestTerminalFormat testTerminalFormat;

#define SMALL_STRING "AAAA"

TEST_CASE("Terminal Simple Print", "[Terminal]")
{
	IO::Terminal terminal(buffer, testTerminalFormat);
	terminal.Print(SMALL_STRING);

	REQUIRE(strncmp(buffer, SMALL_STRING, strlen(SMALL_STRING)) == 0);
}
