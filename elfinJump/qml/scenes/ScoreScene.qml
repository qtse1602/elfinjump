import QtQuick 2.0
import VPlay 2.0
import QtSensors 5.5
import "../"
import VPlayPlugins 1.0
import grade 1.0


//历史得分界面
SceneBase {
    id: scoreScene

    Image {
        anchors.fill: scoreScene.gameWindowAnchorItem
        source: "../../assets/background.png"
    }

    Column {
        spacing: 20

        Text {
            id: scoretext
            text: qsTr("历史得分：")
            font.pointSize: 20
        }

        Text {
            id: grade
        }

        //从数据库中读取数据
        SimpleButton {
            text: "Press to read the last grade"
            onClicked: {
                grade.text = gameScene.elfin.mydb.selectdb()
            }
        }

        Image {
            id: returnButton
            x: 228
            y: 400
            source: "../../assets/button/return.png"
            width: 100
            height: 50
            MouseArea {
                id: returnMouseArea
                anchors.fill: parent
                onClicked: gameWindow.state = "menu"
            }
        }
    }
}
