pipeline{
    agent{
        label "jenkins-agent"
    }

    tools {
        jdk 'Java17'
    }

    stages{
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
    }
}