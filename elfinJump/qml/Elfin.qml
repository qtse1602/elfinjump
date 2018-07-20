import QtQuick 2.0
import VPlay 2.0
import "scenes"
import grade 1.0

EntityBase {
    //小精灵实体
    id: elfinEntity
    entityType: "Elfin"
    state: elfinCollider.linearVelocity.y < 0 ? "jumping" : "falling"
    property alias elfinCollider: elfinCollider
    property alias mydb: mydb
    property real rightValue: 2
    property int impulse: y - elfinCollider.linearVelocity.y
    property alias controller: twoAxisController
    property string rabbit: "../assets/role/兔子/spritesheet.png"
    property string snow: "../assets/role/圣诞/snowman_right.png"
    property bool __isLookingRight: false

    TwoAxisController {
        id: twoAxisController
        onXAxisChanged: {
            if (xAxis < 0) {
                __isLookingRight = true
            } else if (xAxis > 0 || xAxis === 0) {
                __isLookingRight = false
            }
        }
    }

    SpriteSequenceVPlay {
        id: elfinAnimation
        defaultSource: roleScene.state === "rabbit" ? rabbit : snow
        mirror: __isLookingRight
        scale: 0.38
        anchors.centerIn: elfinCollider
        rotation: elfinEntity.state == "jumping" ? (system.desktopPlatform ? twoAxisController.xAxis * 15 : (accelerometer.reading !== null ? -accelerometer.reading.x * 10 : 0)) : 0
        SpriteVPlay {
            name: "sitting"
            frameWidth: 130
            frameHeight: 122
            startFrameColumn: 1 //动图起始位置，后直接乘framewidth
        }
        SpriteVPlay {
            name: "jumping"
            frameCount: 2
            frameRate: 8

            frameWidth: 130
            frameHeight: roleScene.state === "rabbit" ? 140 : 130
            frameX: 0
            frameY: 15
        }
        Behavior on scale {
            NumberAnimation {
                duration: 400
            }
        }
    }

    BoxCollider {
        id: elfinCollider
        width: 50
        height: 50 // 起始位置
        bodyType: gameScene.state == "playing" ? Body.Dynamic : Body.Static
        linearVelocity.x: system.desktopPlatform ? twoAxisController.xAxis * 200 : (accelerometer.reading !== null ? -accelerometer.reading.x * 100 : 0) //  for desktop按键图像移动速度
        //当联系发生改变，状态设置等变化
        fixture.onContactChanged: {
            var otherEntity = other.getBody().target
            var otherEntityType = otherEntity.entityType

            if (otherEntityType === "Border") {
                audiomanager.playSound("playerDie")
                elfinEntity.die()
            } else if (otherEntityType === "Platform"
                       && elfinEntity.state == "falling") {
                elfinCollider.linearVelocity.y = -350 //起跳高度
                otherEntity.playWobbleAnimation()
            } else if (otherEntityType === "monster") {
                elfinTimer1.running = true
            } else if (otherEntityType === "Bomb") {
                elfinTimer1.running = true
            } else if (otherEntityType === "Blackhole") {
                elfin.opacity = 0
                elfinAnimation.scale = 0
                movement.running = true
                elfinTimer.running = true
            } else if (otherEntityType === "BrokenPlatform"
                       && elfinEntity.state == "falling") {
                score += 20
                elfinCollider.linearVelocity.y = -400 //起跳高度

                otherEntity.playWobbleAnimation()
            } else if (otherEntityType === "Spring"
                       && elfinEntity.state == "falling") {
                elfinCollider.linearVelocity.y = -600
            } else if (otherEntityType === "movePlatform"
                       && elfinEntity.state == "falling") {

                elfinCollider.linearVelocity.y = -300
                otherEntity.playWobbleAnimation()
            } else if (otherEntityType === "Propeller") {
                propeller.x = elfin.x + 2
                propeller.y = elfin.y - 1
                elfinCollider.linearVelocity.y = -1600
                propeller.state = "free"
                elfinTimer2.running = true
                timer.running = true
            }
        }
    }

    MovementAnimation {
        //平台移动动画
        id: movement
        target: elfinEntity
        property: "rotation"
        velocity: 360
    }
    //动画处理
    onStateChanged: {
        if (elfinEntity.state == "jumping") {
            elfinAnimation.jumpTo("jumping")
        }
        if (elfinEntity.state == "falling") {
            elfinAnimation.jumpTo("sitting")
        }
    }
    onYChanged: {
        if (y < 100) {
            y = 100
            score += 1
        }
    }

    MyDB {
        id: mydb
        sql: "insert into grade value('" + info.grade.toString() + "')"
    }

    //死亡，重新开始
    function die() {
        movement.running = false
        elfinAnimation.scale = 0.38
        elfinEntity.x = gameScene.width / 2
        elfinEntity.y = 220
        elfinCollider.linearVelocity.y = 0
        elfinEntity.opacity = 1

        platform.x = 120
        platform.y = 300
        platform.platformCollider.linearVelocity.y = 0

        bomb.x = utils.generateRandomValueBetween(0, gameScene.width)
        bomb.y = -100
        bomb.bombCollider.linearVelocity.y = 0
        bomb.opacity = 1
        bomb.state = "unexplode"

        monster.x = utils.generateRandomValueBetween(0, gameScene.width)
        monster.y = -100
        monster.monsterCollider.linearVelocity.y = 0

        hole.x = utils.generateRandomValueBetween(0, gameScene.width)
        hole.x = -200

        move.x = utils.generateRandomValueBetween(0, gameScene.width)
        move.y = utils.generateRandomValueBetween(elfin.y + 300,
                                                  gameScene.height)
        move.moveplatformCollider.linearVelocity.y = 0
        move.moveplatformCollider.linearVelocity.x = 0

        broken.x = utils.generateRandomValueBetween(0, gameScene.width)
        broken.y = utils.generateRandomValueBetween(elfin.y + 300,
                                                    gameScene.height)
        broken.brokenPlatformCollider.linearVelocity.y = 0

        info.setGrade(score)
        mydb.exeSQL(mydb.sql) //连接数据库，存入数据
        gameScene.state = "gameOver"

        propeller.opacity = 100
        propeller.state = "static"
        //        platform.x = 100
        //        platform.y = 150
        propeller.x = platform.x + 30
        propeller.y = platform.y - 10
    }
    Behavior on opacity {
        NumberAnimation {
            duration: 400
        }
    }

    Timer {
        id: elfinTimer
        interval: 1000 //间隔
        running: false
        repeat: false //重复
        onTriggered: {
            gameScene.state = "gameOver"
            audiomanager.playSound("playerDie")
            die()
        }
    }
    Timer {
        id: elfinTimer1
        interval: 100 //间隔
        running: false
        repeat: false //重复
        onTriggered: {
            gameScene.state = "gameOver"
            audiomanager.playSound("playerDie")
            die()
        }
    }

    Timer {
        id: elfinTimer2 //2秒后竹蜻蜓消失
        interval: 2000 //间隔
        running: false
        repeat: false //重复
        onTriggered: {
            propeller.opacity = 0
            propeller.state = "static"
        }
    }
    Timer {
        id: timer //3秒后竹蜻蜓刷新
        interval: 3000 //间隔
        running: false
        repeat: false //重复
        onTriggered: {
            propeller.propellerCollider.linearVelocity.y = 0
            propeller.x = platform.x + 30
            propeller.y = platform.y
            propeller.opacity = 100

            //           elfinTimer2.running=false
        }
    }
}
