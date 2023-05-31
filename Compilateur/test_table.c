#include <stdio.h>
#include "table_symboles.h"

int main() {
    add_symbol("a", 0); 
    add_symbol("b", 1); 
    add_symbol("c", 0); 

    init_symbol("a"); 

    printf("L'indice du symbole est : %d\n", index_symbol("b")); 

    print_symbol_table(); 

    return 0; 
}