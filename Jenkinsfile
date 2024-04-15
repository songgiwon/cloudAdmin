pipeline {
    agent any

    tools {
        maven 'Maven' 
    }
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Build') {
            steps {
                sh 'echo Running build'
                sh 'mvn clean package'
            }
        }
        stage('Test') {
            steps {
                sh 'echo Running tests'
                sh 'mvn test'
            }
        }
        stage('Deploy') {
            steps {
                // 여기에 WAR 파일을 특정 위치로 이동하는 명령어 추가
                sh 'echo Deploying the build'
		sh 'cp target/CloudAdmin-0.war /kwsong/'
                //sh 'cd /kwsong && mv CloudAdmin*.war CloudAdmin.war'
            }
        }
	// Deploy Admin 단계를 stages 블록 내로 이동
        stage('Deploy Admin') {
            steps {
                script {
                    build job: 'pipeline_admin', wait: true
                }
            }
        }
    }
    post {
        always {
            archiveArtifacts artifacts: 'target/*.war', fingerprint: true
            junit 'target/surefire-reports/*.xml'
        }
        success {
            sh 'echo Build succeeded!'
        }
        failure {
            sh 'echo Build failed!'
        }
    }
}
