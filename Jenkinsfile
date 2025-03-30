properties([
    pipelineTriggers([]),
    office365ConnectorWebhooks([
        [
            name: 'Teams-O365',
            url: 'https://lpnu.webhook.office.com/webhookb2/c62d9391-5f4c-4b1c-8257-1a135c776eeb@7631cd62-5187-4e15-8b8e-ef653e366e7a/IncomingWebhook/1f30225b34144f93ae0caa0ffbd91460/0b84c391-4760-45c8-926a-02f1d3c8311e/V2l6yxdYY6-FhYB01SjYClR_i-__cros0GitaDS6aFzL81',
            startNotification: false,
            notifySuccess: true,
            notifyAborted: false,
            notifyNotBuilt: false,
            notifyUnstable: true,
            notifyFailure: true,
            notifyBackToNormal: true,
            notifyRepeatedFailure: false,
            timeout: 30000
        ]
    ])
])

pipeline {
    agent any
    environment {
        CONTAINER_NAME = "prikm_lab2"
        IMAGE_NAME = "squeezyfish/prikm"
        TEAMS_WEBHOOK_URL = "https://lpnu.webhook.office.com/webhookb2/c62d9391-5f4c-4b1c-8257-1a135c776eeb@7631cd62-5187-4e15-8b8e-ef653e366e7a/IncomingWebhook/1f30225b34144f93ae0caa0ffbd91460/0b84c391-4760-45c8-926a-02f1d3c8311e/V2l6yxdYY6-FhYB01SjYClR_i-__cros0GitaDS6aFzL81"
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
                withDockerRegistry([credentialsId: "dockerhub_token", url: ""]) {
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
    post {
        success {
            office365ConnectorSend message: "Build and deployment successful for tag: latest",
                webhookUrl: env.TEAMS_WEBHOOK_URL
        }
        failure {
            office365ConnectorSend message: "Build failed! Check Jenkins logs.",
                webhookUrl: env.TEAMS_WEBHOOK_URL
        }
    }
}
    

