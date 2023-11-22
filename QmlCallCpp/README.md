1. How to make
   1. /lib/qt6/bin/qmake
   2. make
2. Cpp class should inherit from QObject
   1. class CppObject : public QObject
3. If qml want to access the data member directly, should define with the property
   1. Q_PROPERTY(QString m_txt READ GetTxt WRITE SetTxt NOTIFY txtChanged)
      1. cppObject.m_txt = "Hello"
4. If the member function will call by qml should define by Q_INVOKABLE
   1. Q_INVOKABLE void Echo(const QString &msg);
5. The signal emitted by CPP should add slot in qml
   1. cpp
      1. signals:
          void txtChanged(const QString txt);
   2. qml
      1. CppObject {
                onTxtChanged: msg => {
                          text1.text = msg
                }
                ...
6. Use connect() to hook cpp slot with qml signal
   1. cpp
      1. public slots:
        void onRecvTxt(const QString &txt);
   2. qml
      1. Window {
                id: root
                signal sendTxt(string txt)
                ...

         Rectangle {
                id: rectangle1
                signal sendTxt(string txt)
                ...

      2. Component.onCompleted: {
             root.onSendTxt.connect(cppObject.onRecvTxt)
             rectangle1.onSendTxt.connect(cppObject.onRecvTxt)

Reference:
https://www.cnblogs.com/linuxAndMcu/p/11961090.html
https://blog.csdn.net/qq_34139994/article/details/105195328
