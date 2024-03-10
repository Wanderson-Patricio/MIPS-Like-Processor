#include <stdio.h>
#include <stdlib.h>

void printMat4(int board[][4]){
    for(int i=0; i<4; i++){
        for(int j=0; j<4; j++){
            printf("%d\t", board[i][j]);
        }
        printf("\n");
    }
}

int main(){
    int a[4][4] = {{1,2,3,4},{5,6,7,8},{9,10,11,12},{13,14,15,16}};
    int b[4][4] = {{1,2,3,4},{5,6,7,8},{9,10,11,12},{13,14,15,16}};
    
    int prod[4][4];
    
    for(int i = 0; i<4; i++){
        for(int j = 0; j<4; j++){
            int sum = 0;
            for(int k=0; k<4; k++){
                sum += a[i][k] * b [k][j];
            }
            prod[i][j] = sum;
        }
    }
    
    printMat4(prod);
    
    return 0;
}
