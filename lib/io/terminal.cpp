#include "io/terminal.hpp"

IO::Terminal::Terminal(char * const buffer, TerminalFormat &format) : buffer(buffer), format(format)
{
}

unsigned int IO::Terminal::Print(const char *str)
{
	const char *pSrc = str;
	char *pDest = buffer;
	
	while ((*pDest++ = *pSrc++));

	return (unsigned int)(pDest - buffer);
}
