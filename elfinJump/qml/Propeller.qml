import VPlay 2.0
import QtQuick 2.0

EntityBase {
    id: propeller
    entityType: "Propeller"
    state: "static"
    visible: opacity > 0
    enabled: visible
    //    opacity:100
    property alias propellerCollider: propellerCollider
    property alias propellerAnimation: propellerAnimation

    BoxCollider {
        id: propellerCollider
        width: parent.width
        height: parent.height
        bodyType: Body.Dynamic
        collisionTestingOnlyMode: true
        //        fixture.onBeginContact: {
        //            var otherEntity = other.getBody().target
        //            var otherEntityType = otherEntity.entityType
        //        if (otherEntityType === "Blackhole"){
        //                        propeller.opacity=0

        //                  }
        //        }
    }

    SpriteSequenceVPlay {
        id: propellerAnimation
        defaultSource: "../assets/role/兔子/道具/propellerbunny_X.png"
        scale: 0.38
        anchors.centerIn: propellerCollider

        SpriteVPlay {
            name: "sitting"
            frameCount: 2
            frameRate: 5
            frameWidth: 60
            frameHeight: 60
            startFrameColumn: 1 //动图起始位置，后直接乘framewidth
        }
    }

    onStateChanged: {

        if (propeller.state === "static") {
            propellerAnimation.running = false
        }
        if (propeller.state === "free") {

            propellerAnimation.running = true
            propellerAnimation.jumpTo("sitting")
        }
    }
    Behavior on opacity {
        NumberAnimation {
            duration: 350
        }
    }
}
