import QtQuick 2.2
import VPlay 2.0

//断板实体
EntityBase {
    id: brokenPlatform
    entityType: "BrokenPlatform"
    width: 60
    height: 30
    visible: opacity > 0
    enabled: visible
    state: "disappear"
    property alias brokenPlatformCollider:platformCollider

    //动画处理
    SpriteSequenceVPlay {
        id: brokenAnimation
        defaultSource:roleScene.state==="rabbit"?"../assets/platform/broken_ban.png":"../assets/platform/gametilessnow_X.png"
        anchors.centerIn: platformCollider
        anchors.fill: brokenPlatform

        SpriteVPlay {
            name:"start"
            frameWidth: 120
            frameHeight:40
            frameCount: 1
            frameRate:1
            startFrameRow:1//动图起始位置，后直接乘framewidth

        }
        SpriteVPlay {
            name: "broken"
            frameCount: 1
            frameRate: 5
            frameWidth: 120
            frameHeight:50
            startFrameRow:4
        }

    }

    BoxCollider {
        id: platformCollider
        width: parent.width
        height: parent.height - 20
        bodyType: Body.Dynamic //动态，可相互碰撞
        collisionTestingOnlyMode: true//可从目标获取位置，碰撞器仅用于碰撞检测，
        //而不对位置做更新，将改变位置
        fixture.onBeginContact: {
            var otherEntity = other.getBody().target
            var otherEntityType = otherEntity.entityType
            if (otherEntityType === "Elfin"&&elfin.state==="falling") {
                   brokenPlatform.state="stamped"
            }
        }

    }
    MovementAnimation {//平台移动动画
        id: movement
        target: brokenPlatform
        property: "y"
        velocity: elfin.impulse / 2
        running: elfin.y < 210
    }

    ScaleAnimator {//震动效果
        id: wobbleAnimation
        target: brokenPlatform
        running: false
        from: 0.9
        to: 1
        duration: 1000
        easing.type: Easing.OutElastic
    }
    onStateChanged: {
        if( brokenPlatform.state==="stamped"){
            brokenAnimation.jumpTo("broken");
            brokenPlatform.opacity=0
        }
        else if( brokenPlatform.state==="disappear"){
            brokenAnimation.jumpTo("start")
        }
    }
    Behavior on opacity {
        NumberAnimation { duration: 350 }
    }
    function playWobbleAnimation() {
        wobbleAnimation.start()
    }

}
