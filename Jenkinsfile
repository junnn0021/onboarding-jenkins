pipeline {
    agent any

    environment {
        DOCKER_REGISTRY = credentials('dockerurl') // Docker 레지스트리 URL
        DOCKER_USERNAME = credentials('username') // Docker 레지스트리 계정 Credential ID
        DOCKER_PASSWORD = credentials('password') // Docker 레지스트리 비밀번호 Credential ID
        BUILD_NUMBER_TAG = env.BUILD_NUMBER // Jenkins에서 제공하는 빌드 번호를 사용
    }

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    // Docker build with build number tag
                    sh "docker build -t ${DOCKER_REGISTRY}/jenkins:${BUILD_NUMBER_TAG} ."
                }
            }
        }

        stage('Docker Login') {
            steps {
                script {
                    // Docker login with credentials
                    sh "docker login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD} ${DOCKER_REGISTRY}"
                }
            }
        }

        stage('Docker Push') {
            steps {
                script {
                    // Docker push with build number tag
                    sh "docker push ${DOCKER_REGISTRY}/jenkins:${BUILD_NUMBER_TAG}"
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

