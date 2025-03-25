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
                    docker.withRegistry('',DOCKER_PASS) {
                        docker_image = docker.build "${IMAGE_NAME}"
                    }

                    docker.withRegistry('',DOCKER_PASS) {
                        docker_image.push("${IMAGE_TAG}")
                        docker_image.push('latest')
                    }
                }
                
            }
        }

        stage("Trigger CD Pipeline"){
            steps {
                script {
                    sh "Curl -v -k --user admin:${JENKINS_API_TOKEN} -X POST -H 'cache-control: no-cache' -H 'content-type: application/x-www-form-urlencoded' --data 'IMAGE_TAG=${IMAGE_TAG}' 'https://10.203.200.201:8080/job/CD-pipeline/buildWithParameter?token=gitops-token'"
                }
            }
        }
    }
}
