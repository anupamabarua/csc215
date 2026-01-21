#include "LINKLIST.H"
#include "BDSCTEST.H"
#define NULL 0

main() {
  START_TESTING("LINKLIST.C");

  TEST_CASE("Test can create node") {
      struct node* mynode;
      mynode = mknode(42);
      ASSERT(mynode->num == 42);
      ASSERT(mynode->next == NULL);
  }

  TEST_CASE("insertBeforeNode") {
    struct node* l4;
    l4 = mknode(10);

    l4 = insertBeforeNode(l4, 0, 10);
    ASSERT(l4->num == 0);

    l4 = insertBeforeNode(l4, 5, 10);
    ASSERT(l4->next->num == 5);
  }

  END_TESTING();
}