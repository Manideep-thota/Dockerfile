pipeline {
    agent {
        kubernetes {
            yaml """
            apiVersion: v1
            kind: Pod
            spec:
              containers:
              - name: kaniko
                image: gcr.io/kaniko-project/executor:latest
                command:
                - cat
                tty: true
            """
        }
    }

    environment {
        DOCKER_REGISTRY = 'docker.io' 
        IMAGE_NAME = 'manideep9946/testingkaniko'  
        TAG = "${env.BRANCH_NAME}-${env.BUILD_NUMBER}"  
    }

    stages {
        stage('Create Dockerfile') {
            steps {
                script {
                    
                    writeFile file: 'Dockerfile', text: '''
                    FROM node:14-alpine

                    
                    RUN npm install -g npm

                    
                    WORKDIR /app

                    
                    COPY . .

                    
                    EXPOSE 3000

                   
                    CMD ["npm", "start"]
                    '''
                }
            }
        }

        stage('Build and Push Docker Image') {
            steps {
                container('kaniko') {
                    script {
                        
                        withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                            sh '''
                            # Create Docker config for Kaniko to authenticate with Docker Hub
                            echo "{\"auths\":{\"$DOCKER_REGISTRY\":{\"username\":\"$DOCKER_USERNAME\",\"password\":\"$DOCKER_PASSWORD\"}}}" > /kaniko/.docker/config.json

                            # Build and push Docker image using Kaniko
                            /kaniko/executor --context ./ --dockerfile Dockerfile \
                            --destination=${DOCKER_REGISTRY}/${IMAGE_NAME}:${TAG} \
                            --skip-tls-verify
                            '''
                        }
                    }
                }
            }
        }
    }

    post {
        success {
            echo 'Docker Image built and pushed successfully!'
        }
        failure {
            echo 'Failed to build and push Docker image.'
        }
    }
}
