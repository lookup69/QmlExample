#include "CppObject.hpp"

#include <unistd.h>

#include <QDebug>

CppObject::CppObject(QObject *parent)
        : QObject(parent)
{
        m_thread = QThread::create(&CppObject::Run, this);
        m_thread->start();
}

QString CppObject::GetTxt()
{
        qDebug() << __PRETTY_FUNCTION__;

        return m_txt;
}

void CppObject::SetTxt(const QString &txt)
{
        qDebug() << __PRETTY_FUNCTION__;

        m_txt = txt;
        emit txtChanged(m_txt);
}

QString CppObject::Echo(const QString &msg)
{
        qDebug() << __PRETTY_FUNCTION__ << "  >>>  " << msg;

        return QString{QString{__PRETTY_FUNCTION__} + QString{"return from CPP"}};
}

void CppObject::onRecvTxt(const QString &txt)
{
        qDebug() << __PRETTY_FUNCTION__ << " txt: " << txt;

        m_txt = txt;
        emit txtChanged(m_txt);
}

void CppObject::Run()
{
        while (1) {
                sleep(1);
                ++m_cnt;
                emit cntChanged(m_cnt);
                qDebug() << __PRETTY_FUNCTION__ << " cnt: " << m_cnt;
        }
}