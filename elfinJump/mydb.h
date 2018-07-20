#ifndef _MYDB_H
#define _MYDB_H
//创建数据库
#include <QString>
#include <QSqlDatabase>
#include <QMessageBox>
#include <QSqlError>
#include <QDebug>
#include <QSqlQuery>
#include <QObject>
#include <iostream>

class MyDB : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString databaseName READ databaseName WRITE setDatabaseName NOTIFY databaseNameChanged)
    Q_PROPERTY(QString sql READ sql WRITE setSql NOTIFY sqlChanged)


public:
    MyDB(QObject *parent = 0);

    Q_INVOKABLE bool exeSQL(QString sql);
    Q_INVOKABLE QString selectdb();
    void connect();

    QString databaseName() const;
    QString sql() const;

    void setDatabaseName(const QString &databaseName);
    void setSql(const QString &sql);

    bool getFlag() const;
    void setFlag(bool value);

signals:
    void databaseNameChanged();
    void sqlChanged();


private:
    QString m_databaseName;
    QString m_sql;
    QSqlDatabase m_db;

};


#endif


