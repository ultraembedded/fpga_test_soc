#ifndef __LIST_H__
#define __LIST_H__

#ifndef LIST_ASSERT
    #define LIST_ASSERT(x)
#endif

//-----------------------------------------------------------------
// Types
//-----------------------------------------------------------------
struct link_list;

struct link_node
{
    struct link_node    *previous;
    struct link_node    *next;
};

struct link_list
{
    struct link_node    *head;
    struct link_node    *tail;
};

//-----------------------------------------------------------------
// Macros
//-----------------------------------------------------------------
#define list_entry(p, t, m)     p ? ((t *)((char *)(p)-(char*)(&((t *)0)->m))) : 0
#define list_next(l, p)         (p)->next
#define list_prev(l, p)         (p)->previous
#define list_first(l)           (l)->head
#define list_last(l)            (l)->tail
#define list_for_each(l, p)     for ((p) = (l)->head; (p); (p) = (p)->next)

//-----------------------------------------------------------------
// Inline Functions
//-----------------------------------------------------------------

//-----------------------------------------------------------------
// list_init: Initialise linked list
//-----------------------------------------------------------------
static inline void list_init(struct link_list *list)
{
    LIST_ASSERT(list);

    list->head = list->tail = 0;
}
//-----------------------------------------------------------------
// list_remove: Remove node from list
//-----------------------------------------------------------------
static inline void list_remove(struct link_list *list, struct link_node *node)
{
    LIST_ASSERT(list);
    LIST_ASSERT(node);

    if(!node->previous)
        list->head = node->next;
    else
        node->previous->next = node->next;

    if(!node->next)
        list->tail = node->previous;
    else
        node->next->previous = node->previous;
}
//-----------------------------------------------------------------
// list_insert_after: Insert 'new_node' after 'node'
//-----------------------------------------------------------------
static inline void list_insert_after(struct link_list *list, struct link_node *node, struct link_node *new_node)
{
    LIST_ASSERT(list);
    LIST_ASSERT(node);
    LIST_ASSERT(new_node);

    new_node->previous = node;
    new_node->next = node->next;
    if (!node->next)
        list->tail = new_node;
    else
        node->next->previous = new_node;
    node->next = new_node;
}
//-----------------------------------------------------------------
// list_insert_before: Insert 'new_node' before 'node'
//-----------------------------------------------------------------
static inline void list_insert_before(struct link_list *list, struct link_node *node, struct link_node *new_node)
{
    LIST_ASSERT(list);
    LIST_ASSERT(node);
    LIST_ASSERT(new_node);

    new_node->previous = node->previous;
    new_node->next = node;
    if (!node->previous)
        list->head = new_node;
    else
        node->previous->next = new_node;
    node->previous = new_node;
}
//-----------------------------------------------------------------
// list_insert_first: Insert 'node' as first item in the list
//-----------------------------------------------------------------
static inline void list_insert_first(struct link_list *list, struct link_node *node)
{
    LIST_ASSERT(list);
    LIST_ASSERT(node);

    if (!list->head)
    {
        list->head = node;
        list->tail = node;
        node->previous = 0;
        node->next = 0;
    }
    else
        list_insert_before(list, list->head, node);
}
//-----------------------------------------------------------------
// list_insert_last: Insert 'node' at the end of the list
//-----------------------------------------------------------------
static inline void list_insert_last(struct link_list *list, struct link_node *node)
{
    LIST_ASSERT(list);
    LIST_ASSERT(node);

    if (!list->tail)
        list_insert_first(list, node);
     else
        list_insert_after(list, list->tail, node);
}
//-----------------------------------------------------------------
// list_is_empty: Returns true if the list is empty
//-----------------------------------------------------------------
static inline int list_is_empty(struct link_list *list)
{
    LIST_ASSERT(list);

    return !list->head;
}

#endif

