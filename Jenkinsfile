pipeline{
    agent{
        label "jenkins-agent"
    }

    tools {
        jdk 'Java17'
    }

    environment {
        APP_NAME = "minisized-web"
        RELEASE = "0.17"
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
                        docker_image = docker.build("${IMAGE_NAME}", "--no-cache .")
                    }

                    docker.withRegistry('',DOCKER_PASS) {
                        docker_image.push("${IMAGE_TAG}")
                        docker_image.push('latest')
                    }
                }
            }
        }

         stage('Docker Run') {
            steps {
                echo 'Pull Docker Image & Docker Image Run'
                sshagent (credentials: ['AWS-EC2']) {
                    sh "ssh -o StrictHostKeyChecking=no ec2-user@cloudeng.store 'docker-compose -f /home/ec2-user/docker-compose.yml down'"
                    sh "ssh -o StrictHostKeyChecking=no ec2-user@cloudeng.store 'docker image prune -af'"
                    sh "ssh -o StrictHostKeyChecking=no ec2-user@cloudeng.store 'docker-compose -f /home/ec2-user/docker-compose.yml up --build -d'"
                }
            }
        }

    }

    post {
        cleanup {
            dir("${env.WORKSPACE}@tmp") {
              deleteDir()
            }
        }

    }
}
