import QtQuick 2.0
import VPlay 2.0
import QtSensors 5.5
import "../"
import "./"
import VPlayPlugins 1.0
import QtQuick.Particles 2.0


//开始游戏的界面
SceneBase {
    id: gameScene
    width: 320
    state: "start" //初始状态设为start

    property int score: 0 //分数初始化
    property alias elfin: elfin
    property int index: 2
    property alias move: move

    property string bc: "../../assets/role/兔子/background/background.png" //添加背景别名

    property string bc2: "../../assets/role/圣诞/背景/snowbck_X.png"
    Keys.forwardTo: elfin.controller

    //切换场景
    Image {
        //添加背景图片
        anchors.fill: parent.gameWindowAnchorItem
        source: roleScene.state === "rabbit" ? bc : bc2
    }

    //移动设备控制
    Accelerometer {
        id: accelerometer
        active: true
    }
    //物理
    PhysicsWorld {
        debugDrawVisible: false
        updatesPerSecondForPhysics: 60
        gravity.y: 20 //重力
    }

    //设置菜单按钮，可以切换回菜单界面
    Image {
        id: menuButton
        source: "../../assets/button/menuButton.png"
        width: 50
        height: 40
        x: gameScene.width - 50
        y: -10

        MouseArea {
            id: menuButtonMouseArea
            anchors.fill: parent
            onClicked: {
                gameWindow.state = "stop"
                gameScene.state = "playing"
            }
        }
    }
    onStateChanged: {
        if (gameScene.state === "gameOver") {
            gameScene.state = "start"
            gameWindow.state = "again"
        }
    }

    //显示游戏得分
    Text {
        id: scoreText
        anchors.top: gameScene.top
        anchors.topMargin: 4
        anchors.left: gameScene.left
        anchors.leftMargin: 2
        color: "black"
        font.pixelSize: 22
        text: "Score:" + score
    }

    //初始平台
    Platform {
        id: platform
        x: 120
        y: 300
    }

    //初始边界
    Border {
        id: border
        x: -gameScene.width * 2
        y: gameScene.height - 10
    }

    //初始小精灵
    Elfin {
        id: elfin
        x: gameScene.width / 2
        y: 220
    }

    // 初始化蜻蜓
    Propeller {
        id: propeller
        x: 123
        y: 150
    }

    //初始炸弹
    Bomb {
        id: bomb
        entityId: "bomb"
        x: utils.generateRandomValueBetween(0, gameScene.width)
        y: -100
    }

    //初始移动平台
    MovePlatform {
        id: move
        //位置随机产生
        x: utils.generateRandomValueBetween(0, gameScene.width)
        y: utils.generateRandomValueBetween(elfin.y - 400,
                                            -gameScene.height + 400)
    }

    //初始断板
    Brokenplatform {
        id: broken
        entityId: "broken"

        x: utils.generateRandomValueBetween(0, gameScene.width)
        y: -gameScene.height
    }

    //初始怪兽
    Monster {
        id: monster
        entityId: "monster"
        x: utils.generateRandomValueBetween(0, gameScene.width)
        y: -400
    }

    //初始弹簧
    Spring {
        id: spring
        x: platform.x + 30
        y: platform.y
    }

    //初始黑洞
    Blackhole {
        id: hole
        entityId: "black"
        x: utils.generateRandomValueBetween(0, gameScene.width)
        y: -300
    }

    //中继器，增加平台
    Repeater {
        model: 6
        Platform {
            x: utils.generateRandomValueBetween(0, gameScene.width)
            y: gameScene.height / 5 * index
        }
    }
    Repeater {
        model: 2
        MovePlatform {
            x: utils.generateRandomValueBetween(0, gameScene.width)
            y: utils.generateRandomValueBetween(elfin.y - 400, gameScene.height)
        }
    }

    //计时器，随时间变化任意出现怪兽，黑洞，断板，炸弹等道具
    Timer {
        id: monsterTimer
        interval: 23000 //间隔
        running: true
        repeat: true //重复
        onTriggered: {
            monsterCreat()
        }
    }
    Timer {
        id: holeTimer
        interval: 20000 //间隔
        running: true
        repeat: true //重复
        onTriggered: {
            creat()
        }
    }
    Timer {
        id: brokenTimer
        interval: 20000 //间隔
        running: true
        repeat: true //重复
        onTriggered: {
            brokenCreat()
        }
    }
    Timer {
        id: bombTimer
        interval: 20000 //间隔
        running: true
        repeat: true //重复
        onTriggered: {
            bombCreat()
        }
    }

    function monsterCreat() {
        monster.x = utils.generateRandomValueBetween(0, gameScene.width)
        monster.y = -50
    }

    function creat() {
        hole.x = utils.generateRandomValueBetween(0, gameScene.width)
        hole.y = utils.generateRandomValueBetween(elfin.y - 500,
                                                  gameScene.height)
    }

    function bombCreat() {
        bomb.state = "unexplode"
        bomb.opacity = 1
        bomb.x = utils.generateRandomValueBetween(0, gameScene.width)
        bomb.y = -gameScene.height
    }

    function brokenCreat() {
        broken.state = "disappear"
        broken.opacity = 1
        broken.x = utils.generateRandomValueBetween(0, gameScene.width)
        broken.y = -gameScene.height
    }
}
