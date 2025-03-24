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
                sh "docker tag prikm назва_акаунту_dockerhub/prikm:latest"
                sh "docker tag prikm назва_акаунту_dockerhub/prikm:$BUILD_NUMBER"
            }
        }
        stage('Push to registry') {
            steps {
                withDockerRegistry([ credentialsId: "ID_облікових даних", url: "" ]) {
                    sh "docker push назва_акаунту_dockerhub/prikm:latest"
                    sh "docker push назва_акаунту_dockerhub/prikm:$BUILD_NUMBER"
                }
            }
        }
        stage('Deploy image'){
            steps{
                sh "docker run -d -p 80:80 назва_акаунту_dockerhub/prikm"
            }
        }
    }
}
