pipeline {
    agent any

    stages {
        stage('Start') {
            steps {
                echo 'Lab_1: nginx/custom'
            }
        }

        stage('Build nginx/custom') {
            steps {
                sh 'docker build -t nginx/custom:latest .'
            }
        }

        stage('Test nginx/custom') {
            steps {
                sh 'docker run --rm nginx/custom:latest nginx -t'        // Додано тестовий запуск контейнера.
                echo 'Container built and tested successfully!' // Змінено повідомлення про виконання
            }
        }

        stage('Cleanup old containers') {
            steps {
                sh 'docker stop $(docker ps -q --filter ancestor=nginx/custom:latest) || true'
                sh 'docker rm $(docker ps -aq --filter ancestor=nginx/custom:latest) || true'
            } // Додано автоматичне зупинення та видалення старих контейнерів перед новим розгортанням.
        }

        stage('Deploy nginx/custom') {
            steps {
                sh 'docker run -d -p 80:80 nginx/custom:latest'
                echo 'Deployment completed successfully!' // Повідомлення про результат виконання
            }
        }
    }
}
