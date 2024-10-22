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
                - sleep
                args:
                - "100" 
                tty: true
            """
        }
    }

    environment {
        DOCKER_REGISTRY = '?'
        IMAGE_NAME = 'manideep9946/test_kaniko'  // will add image name later
        TAG = "${env.BRANCH_NAME}-${env.BUILD_NUMBER}"  
    }

    stages {
        stage('Build & Push image') {
            steps {
                
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_UN', passwordVariable: 'DOCKER_PWD')]) {
                    container('kaniko') {
                        script {
                            sh '''
                            
                            echo "{\"auths\":{\"$DOCKER_REGISTRY\":{\"username\":\"$DOCKER_UN\",\"password\":\"$DOCKER_PWD\"}}}" > /kaniko/.docker/config.json
                            
                            
                            /kaniko/executor --context ./docker --dockerfile docker/Dockerfile \
                            --destination=${DOCKER_REGISTRY}/${IMAGE_NAME}:${TAG} \
                            --skip-tls-verify 
                            ''' // feel free to change tls
                        }
                    }
                }
            }
        }
    }
}
