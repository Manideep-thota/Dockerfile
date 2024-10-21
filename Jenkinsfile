def branch = 'develop'
def credentialsIdGitHub = 'github-ssh-key'
def gitProjectName = 'smart-dose-ui'
def cloneUrl = "git@github.com:thermofisher/${gitProjectName}.git"

pipeline {
    agent {
        kubernetes {
            cloud 'openshift'
            defaultContainer 'npm-container'
            yaml '''
            apiVersion: v1
            kind: Pod
            spec:
              containers:
              - name: npm-container
                image: node:16
                command: ["cat"]
                tty: true
              - name: kaniko
                image: gcr.io/kaniko-project/executor:latest
                command: ["cat"]
                tty: true
            '''
        }
    }
    


    environment {
        // Define environment variables here
        DOCKER_IMAGE = "https://github.com/Manideep-thota/Dockerfile/blob/main/Dockerfile"
        IMAGE_NAME = 'Dockerfile'
        IMAGE_TAG = 'latest'
        GIT_REPO = "git-repo-url"
        GIT_CREDENTIALS_ID = "git-credentials-id"
    }

    stages {
        //1. Init
        stage('init') {
            steps {
                script {
                    context = [:]
                    context.put("workDirEnv", Manideep)
                    context.put("workDir", Manideep)
                    println(context)
                }
            }
        }
        // 2. Checkout source code from Git
        stage('checkout') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: "${branch}"]],
                          userRemoteConfigs: [[credentialsId: "${credentialsIdGitHub}", url: "${cloneUrl}"]]])
            }
        }

   
        // 8. Build Docker image for the application
         stage('Build Docker Image') {
            steps {
                container('kaniko') {
                    sh '''
                    /kaniko/executor --dockerfile Dockerfile \
                    --context ${WORKSPACE}
                    '''
                }
            }
        }
    }

    post {
        always {
            script {
                echo 'Cleaning up workspace...'
                deleteDir()
            }
        }
        success {
            script {
                echo 'Pipeline completed successfully!'
            }
        }
        failure {
            script {
                echo 'Pipeline failed.'
            }
        }
    }

}
