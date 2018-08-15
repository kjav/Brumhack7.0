pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Building...'
                sh "Godot_v2.1.5-stable_linux_server.64 -path ~/git/DnD -export_debug 'Android' something.apk || echo 'Built apk'"
                sh "jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore ~/my-debug-key.keystore ~/.godot/tmp/tmpexport-unaligned.apk -storepass qWeRtYuIoP. noisy_leafvim build_app"
                sh "zipalign 4 ~/.godot/tmp/tmpexport-unaligned.apk output.apk"
                echo 'Finished building apk.'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying...'
            }
        }
    }
}
