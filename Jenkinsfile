pipeline{
    agent{
        label "jenkins-agent"
    }

    tools {
        jdk 'Java17'
    }

    environment {
        APP_NAME = "minisized-web"
        RELEASE = "0.11"
        DOCKER_USER = "pys0530"
        DOCKER_PASS = "dockerhub"
        IMAGE_NAME = "${DOCKER_USER}" + "/" + "${APP_NAME}" 
        IMAGE_TAG = "${RELEASE}-${BUILD_NUMBER}"
    }

    stages {
        stage("Cleanup Workspace"){
            steps {
                cleanWs()
            }
        }

        stage("Checkout from SCM"){
            steps {
                git branch: 'main', credentialsId: 'github', url: 'https://github.com/pys0530/Jenkins-pipe'
            }
        }

        stage("Build & Push Docker Image"){
            steps {
                script {
                    docker.withDockerRegistry('', DOCKER_PASS) {
                        docker_image = docker.build "${IMAGE_NAME}"
                    }

                    docker.withDockerRegistry('',DOCKER_PASS) {
                        docker_image.push("${IMAGE_TAG}")
                        docker_image.push('latest')
                    }
                }
                
            }
        }

    }
}