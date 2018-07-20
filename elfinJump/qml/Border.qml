import QtQuick 2.0
import VPlay 2.0

//边界实体
EntityBase {
  entityType: "Border"

  BoxCollider {
    width: gameScene.width * 5 // use large width to make sure the elfin can't fly past it
    height: 50
    bodyType: Body.Static // this body shall not move

    collisionTestingOnlyMode: true

    // a Rectangle to visualize the border
    Rectangle {
      anchors.fill: parent
      color: "red"
      visible: false // set to false to hide
    }
  }
}
