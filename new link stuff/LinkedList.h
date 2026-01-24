#ifndef LINKEDLIST_H
#define LINKEDLIST_H

#include <string>
#include <stdexcept>

// 17.1 Nodes
struct Node {
    int cargo;
    Node* next;

    Node() : cargo(0), next(nullptr) {}
    Node(int cargo) : cargo(cargo), next(nullptr) {}
    Node(int cargo, Node* next) : cargo(cargo), next(next) {}

    std::string to_str() const {
        return std::to_string(cargo);
    }
};

// 17.2 Lists as collections (free-standing functions)
std::string render_list(Node* list);
std::string render_list_backward(Node* list);

// 17.9 The LinkedList class (wrapper)
class LinkedList {
    int num_nodes;
    Node* head;

public:
    LinkedList() : num_nodes(0), head(nullptr) {}
    ~LinkedList();

    // modifiers
    void insert_at_front(int cargo);
    int remove_from_front();  // throws if empty

    // accessors
    int size() const { return num_nodes; }
    bool empty() const { return head == nullptr; }

    // rendering helpers (pretty format)
    std::string to_string() const;
    std::string to_string_backward() const;

private:
    void clear();
};

#endif
