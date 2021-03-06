#include <string.h>
#include <stdio.h>
#include "embdsql.h"



#define MAX_QUERY_LEN 2048
#define SQLCHECK if(sqlca.sqlcode) { \
    printf("SQLERROR (at line %d): '%s' '%.5s' %ld\n", __LINE__, sqlca.sqlerrm.sqlerrmc, sqlca.sqlstate, sqlca.sqlcode);\
    return 1;\
    }

EXEC SQL BEGIN DECLARE SECTION;
    char * password;
    struct SQL_req {
        int  numb;
        char text1[LEN];
        char text2[LEN];
    };
EXEC SQL END DECLARE SECTION;


int db_connect(char * pass) {
    password = pass;
    EXEC SQL CONNECT TO db1@localhost USER postgres USING :password;
    SQLCHECK;
    EXEC SQL COMMIT;
    return 0;
}







/////////////////////////////1 запрос/////////////////////////////////////////////////////////
int task_a (const Request * req) {
    EXEC SQL BEGIN DECLARE SECTION;
        char query [MAX_QUERY_LEN + 1] = { 0 };
        struct SQL_req sql_req;
    EXEC SQL END DECLARE SECTION;
    printf("\n");
    snprintf (query, MAX_QUERY_LEN, "SELECT DISTINCT Work_place.name FROM Work, Work_place, Position WHERE Work_place.ID = Work.work_place AND Position.ID = Work.position AND Position.name = \'%s\'", req->text1);
    EXEC SQL PREPARE query FROM :query;
    EXEC SQL DECLARE task_a CURSOR FOR query;
    SQLCHECK;
    EXEC SQL OPEN task_a;
    SQLCHECK;
    int i = 0;
    while(1) {
        EXEC SQL FETCH task_a INTO :sql_req.text1;
        if(sqlca.sqlcode) {
            if(i==0)
                printf("Ничего не найдено!\n");
            break;
        }
        printf("[ %s\t]\n",sql_req.text1);
        i++;
    }
    EXEC SQL CLOSE task_a;
    SQLCHECK;
    EXEC SQL COMMIT;
    return 0;
}


//////////////////////////////////2 запрос///////////////////////////////////////////
int task_b (const Request * req) {
    EXEC SQL BEGIN DECLARE SECTION;
        char query [MAX_QUERY_LEN + 1] = { 0 };
        struct SQL_req sql_req;
    EXEC SQL END DECLARE SECTION;
    printf("\n");
    snprintf (query, MAX_QUERY_LEN, "SELECT Employee.surname, Employee.tax FROM Work, Employee, Position WHERE Employee.ID = Work.employee AND Position.ID = Work.position AND Position.payment < %d AND Work.date >= '%s-%s-01'", req->numb, req->text2, req->text1);
    EXEC SQL PREPARE query FROM :query;
    EXEC SQL DECLARE task_b CURSOR FOR query;
    SQLCHECK;
    EXEC SQL OPEN task_b;
    SQLCHECK;
    int i = 0;
    while(1) {
        EXEC SQL FETCH task_b INTO :sql_req.text1, :sql_req.numb ;
        if(sqlca.sqlcode) {
            if(i==0)
                printf("Ничего не найдено!\n");
            break;
        }
        printf("[ %s\t| %3d\t]\n", sql_req.text1, sql_req.numb);
        i++;
    }
    EXEC SQL CLOSE task_b;
    SQLCHECK;
    EXEC SQL COMMIT;
    return 0;
}


/////////////////////////////3 запрос/////////////////////////////////////
int task_c (const Request * req) {
    EXEC SQL BEGIN DECLARE SECTION;
        char query [MAX_QUERY_LEN + 1] = { 0 };
        struct SQL_req sql_req;
    EXEC SQL END DECLARE SECTION;

    printf("\n");
    snprintf (query, MAX_QUERY_LEN, "SELECT DISTINCT Work_place.name, Work_place.pension FROM Work_place, Employee, Work WHERE Work.work_place = Work_place.ID AND Work.employee = Employee.ID AND Employee.surname = 'Алексанов' AND Employee.ID IN (SELECT DISTINCT Work.employee FROM Work GROUP BY  Work.employee, Work.work_place HAVING COUNT(*) > 1)");
    EXEC SQL PREPARE query FROM :query;
    EXEC SQL DECLARE task_c CURSOR FOR query;
    SQLCHECK;
    EXEC SQL OPEN task_c;
    SQLCHECK;
    int i = 0;
    while(1) {
        EXEC SQL FETCH task_c INTO :sql_req.text1;
        if(sqlca.sqlcode) {
            if(i==0)
                printf("Ничего не найдено!\n");
            break;

        }
        printf("[ %s\t]\n",sql_req.text1);
        i++;
    }
    EXEC SQL CLOSE task_c;
    SQLCHECK;
    EXEC SQL COMMIT;
    return 0;
}


////////////////////////////////////////4 запрос////////////////////////////////////////
int task_d (const Request * req) {
    EXEC SQL BEGIN DECLARE SECTION;
        char query [MAX_QUERY_LEN + 1] = { 0 };
        struct SQL_req sql_req;
    EXEC SQL END DECLARE SECTION;
    printf("\n");
    snprintf (query, MAX_QUERY_LEN, "SELECT Work.ID, Work_place.name, Employee.surname FROM Work_place, Employee, Work WHERE Employee.ID = Work.employee AND Work_place.ID = Work.work_place AND Employee.address = '%s' ORDER BY %s", req->text1, req->text2);
    EXEC SQL PREPARE query FROM :query;
    EXEC SQL DECLARE task_d CURSOR FOR query;
    SQLCHECK;
    EXEC SQL OPEN task_d;
    SQLCHECK;
    int i = 0;
    while(1) {
        EXEC SQL FETCH task_d INTO :sql_req.numb, :sql_req.text1, :sql_req.text2;
        if(sqlca.sqlcode) {
            if(i==0)
                printf("Ничего не найдено!\n");
            break;
        }
        printf("[ %d\t| %s\t| %s\t]\n",  sql_req.numb, sql_req.text1, sql_req.text2);
        i++;
    }
    EXEC SQL CLOSE task_d;
    SQLCHECK;
    EXEC SQL COMMIT;
    return 0;
}
