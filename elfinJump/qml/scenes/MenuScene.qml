import VPlay 2.0
import QtQuick 2.0
import "../"
import VPlayPlugins 1.0

//菜单界面
SceneBase {
    id: menuScene
    Image {
        anchors.fill: menuScene.gameWindowAnchorItem
        source: "../../assets/role/兔子/background/background1.png" //背景
    }

    Column {
        anchors.centerIn: parent
        spacing: 20

        //开始游戏，选择角色场景
        Image {
            id: gameSceneButton
            width: 150
            height: 50
            x: menuScene.width / 2 - 140
            y: menuScene.height / 2
            source: "../../assets/button/playButton.png"
            MouseArea {
                id: gameSceneMouseArea
                anchors.fill: parent
                onClicked: {
                    roleScene.state="null"
                    gameWindow.state="role"
                }
            }
        }

        //历史得分
        Image {
            id: scoreSceneButton
            width: 150
            height: 50
            x: menuScene.width / 2 - 140
            y: menuScene.height / 2 - 150
            source: "../../assets/button/scoreButton.png"
            MouseArea {
                id: scoreSceneMouseArea
                anchors.fill: parent
                onClicked:  gameWindow.state="score"
            }
        }

        //退出游戏
        Image {
            id: quitButton
            width: 150
            height: 50
            x: menuScene.width / 2 - 140
            y: menuScene.height / 2 - 350
            source: "../../assets/button/quit.png"
            MouseArea {
                id: quitMouseArea
                anchors.fill: parent
                onClicked: Qt.quit()
            }
        }
    }

    //音乐设置
    MultiResolutionImage {
        id: musicButton
        y: 370
        source: "../../assets/music/music.png"
        opacity: settings.musicEnabled ? 0.9 : 0.4

        anchors.top: header.bottom
        anchors.topMargin: 30
        anchors.left: parent.left
        anchors.leftMargin: 30

        MouseArea {
            anchors.fill: parent

            onClicked: {
                if (settings.musicEnabled)
                    settings.musicEnabled = false
                else
                    settings.musicEnabled = true
            }
        }
    }

    MultiResolutionImage {
        id: soundButton
        y: 370
        source: settings.soundEnabled ? "../../assets/music/sound.png" : "../../assets/music/sound_off2.png"
        opacity: settings.soundEnabled ? 0.9 : 0.4

        anchors.top: header.bottom//算出现的边界，定位
        anchors.topMargin: 30
        anchors.left: parent.left
        anchors.leftMargin: 80

        MouseArea {
            anchors.fill: parent

            onClicked: {
                if (settings.soundEnabled) {
                    settings.soundEnabled = false
                } else {
                    settings.soundEnabled = true
                    audioManager.playSound("playerJump")
                }
            }
        }
    }
}

