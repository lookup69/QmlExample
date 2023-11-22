import QtQuick 2.15
import QtQuick.Layouts 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import CppObject 1.0

Window {
    id: root
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    // define custom signal
    signal sendTxt(string txt)

    ColumnLayout {
        id: columnLayout
        anchors.fill: parent

        RowLayout {
            id: rowLayout1
            anchors.left: parent.left
            anchors.right: parent.right

            Rectangle {
                id: rectangle1
                width: 200
                height: 200
                color: "#bcec71"
                Layout.fillWidth: true

                // define custom signal
                signal sendTxt(string txt)

                ColumnLayout {
                    id: columnLayout2
                    anchors.fill: parent
                    //spacing: 2

                    TextEdit {
                        id: textEdit
                        text: qsTr("Text Edit")
                        font.pixelSize: 12
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        layer.enabled: true
                    }

                    Button {
                        id: button1
                        text: qsTr("Send 1")
                        //anchors.left: parent.left
                        //anchors.right: parent.right
                        Layout.fillHeight: false
                        Layout.fillWidth: true

                        onClicked: {
                            // custom signal defined at root
                            root.sendTxt("[root signal] " + textEdit.text)
                        }
                    }

                    Button {
                        id: button2
                        text: qsTr("Send 2")
                        Layout.fillHeight: false
                        Layout.fillWidth: true

                        onClicked: {
                            // custom signal defined at rectangle1
                            rectangle1.sendTxt("[rectangle1 signal] " + textEdit.text)
                        }
                    }
                }
            }

            Rectangle {
                id: rectangle2
                width: 200
                height: 200
                color: "#e0f838"
                Layout.fillHeight: false
                Layout.fillWidth: true

                Text {
                    id: text1
                    text: qsTr("Text")
                    anchors.fill: parent
                    font.pixelSize: 12
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.bold: true
                }
            }
        }

        RowLayout {
            id: rowLayout2

            Rectangle {
                id: rectangle3
                color: "#88f2f0"
                Layout.fillHeight: true
                Layout.fillWidth: true

                Text {
                    id: text2
                    text: qsTr("")
                    anchors.fill: parent
                    font.pixelSize: 23
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.bold: true
                }
            }

            Button {
                id: button3
                text: qsTr("Send 2")
                Layout.fillHeight: true
                //Layout.fillWidth: true

                onClicked: {
                    /*
                        Q_INVOKABLE void Echo(const QString &msg);
                    */
                    // Call member function of CppObject
                    console.log(cppObject.Echo("Call from QML"))
                }
            }

        }
    }

    CppObject {
        id: cppObject

        /*
            signals:
                void txtChanged(const QString txt);
                void cntChanged(int m_cnt);
        */

        // will receive the signal emitted by CppObject(cpp)
        // (CppObject) emit txtChanged(string) ---> main.qml
        onTxtChanged: msg => {
                          text1.text = msg
                      }

        // will receive the signal emitted by CppObject(cpp)
        // (CppObject) emit cntChanged(int) ---> main.qml
        onCntChanged: cnt => {
                          text2.text = cnt
                      }
    }

    Component.onCompleted: {
        /*
            public slots:
                void onRecvTxt(const QString &txt);
        */
        // connect to CPP slot
        root.onSendTxt.connect(cppObject.onRecvTxt)
        rectangle1.onSendTxt.connect(cppObject.onRecvTxt)

        /*
            Q_PROPERTY(QString m_txt READ GetTxt WRITE SetTxt NOTIFY txtChanged)
        */
        // will call GetText() defined as a property
        console.log(cppObject.m_txt)

        // will call SetText() defined as a property
        cppObject.m_txt = "Hello"
    }
}
