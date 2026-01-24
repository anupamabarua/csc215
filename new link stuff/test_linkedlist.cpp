#include <iostream>
#include <cstdlib>
#include "LinkedList.h"

static void ASSERT(bool cond, const char* msg) {
    if (!cond) {
        std::cerr << "FAIL: " << msg << "\n";
        std::exit(1);
    }
}

int main() {
    // 17.1 Node test
    Node* node1 = new Node(1, nullptr);
    ASSERT(node1->to_str() == "1", "Node to_str should be \"1\"");
    delete node1;

    // 17.1 link 3 nodes
    Node* a = new Node(1, nullptr);
    Node* b = new Node(2, nullptr);
    Node* c = new Node(3, nullptr);
    a->next = b;
    b->next = c;

    ASSERT(render_list(a) == "1, 2, 3", "render_list should be \"1, 2, 3\"");
    ASSERT(render_list_backward(a) == "3, 2, 1", "render_list_backward should be \"3, 2, 1\"");

    // clean up the 3-node chain
    delete c;
    delete b;
    delete a;

    // 17.9 LinkedList wrapper tests
    LinkedList list;
    ASSERT(list.empty(), "new list should be empty");
    ASSERT(list.size() == 0, "new list size should be 0");
    ASSERT(list.to_string() == "()", "empty list should render as ()");

    list.insert_at_front(3);
    list.insert_at_front(2);
    list.insert_at_front(1);

    ASSERT(list.size() == 3, "size should be 3 after 3 inserts");
    ASSERT(list.to_string() == "(1, 2, 3)", "to_string should be (1, 2, 3)");
    ASSERT(list.to_string_backward() == "(3, 2, 1)", "to_string_backward should be (3, 2, 1)");

    int removed = list.remove_from_front();
    ASSERT(removed == 1, "remove_from_front should return 1");
    ASSERT(list.to_string() == "(2, 3)", "after removing 1 list should be (2, 3)");

    // remove remaining
    list.remove_from_front();
    list.remove_from_front();
    ASSERT(list.empty(), "list should be empty after removing all");

    // removing from empty should throw
    bool threw = false;
    try {
        list.remove_from_front();
    } catch (const std::runtime_error&) {
        threw = true;
    }
    ASSERT(threw, "remove_from_front on empty should throw");

    std::cout << "ALL TESTS PASSED\n";
    return 0;
}
