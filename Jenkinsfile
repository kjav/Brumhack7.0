pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Building...'
                sh "/home/ec2-user/godot-server/Godot_v2.1.5-stable_linux_server.64 -path . -export_debug 'Android' /home/ec2-user/something.apk || echo 'Built apk'"
                sh "/usr/bin/jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore /home/ec2-user/my-debug-key.keystore /home/ec2-user/.godot/tmp/tmpexport-unaligned.apk -storepass qWeRtYuIoP. noisy_leafvim build_app"
                sh "/home/ec2-user/android/build-tools/zipalign 4 /home/ec2-user/.godot/tmp/tmpexport-unaligned.apk output.apk"
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
