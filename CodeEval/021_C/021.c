#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, const char * argv[]) {
    FILE *file = fopen(argv[1], "r");
    char line[1024];
    int i, sum;
    while (fgets(line, 1024, file)) {
        sum = 0;
        for (i=0; i < (int)strlen(line)-1; i++) sum += line[i] -'0';
        if (sum > 0) printf("%d\n", sum);
    }
    return 0;
}
