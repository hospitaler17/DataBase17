#include "embdsql.h"
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <stdio.h>
#include <ctype.h>


int main (int argc, char ** argv) {
    char * pass;
    // char * add;
    char choose;

    pass = getpass("Введите пароль: ");
    if (db_connect(pass)) {
        fprintf(stderr, "Ошибка подключения к базе данных!\a\n");
        return 1;
    }
    system("clear");
    while(choose != '0') {
        Request req;
        printf("\nВыберите задание:\n");
        printf("   1.  Названия организаций, где работали -1[доценты] или служащие того же района\n");
        printf("   2.  Фамилии и размер налога для тех работников, которые имели работу с почасовой оплатой менее -1[1500] руб. не ранее -2[июня месяца] -3[1999 года]\n");
        printf("   3.  Название и размер отчислений для организаций, где работал -1[Алексанов] более -2[одного] раза\n");
        printf("   4.  Номер работы, название организации, где работали работники из -1[Советского] района. Добавить в вывод фамилии таких работников и отсортировать по названию организации.\n");
        printf("   0.  Выход\n\n");
        printf(">>> ");
        scanf("%s", &choose);
        system("clear");
		printf("\n(!)Все параметры вводятся с заглавной буквы в им.п. м.р или цифрами(!)\n");
        switch (choose) {
            case '1':
                printf("1.  Названия организаций, где работали -1[доценты] или служащие того же района\n\n");
				printf("-1. Должность: ");
                scanf("%s", req.text1);
                task_a(&req);
                break;
            case '2':
                printf("2.  Фамилии и размер налога для тех работников, которые имели работу с почасовой оплатой менее -1[1500] руб. не ранее -2[июня месяца] -3[1999 года]\n\n");
                printf("-1. Почасовая оплата(руб.): ");
                scanf("%d", &req.numb);

                printf("-2. Месяц(1-12): ");
                scanf("%s", req.text1);

                printf("-3. Год: ");
                scanf("%s", req.text2);

                task_b(&req);
                break;
            case '3':
                printf("3.  Название и размер отчислений для организаций, где работал -1[Алексанов] более -2[одного] раза\n\n");
                printf("-1. Фамилия сотрудника: ");
                scanf("%s", req.text1);
                printf("-2. Больше какого значения: ");
                scanf("%d", &req.numb);
                task_c(&req);
                break;
            case '4':
                printf("4.  Номер работы, название организации, где работали работники из -1[Советского] района. Добавить в вывод фамилии таких работников и отсортировать по [названию организации]\n\n");
                printf("-1. Район: ");
                scanf("%s", req.text1);
                req.numb = 0;
                while (req.numb < 1 || req.numb > 3) {
                    printf("-2. Сортировка по:\n1) # работы\n2) Назварию организации\n3) Фамилия работников\n>>> ");
                    scanf("%d", &req.numb);
                }
                if (req.numb == 1) {
                    strcpy(req.text2, "Work.ID");
                    printf("%s\n", req.text2);
                }
                if (req.numb == 2) {
                    strcpy(req.text2, "Work_place.name");
                }
                if (req.numb == 3) {
                    strcpy(req.text2, "Employee.surname");
                }
                task_d(&req);
                break;
            default:
                printf("Нет такого пункта меню!\n");

        }
    }
    system("clear");
    return 0;
}
