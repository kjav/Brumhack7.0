pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Building...'
                sh "/opt/godot-server/Godot_v2.1.5-stable_linux_server.64 -path . -export 'Android' ~jenkins/something.apk || echo 'Built apk'"
                sh "/usr/bin/jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore /home/jenkins/my-debug-key.keystore ~jenkins/.godot/tmp/tmpexport-unaligned.apk -storepass qWeRtYuIoP. noisy_leaf"
                sh "/opt/android/build-tools/zipalign 4 ~jenkins/.godot/tmp/tmpexport-unaligned.apk output.apk"
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
