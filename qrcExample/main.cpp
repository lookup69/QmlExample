#include <QGuiApplication>
#include <QQuickView>


int main(int argc, char *argv[])
{
	QGuiApplication app(argc, argv);

	QQuickView view;
	
	view.setSource(QUrl("qrc:/main.qml"));
	view.show();

	app.exec();
	return 0;
}
