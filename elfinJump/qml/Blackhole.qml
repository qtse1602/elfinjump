import QtQuick 2.2
import VPlay 2.0

//黑洞实体
EntityBase {
    id: blackhole
    entityType: "Blackhole"
    width: 64
    height: 40

    property  alias blackHoleCollider: blackHoleCollider

   Image {
        id: hole
        source: "../assets/gametilesbunny_X.png"
        anchors.fill:blackhole
    }

    BoxCollider {
        id: blackHoleCollider
        width: parent.width
        height: parent.height
        bodyType: Body.Dynamic //动态，可相互碰撞
        collisionTestingOnlyMode: true//可从目标获取位置，碰撞器仅用于碰撞检测，
    }


    MovementAnimation {//平台移动动画
        id: movement
        target: blackhole
        property: "y"
        velocity: elfin.impulse / 2
        running: elfin.y < 210 //高度小于210执行
    }

    //震动效果
    ScaleAnimator {
        id: wobbleAnimation
        target:blackhole
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

