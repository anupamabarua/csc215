#include "LinkedList.h"

// 17.2 traversal render
std::string render_list(Node* list) {
    Node* node = list;
    std::string s = "";

    while (node != nullptr) {
        s += node->to_str();
        node = node->next;
        if (node != nullptr) s += ", ";
    }
    return s;
}

// 17.3 recursion worker (internal helper)
static std::string render_backward_worker(Node* list) {
    if (list == nullptr) return "";

    // split into head and tail (17.5)
    Node* head = list;
    Node* tail = list->next;

    std::string s = render_backward_worker(tail);
    if (head->next != nullptr && s != "") s += ", ";
    s += head->to_str();
    return s;
}

// 17.7 wrapper
std::string render_list_backward(Node* list) {
    return render_backward_worker(list);
}

// ----- LinkedList methods -----

LinkedList::~LinkedList() {
    clear();
}

void LinkedList::clear() {
    while (head != nullptr) {
        Node* front = head;
        head = head->next;
        delete front;
    }
    num_nodes = 0;
}

void LinkedList::insert_at_front(int cargo) {
    Node* front = new Node(cargo, head);
    head = front;
    num_nodes++;
}

int LinkedList::remove_from_front() {
    if (head == nullptr) {
        throw std::runtime_error("Can't remove from empty list!");
    }

    int cargo = head->cargo;
    Node* front = head;
    head = head->next;
    delete front;
    num_nodes--;
    return cargo;
}

std::string LinkedList::to_string() const {
    return "(" + render_list(head) + ")";
}

std::string LinkedList::to_string_backward() const {
    return "(" + render_list_backward(head) + ")";
}
