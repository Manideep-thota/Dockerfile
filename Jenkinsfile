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
        DOCKER_REGISTRY = 'docker.io'
        IMAGE_NAME = 'manideep9946/test_kaniko'  // will add image name later
        TAG = "${env.BRANCH_NAME}-${env.BUILD_NUMBER}"  
    }

    stages {
        stage('Build & Push image') {
            steps {
                
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'manideep9946', passwordVariable: 'Manitha@9946')]) {
                    container('kaniko') {
                        script {
                            sh '''
                            
                            echo "{\"auths\":{\"$DOCKER_REGISTRY\":{\"username\":\"$manideep9946\",\"password\":\"$Manitha@9946\"}}}" > /kaniko/.docker/config.json
                            
                            
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
