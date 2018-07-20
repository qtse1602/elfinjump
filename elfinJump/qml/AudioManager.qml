import VPlay 2.0
import QtQuick 2.0
import QtMultimedia 5.0
import "scenes"

//音乐管理
Item {
    id: audioManager

    Component.onCompleted: handleMusic()

    //主界面背景音乐
    BackgroundMusic {
        id: menuMusic
        autoPlay: false
        source: "../assets/music/backgroundMusic.mp3"
    }

    //游戏背景音乐
    BackgroundMusic {
        id: playMusic
        autoPlay: false
        source: "../assets/music/11.wav"
    }

    //选择游戏角色界面的音乐
    BackgroundMusic {
        id: roleMusic
        autoPlay: false
        source: "../assets/music/roleMusic.mp3"
    }

    SoundEffectVPlay {
        id:playDie
        source: "../assets/music/lose.wav"
    }

    // 判断游戏当前界面是那个界面 然后调用音乐播放函数
    function handleMusic() {

        if (activeScene === gameScene) {
            audioManager.startMusic(playMusic)
        } else if (activeScene === menuScene) {

            audioManager.startMusic(menuMusic)
        } else if (activeScene === roleScene) {

            audioManager.startMusic(roleMusic)
        }
    }

    // starts the given music
    function startMusic(music) {
        // if music is already playing, we don't have to do anything
        if (music.playing)
            return

        // otherwise stop all music tracks
        menuMusic.stop()
        playMusic.stop()
        roleMusic.stop()

        // play the music
        music.play()
    }

    // play the sound effect with the given name
    function playSound(sound) {
        if (sound === "playerJump")
            playerJump.play()
        else if (sound === "playerDie")
            playDie.play()

        else
            console.debug("unknown sound name:", sound)
    }

    // stop the sound effect with the given name
    function stopSound(sound) {
        if (sound === "playerInvincible")
            playerInvincible.stop()
        else
            console.debug("unknown sound name:", sound)
    }
}
