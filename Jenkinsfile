pipeline {

    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub')
    }

    stages {
        
        stage('Git Clone') {
            steps {
                git 'https://github.com/Manideep-thota/Dockerfile'
            }
        }

        stage('Build') {
            steps {
                sh 'docker build -t manideep9946/nodeapp_test:latest .'
            }
        }

        stage('Login') {
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
