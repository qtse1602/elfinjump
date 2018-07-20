import QtQuick 2.0
import VPlay 2.0
import QtSensors 5.5
import "../"
import VPlayPlugins 1.0
SceneBase {
    id: roleScene
    width: 320
    height: 480
    state: "null"

    property string bc: "../../assets/role/兔子/background/background.png"
    property string bc1:"../../assets/background.png"
    property string bc2: "../../assets/role/圣诞/背景/snowbck_X.png"

    //添加背景图片
    Image {
        id:role
        anchors.fill: parent.gameWindowAnchorItem
    }

    Image {
        id: rabbit
        width: 80
        height: 80
        x:50
        y:50
        source: "../../assets/role/兔子/spring_tou.png"
        MouseArea {
            id: rabbitMouseArea
            anchors.fill: parent
            onClicked: {
                roleScene.state="rabbit"

            }

            //图像渐变效果
            SequentialAnimation {
                id:rabbitAnimation
                running: false
                loops: -1
                NumberAnimation { target:rabbit; property: "opacity"; to: 0.3; duration: 1000 }
                NumberAnimation { target:rabbit; property: "opacity"; to: 1; duration: 1000 }
            }
        }
    }

    //设置界面等
    Image {
        id: dialogBox
        visible: false
        source: "../../assets/button/对话框.PNG"
    }

    Image {
        id: snow
        width: 80
        height: 80
        x:50
        y:250
        source: "../../assets/role/圣诞/头像.jpg"
        MouseArea {
            id: snowMouseArea
            anchors.fill: parent
            onClicked: {
                roleScene.state="snow"

            }
            SequentialAnimation {
                id:snowAnimation
                running: false
                loops: -1
                NumberAnimation { target:snow; property: "opacity"; to: 0.3; duration: 1000 }
                NumberAnimation { target:snow; property: "opacity"; to: 1; duration: 1000 }
            }
        }
    }

    Image {
        id: okButton
        source: "../../assets/button/ok_on_X.png"
        x:10
        y:400
        width: 100
        height: 50
        MouseArea{
            anchors.fill: parent
            onClicked: {
                gameScene.state="playing"
                gameScene.score=0
                gameWindow.state="game"
            }
        }
    }

    Image {
        id: returnButton
        x:228
        y:400
        source: "../../assets/button/return.png"
        width: 100
        height: 50
        MouseArea{
            anchors.fill: parent
            onClicked: {
                roleScene.state="null"
                gameWindow.state="menu"
            }
        }
    }

    Text {
        id: rabbitText
        x:145
        y:76
        color: "black"
        font.pixelSize: 20
        visible: false
        text: qsTr("兔子")

    }

    Text {
        id:snowText
        x:145
        y:276
        color: "black"
        font.pixelSize: 20
        visible: false
        text: qsTr("圣诞老人")

    }

    //设置状态
    states:[
        State {
            name: "null"
            PropertyChanges {
                target:rabbitText
                visible:false

            }
            PropertyChanges {
                target:rabbit
                opacity:1

            }
            PropertyChanges {
                target:snow
                opacity:1

            }
            PropertyChanges {
                target:role
                source:bc1

            }
            PropertyChanges {
                target:snowText
                visible:false
            }
            PropertyChanges {
                target:snowAnimation
                running:false
            }
            PropertyChanges {
                target:rabbitAnimation
                running:false
            }
        },
        State {
            name: "rabbit"
            PropertyChanges {
                target:role
                source:bc

            }
            PropertyChanges {
                target:snow
                opacity:1

            }
            PropertyChanges {
                target:rabbitText
                visible:true

            }
            PropertyChanges {
                target:snowText
                visible:false
            }
            PropertyChanges {
                target:snowAnimation
                running:false
            }
            PropertyChanges {
                target:rabbitAnimation
                running:true
            }
        },
        State {
            name: "snow"
            PropertyChanges {
                target:rabbit
                opacity:1

            }
            PropertyChanges {
                target:role
                source:bc2

            }
            PropertyChanges {
                target:rabbitText
                visible:false

            }
            PropertyChanges {
                target:snowText
                visible:true
            }
            PropertyChanges {
                target:snowAnimation
                running:true
            }
            PropertyChanges {
                target:rabbitAnimation
                running:false
            }
        }
    ]
}

