#include <stdio.h>
#include <stdlib.h>
#include <time.h>

typedef struct Node {
    int data;
    struct Node *left, *right;
} Node;

// Insert a value into the BST
Node* insert(Node* root, int data) {
    if (root == NULL) {
        Node* node = (Node*)malloc(sizeof(Node));
        node->data = data;
        node->left = node->right = NULL;
        return node;
    }
    if (data < root->data)
        root->left = insert(root->left, data);
    else
        root->right = insert(root->right, data);
    return root;
}

// In-order traversal to store sorted elements
void inorder(Node* root, int* arr, int* idx) {
    if (root == NULL) return;
    inorder(root->left, arr, idx);
    arr[(*idx)++] = root->data;
    inorder(root->right, arr, idx);
}

// Free the BST
void freeTree(Node* root) {
    if (root == NULL) return;
    freeTree(root->left);
    freeTree(root->right);
    free(root);
}

// Tree sort function
void treeSort(int* arr, int n) {
    Node* root = NULL;
    for (int i = 0; i < n; ++i)
        root = insert(root, arr[i]);
    int idx = 0;
    inorder(root, arr, &idx);
    freeTree(root);
}

// Test with 1 million elements
int main() {
    const int N = 1000000;
    int* arr = (int*)malloc(N * sizeof(int));
    if (!arr) {
        printf("Memory allocation failed\n");
        return 1;
    }

    srand((unsigned)time(NULL));
    for (int i = 0; i < N; ++i)
        arr[i] = rand();

    clock_t start = clock();
    treeSort(arr, N);
    clock_t end = clock();

    // Verify sorted
    int sorted = 1;
    for (int i = 1; i < N; ++i) {
        if (arr[i-1] > arr[i]) {
            sorted = 0;
            break;
        }
    }
    printf("Sorted: %s\n", sorted ? "Yes" : "No");
    printf("Time taken: %.2f seconds\n", (double)(end - start) / CLOCKS_PER_SEC);

    free(arr);
    return 0;
}
