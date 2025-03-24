pipeline {
    agent any
    stages {
        stage('Start') {
            steps {
                echo 'Lab_2: started by GitHub'
            }
        }
        stage('Image build') {
            steps {
                sh "docker build -t prikm:latest ."
                sh "docker tag prikm squeezyfish/lab2_prikm:latest"
                sh "docker tag prikm squeezyfish/lab2_prikm:$BUILD_NUMBER"
            }
        }
        stage('Push to registry') {
            steps {
                withDockerRegistry([ credentialsId: "dockerhub_token", url: "" ]) {
                    sh "docker push squeezyfish/lab2_prikm:latest"
                    sh "docker push squeezyfish/lab2_prikm:$BUILD_NUMBER"
                }
            }
        }
        stage('Deploy image'){
            steps{
                sh "docker run -d -p 80:80 squeezyfish/lab2_prikm"
            }
        }
    }
}
