#ifdef CONFIG_USE_LOCAL_STRING_H
#include "_string.h"
#else
#include <string.h>
#endif

//-----------------------------------------------------------------
// strspn:
//-----------------------------------------------------------------
size_t strspn(const char *s1, const char *s2)
{
	const char *s = s1;
	const char *c;

	while (*s1)
	{
		for (c = s2; *c; c++)
			if (*s1 == *c)
				break;
		
		if (*c == '\0')
			break;
		s1++;
	}

	return s1 - s;
}
//-----------------------------------------------------------------
// strtok:
//-----------------------------------------------------------------
char * strtok(char *s1, const char *delimit)
{
	// WARNING: Unsafe shared static!
	static char *lastToken = 0; 
	char *tmp;

	/* Skip leading delimiters if new string. */
	if ( !s1 ) 
	{
		s1 = lastToken;
		if (!s1 )         /* End of story? */
			return 0;
	} 
	else 
		s1 += strspn(s1, delimit);

	/* Find end of segment */
	tmp = strpbrk(s1, delimit);
	if (tmp) 
	{
		/* Found another delimiter, split string and save state. */
		*tmp = '\0';
		lastToken = tmp + 1;
	} 
	else 
	{
		/* Last segment, remember that. */
		lastToken = 0;
	}

	return s1;
}
