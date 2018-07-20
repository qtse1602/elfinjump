import QtQuick 2.0
import VPlay 2.0
import"scenes"
//弹簧实体

EntityBase {
    id: springEntity
    entityType: "Spring"
    state: "up"
   property alias springCollider:springCollider
    Image
      {
        id: spring
        source: "../assets/spring.png"
        scale: 0.5
        anchors.centerIn: springCollider        
    }

    BoxCollider {
        id: springCollider
        width: parent.width
        height: parent.height- 20
        bodyType: Body.Dynamic
        collisionTestingOnlyMode: true
    }
//    ScaleAnimator {
//        //震动效果
//        id: wobbleAnimation
//        target: springEntity
//        running: false // default is false and it gets activated on every collision
//        from: 0.9
//        to: 1
//        duration: 1000
//        easing.type: Easing.OutElastic // Easing used get an elastic wobbling instead of a linear scale change
//    }

//    // function to start wobble animation
//    function playWobbleAnimation() {
//        wobbleAnimation.start()
//    }

}
