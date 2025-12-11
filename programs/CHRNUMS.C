#include <stdio.h>

int main(int argc, char *argv[]) {
    FILE *fp;
    char line[1024];
    int i, len;
    
    // Check if filename argument is provided
    if (argc != 2) {
        fprintf(stderr, "Usage: %s <filename>\n", argv[0]);
        return 1;
    }
    
    // Open the file
    fp = fopen(argv[1], "r");
    if (fp == NULL) {
        fprintf(stderr, "Error: Cannot open file '%s'\n", argv[1]);
        return 1;
    }
    
    // Read and process each line
    while (fgets(line, sizeof(line), fp) != NULL) {
        // Count characters manually (excluding newline)
        len = 0;
        for (i = 0; line[i] != '\0' && line[i] != '\n'; i++) {
            len++;
        }
        
        // Replace newline with null terminator if present
        if (line[i] == '\n') {
            line[i] = '\0';
        }
        
        // Print line with character count
        printf("%d: %s\n", len, line);
    }
    
    // Close the file
    fclose(fp);
    
    return 0;
}