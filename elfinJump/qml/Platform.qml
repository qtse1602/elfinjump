import QtQuick 2.2
import VPlay 2.0

//平台实体
EntityBase {
    id: platform
    entityType: "Platform"
    width: 64
    height: 20
    property alias platformCollider:platformCollider
    Image {
        id: platformImg
        source: roleScene.state==="rabbit"?"../assets/platform/bunny_X.png":"../assets/platform/b_l.png"
        anchors.fill: platform
    }

    BoxCollider {
        id: platformCollider
        width: parent.width
        height: parent.height-20
        bodyType: Body.Dynamic //动态，可相互碰撞
        collisionTestingOnlyMode: true //可从目标获取位置，碰撞器仅用于碰撞检测，

        //而不对位置做更新，将改变位置
        fixture.onBeginContact: {
            var otherEntity = other.getBody().target
            var otherEntityType = otherEntity.entityType

            if (otherEntityType === "Border") {
                platform.x = utils.generateRandomValueBetween(
                            32, gameScene.width - 64) // generate random x
                platform.y = 0 // the top of the screen
            }
        }
    }

    MovementAnimation {
        //平台移动动画
        id: movement
        target: platform
        property: "y"
        velocity: elfin.impulse / 2
        running: elfin.y < 210 //高度小于210执行
    }

    ScaleAnimator {
        //震动效果
        id: wobbleAnimation
        target: platform
        running: false // default is false and it gets activated on every collision
        from: 0.9
        to: 1
        duration: 1000
        easing.type: Easing.OutElastic // Easing used get an elastic wobbling instead of a linear scale change
    }

    // function to start wobble animation
    function playWobbleAnimation() {
        wobbleAnimation.start()
    }
}
