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
                    withCredentials([string(credentialsId: 'dockerurl', variable: 'DOCKER_REGISTRY'),
                                     string(credentialsId: 'username', variable: 'DOCKER_USERNAME'),
                                     string(credentialsId: 'password', variable: 'DOCKER_PASSWORD')]) {
                        def dockerUsername = sh(script: 'echo $DOCKER_USERNAME', returnStdout: true).trim()
                        sh "docker build -t ${dockerUsername}/jenkins:${currentBuild.number} ."
                    }
                }
            }
        }

        stage('Docker Login') {
            steps {
                script {
                    withCredentials([string(credentialsId: 'dockerurl', variable: 'DOCKER_REGISTRY'),
                                     string(credentialsId: 'username', variable: 'DOCKER_USERNAME'),
                                     string(credentialsId: 'password', variable: 'DOCKER_PASSWORD')]) {
                        def dockerUsername = sh(script: 'echo $DOCKER_USERNAME', returnStdout: true).trim()
                        sh 'docker login -u ${dockerUsername} -p $DOCKER_PASSWORD $DOCKER_REGISTRY'
                    }
                }
            }
        }

        stage('Docker Push') {
            steps {
                script {
                    withCredentials([string(credentialsId: 'dockerurl', variable: 'DOCKER_REGISTRY'),
                                     string(credentialsId: 'username', variable: 'DOCKER_USERNAME'),
                                     string(credentialsId: 'password', variable: 'DOCKER_PASSWORD')]) {
                        def dockerUsername = sh(script: 'echo $DOCKER_USERNAME', returnStdout: true).trim()
                        sh "docker push ${dockerUsername}/jenkins:${currentBuild.number}"
                    }
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

