#pragma once

namespace IO {

/**
 * Provides the Terminal with the format information it needs
 * to operate correctly.
 */
class TerminalFormat
{
public:

	/**
	 * The width of the terminal (unit: #characters).
	 */
	virtual unsigned int GetWidth() const = 0;

	/**
	 * The height of the terminal (unit: #characters).
	 */
	virtual unsigned int GetHeight() const = 0;
};

/**
 * Emulates a terminal in a statically sized buffer.
 */
class Terminal
{
public:
	Terminal(char * const buffer, TerminalFormat &format);

	unsigned int Print(const char *str);
private:
	TerminalFormat &format;
	char * const buffer;
};

};
