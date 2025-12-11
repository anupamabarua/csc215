#include <stdio.h>

int main(int argc, char *argv[]) {
    FILE *fp;
    char line[1024];
    int i, len;
    

    if (argc != 2) {
        fprintf(stderr, "Usage: %s <filename>\n", argv[0]);
        return 1;
    }
    

    fp = fopen(argv[1], "r");
    if (fp == NULL) {
        fprintf(stderr, "Error: Cannot open file '%s'\n", argv[1]);
        return 1;
    }
    

    while (fgets(line, sizeof(line), fp) != NULL) {

        len = 0;
        for (i = 0; line[i] != '\0'; i++) {
            len++;
        }
        
        // Remove 
        if (len > 0 && line[len - 1] == '\n') {
            len--;
            line[len] = '\0';
        }
        
        // Print 
        printf("%d: %s\n", len, line);
    }
    

    fclose(fp);
    
    return 0;
}