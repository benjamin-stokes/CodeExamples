#include <algorithm>
#include <iostream>
#include <fstream>

using namespace std;

int main(int argc, char *argv[]) {
  ifstream stream(argv[1]);
  string line;
  while (getline(stream, line)) {
    sort(line.begin(), line.end());
    printf("%s", line.c_str());
    while ( next_permutation(line.begin(), line.end()))
      printf(",%s", line.c_str());
    printf("\n");
  }
  return 0;
} 
