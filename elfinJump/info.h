#ifndef INFO_H
#define INFO_H

#include <QObject>
#include "mydb.h"

//设置成绩信息
class Info : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int grade READ grade WRITE setGrade NOTIFY gradeChanged)
public:
    explicit Info(QObject *parent = 0):QObject(parent){}
public slots:
    void setGrade(const int a) {
        m_grade = a;
        emit gradeChanged();
    }
    int grade() const {
        return m_grade;
    }
signals:
    void gradeChanged();
private:
    int m_grade;
};


#endif // INFO_H
