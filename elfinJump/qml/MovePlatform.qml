import QtQuick 2.2
import VPlay 2.0
   //移动的平台
EntityBase {
    id: moveplatform
    entityType: "movePlatform"
    width: 64
    height: 20
    property alias moveplatformCollider:moveplatformCollider

    Image {
        id: moveplatformImg
        source:"../assets/platform/move_plantfrom.png"
        anchors.fill: moveplatform
    }


    BoxCollider {
        id: moveplatformCollider
        width: parent.width
        height: parent.height- 20
        bodyType: Body.Dynamic
        collisionTestingOnlyMode: true

        fixture.onBeginContact: {
            var otherEntity = other.getBody().target
            var otherEntityType = otherEntity.entityType

            if (otherEntityType === "Border") {
                moveplatform.x = 20
                moveplatform.y = utils.generateRandomValueBetween(elfin.elfinCollider.linearVelocity.y-400,gameScene.height)

            }
        }
    }
    MovementAnimation {
        target: moveplatform
        property: "y"
        velocity: elfin.impulse / 2
        running: elfin.y < 210
    MovementAnimation {
       // id:movement
        target: moveplatform
        property: "x"
        velocity: 60
        running: true
    }
    }

    ScaleAnimator {//震动效果
        id: wobbleAnimation
        target: moveplatform
        running: false
        from: 0.9
        to: 1
        duration: 1000
        easing.type: Easing.OutElastic
    }

    function playWobbleAnimation() {
        wobbleAnimation.start()
    }
}
