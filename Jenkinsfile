pipeline {
    agent any

    environment {
        DOCKER_REGISTRY = credentials('dockerurl')
        DOCKER_USERNAME = credentials('username')
        DOCKER_PASSWORD = credentials('password')
    }

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t $DOCKER_REGISTRY/jenkins:${currentBuild.number} .'
                }
            }
        }

        stage('Docker Login') {
            steps {
                script {
                    sh 'docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD $DOCKER_REGISTRY'
                }
            }
        }

        stage('Docker Push') {
            steps {
                script {
                    sh 'docker push $DOCKER_REGISTRY/jenkins:${currentBuild.number}'
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
