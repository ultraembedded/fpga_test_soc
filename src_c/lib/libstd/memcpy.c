#ifdef CONFIG_USE_LOCAL_STRING_H
#include "_string.h"
#else
#include <string.h>
#endif

//-----------------------------------------------------------------
// memcpy:
//-----------------------------------------------------------------
void *memcpy(void *dst, const void *src, size_t n)
{
	void *ret = dst;

	while (n--)
	{
		*(char *)dst = *(char *)src;
		dst = (char *) dst + 1;
		src = (char *) src + 1;
	}

	return ret;
}
//-----------------------------------------------------------------
// memccpy:
//-----------------------------------------------------------------
void *memccpy(void *dst, const void *src, int c, size_t count)
{
	while (count && (*((char *) (dst = (char *) dst + 1) - 1) =
		*((char *)(src = (char *) src + 1) - 1)) != (char) c)
	count--;

	return count ? dst : 0;
}
