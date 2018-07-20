import QtQuick 2.0
import VPlay 2.0
import "scenes"

//怪兽实体
EntityBase {
    id: monsterEntity
    entityType: "monster"
    state: "falling"
    width: 40
    height: 40
    property  alias monsterCollider:monsterCollider
    Image {
        id: monster
        source: roleScene.state==="rabbit"?"../assets/monster.png":"../assets/enemy.png"

        anchors.fill: monsterEntity
    }

    BoxCollider {
        id: monsterCollider
        width: parent.width
        height: parent.height
        bodyType: Body.Dynamic
        collisionTestingOnlyMode: true

        fixture.onBeginContact: {

            var otherEntity = other.getBody().target
            var otherEntityType = otherEntity.entityType
            if (otherEntityType === "Platform"||otherEntityType === "BrokenPlatform") {
                 monsterEntity.state="move"
                monsterEntity.y=otherEntity.y-30
                movement.stop()
                xmovement.start()
     }else if(otherEntityType === "movePlatform") {
                monsterEntity.state="move"
                monsterEntity.y=otherEntity.y-30
                movement.stop()
                xmovement.start()
                xmovement.velocity=90
        }
        }
        fixture.onEndContact: {
            var otherEntity = other.getBody().target
            var otherEntityType = otherEntity.entityType
            if (otherEntityType === "Platform"||otherEntityType === "movePlatform"||otherEntityType === "BrokenPlatform") {
                xmovement.stop()
                movement.start()
        }
        }
    }

    MovementAnimation {
        //怪物移动动画
        id: movement
        target: monsterEntity
        property: "y"
        velocity: 80
        running:gameScene.state==="playing"?true:false
    }
    MovementAnimation {
        id:xmovement
        target:monsterEntity
        property: "x"
        velocity: 60
        running: false
    }

}
