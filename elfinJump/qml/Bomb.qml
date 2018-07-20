import QtQuick 2.0
import VPlay 2.0

//炸弹实体
EntityBase {
    id: bombEntity
    entityType: "Bomb"
    visible:opacity > 0
    width: 20
    height: 20
    property alias bombCollider:bombCollider

    Image {
        id: bomb
        anchors.fill: bombEntity
    }


    BoxCollider {
        id: bombCollider
        width: parent.width
        height: parent.height - 20
        bodyType: Body.Dynamic
        collisionTestingOnlyMode: true
        rotation: 30
        fixture.onBeginContact: {
            var otherEntity = other.getBody().target
            var otherEntityType = otherEntity.entityType

            if (otherEntityType === "Blackhole") {
                   bombEntity.opacity=0

            }
            if (otherEntityType === "Elfin") {
                bombEntity.width=40
                bombEntity.height=40
                 bombEntity.state="explode"
            }
        }
    }

    Behavior on opacity {
        NumberAnimation { duration: 350 }
    }
    MovementAnimation {
        //炸弹移动动画
        id: movement
        target: bombEntity
        property: "y"
        velocity: 100
        running:gameScene.state==="playing"?true:false
    }
    state: "unexplode"

    //设置炸弹状态，添加爆炸的效果
    states:[
        State {
            name: "unexplode"
            PropertyChanges {
                target:bomb
                source:"../assets/bombdrop.png"

            }
            PropertyChanges {
                target:bombEntity
                width:20
                height:20

            }
        },
        State{
            name:"explode"
            PropertyChanges {
                target:bomb
                source:"../assets/blast3.png"
            }
            PropertyChanges {
                target:bombEntity
                width:40
                height:40

            }
    }

    ]

}
