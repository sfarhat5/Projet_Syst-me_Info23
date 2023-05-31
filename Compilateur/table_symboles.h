typedef struct symbol{
    char nom[16];
    int init;
} symbol;

symbol sTable[128];

//Ajoute un symbole à la table des symboles
void add_symbol(char*, int);

//Retourne l'index d'un symbole donné
int index_symbol(char*);

//Retourne si un symbole est initialisé
int is_init(char*);

//Initialise un symbole
void init_symbol(char* nomS);

void print_symbol_table(); 
