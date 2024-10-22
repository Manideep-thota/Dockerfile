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
                volumeMounts:
                - name: docker-config
                  mountPath: /kaniko/.docker
              volumes:
              - name: docker-config
                secret:
                  secretName: dockerhub-secret
            """
        }
    }

    environment {
        DOCKER_REGISTRY = 'docker.io'   
        IMAGE_NAME = 'manideep9946/test_kaniko'  
        TAG = "${env.BRANCH_NAME}-${env.BUILD_NUMBER}"  
    }
   
        DOCKER_USERNAME = 'manideep9946'
        DOCKER_PASSWORD = 'Manitha@9946'
    stages {
        stage('Prepare Dockerfile') {
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
                        sh '''
                        
                        echo "{\"auths\":{\"$DOCKER_REGISTRY\":{\"username\":\"$DOCKER_USERNAME\",\"password\":\"$DOCKER_PASSWORD\"}}}" > /kaniko/.docker/config.json
                        
                        /kaniko/executor --context ./ --dockerfile Dockerfile \
                        --destination=${DOCKER_REGISTRY}/${IMAGE_NAME}:${TAG} \
                        --skip-tls-verify
                        '''
                    }
               
