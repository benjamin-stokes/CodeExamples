#include <stdio.h>
#include <string.h>


int main(int argc, const char * argv[]) {
    FILE *file = fopen(argv[1], "r");
    int Stack[1024];
    char *token, *linetmp;
    char line[1024];
    int i, imax;
    while (fgets(line, 1024, file)) {
        if(strlen(line) <= 1) continue;
        linetmp = strdup (line);
	i = 0;
        while (token = strsep(&linetmp, " ")){
	  sscanf(token, "%i", &Stack[i]);
	  i++;
	}
	imax=i-1;
	printf("%d", Stack[imax]);
	for (i = imax-2; i >= 0; i -= 2) printf(" %d", Stack[i]);
	printf("\n");
    }
}
