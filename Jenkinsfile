def branch = 'develop'
def credentialsIdGitHub = 'github-ssh-key'
def gitProjectName = 'smart-dose-ui'
def cloneUrl = "git@github.com:thermofisher/${gitProjectName}.git"

pipeline {
    agent {
        kubernetes {
            yaml """
apiVersion: v1
kind: Pod
metadata:
  labels:
    app: docker-builder
spec:
  containers:
  - name: docker
    image: docker:latest
    command:
    - cat
    tty: true
    volumeMounts:
    - name: docker-socket
      mountPath: /var/run/docker.sock
  restartPolicy: Never
  volumes:
  - name: docker-socket
    hostPath:
      path: /var/run/docker.sock
"""
        }
    }

    environment {
        REGISTRY = 'docker.io'                   // Docker Hub URL (registry)
        IMAGE_NAME = 'manideep9946/testrepo'     // Docker Hub username/repository name
        IMAGE_TAG = 'latest'                     // Image tag (can be a branch name, version number, etc.)
    }

    stages {
        stage('Install Git') {
            steps {
                container('docker') {
                    sh '''
                    apk add --no-cache git
                    systemctl start docker.service
    		    systemctl status docker.service
                    '''
                }
            }
        }

        stage('Checkout Code') {
            steps {
                container('docker') { // Make sure to run this in the docker container
                    sh 'git clone https://github.com/Manideep-thota/Dockerfile.git'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                container('docker') {
                    script {
                        // Build the Docker image using the Dockerfile
                        sh '''
                        docker build -t $IMAGE_NAME:$IMAGE_TAG .
                        '''
                    }
                }
            }
        }

        stage('Login to Docker Hub') {
            steps {
                container('docker') {
                    script {
                        // Login to Docker Hub using credentials stored in Jenkins
                        withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                            sh 'echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin'
                        }
                    }
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                container('docker') {
                    script {
                        // Push the built Docker image to Docker Hub
                        sh '''
                        docker push $IMAGE_NAME:$IMAGE_TAG
                        '''
                    }
                }
            }
        }

        stage('Logout from Docker Hub') {
            steps {
                container('docker') {
                    script {
                        // Logout from Docker Hub
                        sh 'docker logout'
                    }
                }
            }
        }
    }

    post {
        always { `
            // Clean up workspace
            cleanWs()
        }
    }
}
