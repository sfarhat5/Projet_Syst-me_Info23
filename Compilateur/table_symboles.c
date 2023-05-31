#include <string.h> 
#include <stdio.h>
#include "table_symboles.h"



int indice=0;

void add_symbol(char* nomS, int initS) {
    // Vérification de la présence du symbole dans le tableau
    for (int i = 0; i < indice; i++) {
        if (strcmp(sTable[i].nom, nomS) == 0) {
            printf("Le symbole %s est déjà présent dans la table des symboles.\n", nomS);
            return;
        }
    }
    
    if (strlen(nomS) > 16) {
        printf("Taille du nom non supportée par le langage.\n");
    } else {
        strcpy(sTable[indice].nom, nomS);
        sTable[indice].init = initS;
        indice++;
    }
}

int index_symbol(char* nomS){
    int i = 0;
    for(i=0;i<indice; i++){
        if(strcmp(sTable[i].nom, nomS)==0){
            return i;
        }
    }
    return -1;
}

int is_init(char* nomS){
    return sTable[index_symbol(nomS)].init;
}

void init_symbol(char* nomS){
    sTable[index_symbol(nomS)].init=1;
}

void print_symbol_table(){
    printf("--------Symbol Table----------\n"); 
    printf("| %-16s | %-5s | \n", "Symbol", "Initialisé"); 
    printf("------------------------------\n"); 

    for (int i =0; i < indice; i++){
        printf("| %-16s | %-9s | \n", sTable[i].nom, sTable[i].init ? "Oui" : "Non" ); 
        
    }
    printf("Indice %d\n", indice);
    printf("-------------------------------\n"); 
}



