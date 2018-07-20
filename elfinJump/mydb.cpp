#include "mydb.h"
#include <iostream>
using namespace std;

void MyDB::connect()
{
    m_db = QSqlDatabase::addDatabase("QMYSQL");
    m_db.setHostName("");
    m_db.setUserName("");
    m_db.setPassword("");
    m_db.setDatabaseName("doodlescore");
    if (!m_db.open()) {
        QMessageBox::critical(0, QObject::tr("Database Error"),
                              m_db.lastError().text());
        exit(1);
    }
    cout << "connect database success" << endl;
}

MyDB::MyDB(QObject *parent) : QObject (parent)
{
    connect();
}

bool MyDB::exeSQL(QString sql)    //执行sql语句
{
    QSqlQuery query(m_db);
    query.exec(sql);
    return true;
}

QString MyDB::databaseName() const
{
    return m_databaseName;
}

void MyDB::setDatabaseName(const QString &databaseName)
{
    m_databaseName = databaseName;
    emit databaseNameChanged();
}

QString MyDB::sql() const
{
    return m_sql;
}

void MyDB::setSql(const QString &sql)
{
    m_sql = sql;
    emit sqlChanged();
}

//与qml端相连接，显示成绩
QString MyDB::selectdb()
{
    QSqlQuery query;
    QString s;
    query.exec("select *from grade");
    while (query.next()) {
       s= query.value(0).toString();
    }
    return s;
}


