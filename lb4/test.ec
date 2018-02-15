int  db_get_count(int * count);

int db_get_count (int * count) {
    EXEC SQL BEGIN DECLARE SECTION;
        int sql_count[4];
    EXEC SQL END DECLARE SECTION;
    EXEC SQL SELECT COUNT(*) INTO :sql_count[0] FROM Work;
    SQLCHECK;
    EXEC SQL SELECT COUNT(*) INTO :sql_count[1] FROM Work_place;
    SQLCHECK;
    EXEC SQL SELECT COUNT(*) INTO :sql_count[2] FROM Employee;
    SQLCHECK;
    EXEC SQL SELECT COUNT(*) INTO :sql_count[3] FROM Position;
    SQLCHECK;
    if(count != NULL) {
        count[0] = sql_count[0];
        count[1] = sql_count[1];
        count[2] = sql_count[2];
        count[3] = sql_count[3];
    }
    EXEC SQL COMMIT;
    return 0;
}



    int count[4];
    status = db_get_count(count);
    printf("Кол-во проведенныйх работ: %d\n", count[0]);
    printf("Кол-во мест работы       : %d\n", count[1]);
    printf("Кол-во работников        : %d\n", count[2]);
    printf("Кол-во должностей        : %d\n", count[3]);
