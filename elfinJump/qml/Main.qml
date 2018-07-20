import VPlay 2.0
import QtQuick 2.0
import "scenes"
import VPlayPlugins 1.0
import grade 1.0


//游戏窗口
GameWindow {
    id: gameWindow
    screenWidth: 600
    screenHeight: 900
    activeScene: MenuScene
    onActiveSceneChanged: {
        audiomanager.handleMusic()
    }

    //音频管理器
    AudioManager {
        id: audiomanager
    }

    //实体管理器
    EntityManager {
        id: entityManager
        entityContainer: gameScene
    }

    GoogleAnalytics {
        id: ga
        propertyId: "UA-67377753-2"
    }
    //游戏界面
    GameScene {
        id: gameScene

    }

    //游戏菜单界面
    MenuScene {
        id: menuScene

    }

    //历史得分界面
    ScoreScene {
        id: scoreScene

    }

    //停止回到菜单或继续游戏
    StopScene {
        id: stopScene

    }

    //死亡再来一次或者到菜单
    AgainScene {
        id: againScene

    }

    //设置分数，以存入数据库
    Info {
        id:info
    }

    //选择游戏场景
    RoleScene {
        id: roleScene

    }

    //根据状态进入某一界面
    state: "menu"
    states: [
        State {
            name: "menu"
            PropertyChanges {
                target: menuScene
                opacity: 1
            }
            PropertyChanges {
                target: gameWindow
                activeScene: menuScene
            }
        },
        State {
            name: "game"
            PropertyChanges {
                target: gameScene
                opacity: 1
            }
            PropertyChanges {
                target: gameWindow
                activeScene: gameScene
            }
        },
        State {
            name: "score"
            PropertyChanges {
                target: scoreScene
                opacity: 1
            }
            PropertyChanges {
                target: gameWindow
                activeScene: scoreScene
            }
        },
        State {
            name: "stop"
            PropertyChanges {
                target: stopScene
                opacity: 1
            }
            PropertyChanges {
                target: gameWindow
                activeScene: stopScene
            }
        },
        State {
            name: "again"
            PropertyChanges {
                target: againScene
                opacity: 1
            }
            PropertyChanges {
                target: gameWindow
                activeScene: againScene
            }
        },
        State {
            name: "role"
            PropertyChanges {
                target: roleScene
                opacity: 1
            }
            PropertyChanges {
                target: gameWindow
                activeScene: roleScene
            }
        }
    ]
}
