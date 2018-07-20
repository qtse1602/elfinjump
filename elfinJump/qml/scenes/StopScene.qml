import QtQuick 2.0
import VPlay 2.0
import QtSensors 5.5
import "../"
import VPlayPlugins 1.0

//停止界面
SceneBase {
    id: stopScene
    width: 320
    height: 480

    property string bc: "../../assets/role/兔子/background/background1.png"
    property string bc2: "../../assets/role/圣诞/背景/snowbck_X.png"

    //添加背景图片
    Image {
        anchors.fill: parent.gameWindowAnchorItem
        source:roleScene.state==="rabbit"?bc:bc2
    }

    //退出或者选择菜单
    Column {
        anchors.centerIn: parent
        spacing: 20

        Image {
            id: resumeButton
            width: 150
            height: 50
            x: menuScene.width / 2 - 140
            y: menuScene.height / 2
            source: "../../assets/button/resume_X.png"
            MouseArea {
                id: resumeMouseArea
                anchors.fill: parent
                onClicked: {
                    gameWindow.state="game"
                }
            }
        }

        Image {
            id: menuButton
            width: 150
            height: 50
            x: menuScene.width / 2 - 140
            y: menuScene.height / 2 - 150
            source: "../../assets/button/menu_X.png"
            MouseArea {
                id: menuMouseArea
                anchors.fill: parent
                onClicked: {
                     gameScene.elfin.die()
                    roleScene.state="null"
                    gameWindow.state="menu"
                    gameScene.state = "start"

                }
            }
        }
    }
}
