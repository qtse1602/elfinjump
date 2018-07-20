import QtQuick 2.0
import VPlay 2.0
import QtSensors 5.5
import "../"
import "./"
import VPlayPlugins 1.0

//再来一次界面
SceneBase {
    id: againScene
    width: 320
    height: 480

    property string bc: "../../assets/role/兔子/background/background1.png"

    property string bc2: "../../assets/role/圣诞/背景/snowbck_X.png"
//选择切换场景
    Image {              //添加背景图片
        anchors.fill: parent.gameWindowAnchorItem
        source: roleScene.state==="rabbit"?bc:bc2
    }

    //游戏界面显示得分
    Text{
        id: total
        color: "black"
        x:100
        y:100
        font.pixelSize: 26
        text:"总分："+(gameScene.score)
    }

    //选择再来一次界面或者菜单
    Column{
        x: 70
        y: 200

        Image {
            id: playagainButton
            width: 150
            height: 50
            x: menuScene.width / 2 - 140
            y: menuScene.height / 2
            source: "../../assets/button/playagain_X.png"
            MouseArea {
                id: playagainMouseArea
                anchors.fill: parent
                onClicked: {
                    gameScene.score=0
                    gameWindow.state="role"
                    roleScene.state="null"
                }
            }
        }

        Image {
            id: menuSceneButton
            width: 150
            height: 50
            x: menuScene.width / 2 - 140
            y: menuScene.height / 2 - 150
            source: "../../assets/button/menu_X.png"
            MouseArea {
                id: scoreSceneMouseArea
                anchors.fill: parent
                onClicked: {
                    roleScene.state="null"
                    gameScene.score=0
                    gameWindow.state="menu"
                }
            }
        }
    }

}
