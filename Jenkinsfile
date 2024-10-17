pipeline {

    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub')
    }

    stages {
        
        stage('Git Clone') {
            steps {
                git branch: 'main', url: 'https://github.com/Manideep-thota/Dockerfile'
            }
        }

        stage('Docker Build') {
            steps {
                sh 'docker build -t manideep9946/nodeapp_test:latest .'
            }
        }

        stage('DOCKER HUB') {
            steps {
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
            }
        }

        stage('Push') {
            steps {
                sh 'docker push manideep9946/nodeapp_test:latest'
            }
        }
    }

    post {
        always {
            sh 'docker logout'
        }
    }
}
