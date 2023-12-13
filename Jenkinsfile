pipeline {
    agent any
}

stages {
    stage('Build Docker Image') {
        steps {
            script {
                withCredentials([string(credentialsId: 'username', variable: 'DOCKER_USERNAME'),
                                 string(credentialsId: 'password', variable: 'DOCKER_PASSWORD')]) {
                    sh "docker build -t $DOCKER_USERNAME/jenkins:${currentBuild.number} ."
                    sh "docker build -t $DOCKER_USERNAME/jenkins:latest ."
                }
            }
        }
    }

    stage('Docker Login') {
        steps {
            script {
                withCredentials([string(credentialsId: 'username', variable: 'DOCKER_USERNAME'),
                                 string(credentialsId: 'password', variable: 'DOCKER_PASSWORD')]) {
                    sh 'docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD'
                }
            }
        }
    }

    stage('Docker Push') {
        steps {
            script {
                withCredentials([string(credentialsId: 'username', variable: 'DOCKER_USERNAME'),
                                 string(credentialsId: 'password', variable: 'DOCKER_PASSWORD')]) {
                    sh "docker push $DOCKER_USERNAME/jenkins:${currentBuild.number}"
                    sh 'docker push $DOCKER_USERNAME/jenkins:latest'
                }
            }
        }
    }
}

post {
    success {
        script {
            // Remove local images after successful push
            sh "docker rmi $DOCKER_USERNAME/jenkins:${currentBuild.number}"
            sh 'docker rmi $DOCKER_USERNAME/jenkins:latest'
        }
    }

    failure {
        echo 'One or more stages failed. Check the logs for details.'
    }
}

