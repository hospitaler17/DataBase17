#include "embdsql.h"
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <stdio.h>
#include <ctype.h>


int main (int argc, char ** argv) {
    char * pass;
    char choose[100];

    pass = getpass("Введите пароль: ");
    if (db_connect(pass)) {
        fprintf(stderr, "Ошибка подключения к базе данных!\n");
        return 1;
    }
    system("clear");
    while(choose[0] != '0') {
        Request req;
        printf("\nВыберите задание:\n");
        printf("   1.  Названия организаций, где работали доценты или служащие того же района;\n");
        printf("   2.  Фамилии и размер налога для тех работников, которые имели работу с почасовой оплатой менее 1500 руб. не ранее июня месяца 1999 года\n");
        printf("   3.  Название и размер отчислений для организаций, где работал Алексанов более одного раза\n");
        printf("   4.  Номер работы, название организации, где работали работники из Советского района. Добавить в вывод фамилии таких работников и отсортировать по названию организации.\n");
        printf("   0.  Выход\n\n");
        printf(">>> ");
        fgets(choose, 100, stdin);
        system("clear");
        switch (choose[0]) {
            case '1':
                task_a(&req);
                break;
            case '2':
                task_b(&req);
                break;
            case '3':
                task_c(&req);
                break;
            case '4':
                task_d(&req);
                break;
            case '0':
                system("clear");
                return 0;
            default:
                printf("Нет такого пункта меню!\n");

        }
    }
}
