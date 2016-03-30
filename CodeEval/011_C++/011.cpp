#include <iostream>
#include <string>
#include <fstream>
#include <sstream>

using namespace std;

int main(int argc, char *argv[]) {
    int i, j, bintree[4][2] = {0,30,8,52,3,20,10,29};
    ifstream stream(argv[1]);
    string line;
    while (getline(stream, line)) {
        istringstream is( line );
        int x, y;
        is >> x >> y;
        bool doneflag=false;
        for (i = 0; i < 4; i++){
            for (j = 0; j < 2; j++)
                if ((bintree[i][j] >= x && bintree[i][j] <= y)||
                    (bintree[i][j] <= x && bintree[i][j] >= y)){
                    cout << bintree[i][j] << endl;
                    doneflag = true;
                }
            if (doneflag) break;
        }
    }
}
