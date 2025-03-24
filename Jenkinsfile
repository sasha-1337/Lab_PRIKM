pipeline {
    agent any
    environment {
        CONTAINER_NAME = "prikm_lab2"
        IMAGE_NAME = "squeezyfish/prikm"
    }

    stages {
        stage('Start') {
            steps {
                echo 'Lab_2: started by GitHub'
            }
        }

        stage('Cleanup old containers') {
            steps {
                sh '''
                if [ "$(docker ps -aq -f name=$CONTAINER_NAME)" ]; then
                    echo "Stopping and removing existing container: $CONTAINER_NAME"
                    docker stop $CONTAINER_NAME && docker rm $CONTAINER_NAME
                else
                    echo "No existing container found, skipping cleanup."
                fi
                '''
            }
        }

        stage('Image build') {
            steps {
                sh '''
                docker build -t prikm:latest .
                docker tag prikm $IMAGE_NAME:latest
                docker tag prikm $IMAGE_NAME:$BUILD_NUMBER
                '''
            }
        }

        stage('Push to registry') {
            steps {
                withDockerRegistry([credentialsId: "ID_облікових даних", url: ""]) {
                    sh '''
                    docker push $IMAGE_NAME:latest
                    docker push $IMAGE_NAME:$BUILD_NUMBER
                    '''
                }
            }
        }

        stage('Deploy image') {
            steps {
                sh '''
                docker run -d --name $CONTAINER_NAME -p 80:80 $IMAGE_NAME:latest
                echo "Deployment completed successfully!"
                '''
            }
        }
    }
}

