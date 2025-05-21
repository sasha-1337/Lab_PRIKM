pipeline {
    agent any

    stages {
        stage('🔰 Початок процесу') {
            steps {
                echo 'Старт: Lab_7 pipeline'
            }
        }

        stage('🔐 Аутентифікація до HCP') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'hcp',
                    usernameVariable: 'HCP_CLIENT_ID',
                    passwordVariable: 'HCP_CLIENT_SECRET'
                )]) {
                    script {
                        sh 'hcp auth login --client-id $HCP_CLIENT_ID --client-secret $HCP_CLIENT_SECRET'
                    }
                }
            }
        }

        stage('⚙️ Ініціалізація HCP профілю') {
            steps {
                sh 'hcp profile set vault-secrets/app Lab-7'
            }
        }

        stage('🐳 Збірка Docker образу nginx/custom') {
            steps {
                sh 'docker build -t nginx/custom:latest .'
            }
        }

        stage('🚀 Деплой nginx/custom контейнера') {
            steps {
                sh 'docker run -d -p 80:80 nginx/custom:latest'
            }
        }

        stage('✅ Завершення процесу') {
            steps {
                echo 'Завершення: Lab_7 pipeline'
            }
        }
    }

    post {
        always {
            script {
                env.webhookUrl = sh(
                    script: 'hcp vault-secrets secrets open teams_microsoft_webhook --format=json | jq -r .static_version.value',
                    returnStdout: true
                ).trim()
            }
        }

        success {
            office365ConnectorSend(
                webhookUrl: webhookUrl,
                message: "✅ Збірка пройшла успішно!",
                status: "Success",
                color: "00FF00"
            )
        }

        failure {
            office365ConnectorSend(
                webhookUrl: webhookUrl,
                message: "❌ Збірка зазнала невдачі!",
                status: "Failure",
                color: "FF0000"
            )
        }
    }
}

