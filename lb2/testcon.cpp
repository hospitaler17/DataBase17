#include <iostream>
#include </usr/include/mysql++>

using namespace mysqlpp;
using namespace std;
//создаем экзмемпляры необходимых объектов
Connection conn;
StoreQueryResult queryres; // привет
string querysring;

int main(int argc, char const *argv[]) {
	char *pass;
	pass = getpass ( "Введите пароль: ");
	try
	{
		conn.connect("Lb2", "95.79.35.162", "root", "Ibanez89047996350"); //пробуем подключиться к базе
	}
	catch (ConnectionFailed err) //перехватываем возможное исключение типа ConnectionFailed
		{
			std::cerr <<  "Не удалось подключится к базе данных, причина: " << err.what() << endl;
			return 1;
		}
	if(conn.connected()) //проверяем, подключены ли мы к базе данных
	{
		querystring = "SELECT * FROM Lb2"; //инициализируем строку запроса
		queryres = conn.query(querystring.c_str()).store(); //выполняем запрос
		if(!res.empty()) //если что-то вернулось
		{
			for(int rc = 0; rc < (int)queryres.num_rows(); ++i) //построчно выводим на экран
				cout << queryres[rc]["colname_one"] << queryres[rc]["colname_sec"] << endl;
		} else
			std::cerr  << "Запрос не вернул данных" << endl; //иначе сообщаем что ничего не вернулось
	 	conn.disconnect(); //отключаемся от базы данных
	} else
	{
		cout << "Подключение к базе данных потеряно..." << endl; //иначе сообщаем что коннект отвалился
		return 1;
	}
}
