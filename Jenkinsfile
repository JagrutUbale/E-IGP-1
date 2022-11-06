pipeline {
    agent any

    tools {
        maven "MAVEN_HOME"
    }

	environment {	
		DOCKERHUB_CREDENTIALS=credentials('dockerloginid')
	} 
    
    stages {
        stage('SCM Checkout') {
            steps {
                git 'https://github.com/JagrutUbale/E-IGP-1.git'
            }
		}
        stage('Maven Cleanup') {
            steps {
                sh "mvn -Dmaven.test.failure.ignore=true clean"
            }
		}
        stage('Maven Compile') {
            steps {
                sh "mvn -Dmaven.test.failure.ignore=true compile"
            }
		}
        stage('Maven Test') {
            steps {
                sh "mvn -Dmaven.test.failure.ignore=true test"
            }
		}
        stage('Maven Build-package') {
            steps {
                sh "mvn -Dmaven.test.failure.ignore=true package"
            }
		}
        stage('Deploy package on Local Tomcat 8090') {
            steps {
                sh "echo Before Deploying"
                sh "rm -rf /opt/tomcat/webapps/ABCtechnologies-1.0*"
                sh "echo Deploying "
                sh "cp -rvf target/ABCtechnologies-1.0.war /opt/tomcat/webapps/"
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
