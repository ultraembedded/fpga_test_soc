#include "exception.h"
#include "assert.h"
#include "csr.h"

//-----------------------------------------------------------------
// Defines:
//-----------------------------------------------------------------
#define SR_MPP_SHIFT    11
#define SR_MPP_MASK     0x3
#define SR_MPP          (SR_MPP_MASK  << SR_MPP_SHIFT)
#define SR_MPP_M        (3 << SR_MPP_SHIFT)

//-----------------------------------------------------------------
// Locals
//-----------------------------------------------------------------
#define CAUSE_MAX_EXC      (CAUSE_PAGE_FAULT_STORE + 1)
static fp_exception        _exception_table[CAUSE_MAX_EXC];

static fp_irq              _irq_handler     = 0;

void exception_set_irq_handler(fp_irq handler)         { _irq_handler = handler; }
void exception_set_syscall_handler(fp_syscall handler) 
{ 
    _exception_table[CAUSE_ECALL_U] = handler;
    _exception_table[CAUSE_ECALL_S] = handler;
    _exception_table[CAUSE_ECALL_M] = handler;
}
void exception_set_handler(int cause, fp_exception handler)
{
    _exception_table[cause] = handler;
}
//-----------------------------------------------------------------
// exception_handler:
//-----------------------------------------------------------------
struct irq_context * exception_handler(struct irq_context *ctx)
{
#ifndef EXCEPTION_SP_FROM_MSCRATCH
    // Fix-up MPP so that we stay in machine mode
    ctx->status &= ~SR_MPP;
    ctx->status |= SR_MPP_M;
#endif

    // External interrupt
    if (ctx->cause & CAUSE_INTERRUPT)
    {
        if (_irq_handler)
            ctx = _irq_handler(ctx);
        else
            printf("Unhandled IRQ!\n");
    }
    // Exception
    else
    {
        switch (ctx->cause)
        {
            case CAUSE_ECALL_U:
            case CAUSE_ECALL_S:
            case CAUSE_ECALL_M:
                ctx->pc += 4;
                break;
        }

        if (ctx->cause < CAUSE_MAX_EXC && _exception_table[ctx->cause])
            ctx = _exception_table[ctx->cause](ctx);
        else
        {
            printf("Unhandled exception: PC 0x%08x Cause %d!\n", ctx->pc, ctx->cause);
            assert(!"Unhandled exception");
        }
    }

    return ctx;
}