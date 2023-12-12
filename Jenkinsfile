pipeline {
    agent any

    environment {
        DOCKER_REGISTRY = credentials('dockerurl')
        DOCKER_USERNAME = credentials('username')
        DOCKER_PASSWORD = credentials('password')
        BUILD_NUMBER_TAG = '${env.BUILD_NUMBER}'
    }

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    sh ('docker build -t $DOCKER_REGISTRY/jenkins:$BUILD_NUMBER_TAG .')
                }
            }
        }

        stage('Docker Login') {
            steps {
                script {
                    sh ('docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD $DOCKER_REGISTRY')
                }
            }
        }

        stage('Docker Push') {
            steps {
                script {
                    sh ('docker push $DOCKER_REGISTRY/jenkins:$BUILD_NUMBER_TAG')
                }
            }
        }
    }

    post {
        success {
            echo 'Docker image build, login, and push successful!'
        }

        failure {
            echo 'One or more stages failed. Check the logs for details.'
        }
    }
}

