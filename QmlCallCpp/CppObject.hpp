#pragma once

#include <QObject>
#include <QString>
#include <QThread>

class CppObject : public QObject
{
        Q_OBJECT

        Q_PROPERTY(QString m_txt READ GetTxt WRITE SetTxt NOTIFY txtChanged)

public:
        explicit CppObject(QObject *parent = 0);

        QString GetTxt();
        void    SetTxt(const QString &txt);


        Q_INVOKABLE void Echo(const QString &msg);
signals:
        void txtChanged(const QString txt);
        void cntChanged(int m_cnt);

public slots:
        void onRecvTxt(const QString &txt);

private:
        void Run();

private:
        QString m_txt = "cpp object default string";
        int     m_cnt = 0;
        QThread *m_thread = nullptr;
};
