#ifndef __IRQ_H__
#define __IRQ_H__

#include "csr.h"

//--------------------------------------------------------------------------
// irq_critical_start:
//--------------------------------------------------------------------------
static inline int irq_critical_start(void)
{
    int ret = csr_get_irq_enable();
    csr_clr_irq_enable();
    return ret;
}
//--------------------------------------------------------------------------
// irq_critical_end:
//--------------------------------------------------------------------------
static inline void irq_critical_end(int cr)
{
    if (cr)
        csr_set_irq_enable();
}

#endif
