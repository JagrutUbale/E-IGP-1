pipeline {
    agent any

    tools {
        maven "MAVEN_HOME"
    }

	environment {	
		DOCKERHUB_CREDENTIALS=credentials('dockerloginid')
	} 
    
    stages {
        stage('SCM') {
            steps {
                git 'https://github.com/JagrutUbale/E-IGP-1.git'
            }
		}
        stage('Cleanup') {
            steps {
                sh "mvn -Dmaven.test.failure.ignore=true clean"
            }
		}
        stage('Compile') {
            steps {
                sh "mvn -Dmaven.test.failure.ignore=true compile"
            }
		}
        stage('Test') {
            steps {
                sh "mvn -Dmaven.test.failure.ignore=true test"
            }
		}
        stage('Build-Package') {
            steps {
                sh "mvn -Dmaven.test.failure.ignore=true package"
            }
		}
        stage('Deploy package on Local Tomcat 8090') {
            steps {
                sh "echo Before Deploying"
                sh "sudo rm -rf /opt/tomcat/webapps/ABCtechnologies-1.0*"
                sh "echo Deploying "
                sh "sudo cp -rvf target/ABCtechnologies-1.0.war /opt/tomcat/webapps/"
                sh "sudo /opt/tomcat/bin/shutdown.sh"
                sh "sudo /opt/tomcat/bin/startup.sh"
                sh "sh ./application-status.sh"
            }
		}        
        stage("Docker build"){
            steps {
				sh 'docker build -t jagrut13/e-igp-1 .'
            }
        }
		stage('LoginDockerHub') {

			steps {
				sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
			}
		}
		stage('Push2DockerHub') {

			steps {
				sh 'docker push jagrut13/e-igp-1'
			}
		}

}
}
