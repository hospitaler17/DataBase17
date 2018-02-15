#ifndef EMBDSQL_H
#define EMBDSQL_H

#define LEN 100

typedef struct Request {
    int  numb;
    char text[LEN];
} Request;
int  db_connect (char * pass);
int  task_a (const Request * req);
int  task_b (const Request * req);
int  task_c (const Request * req);
int  task_d (const Request * req);
#endif // EMBDSQL_H
