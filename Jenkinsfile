pipeline{
    agent {
      label "Maven-builds"
    }
    stages{
      stage('build source code'){
        steps{
            sh '/opt/apache-maven-3.9.9/bin/mvn clean install -Dmaven.test.skip=true'
        }
      }
      stage('CODE ANALYSIS with SONARQUBE') {
          
		  environment {
             scannerHome = tool 'sonar6.2'
          }

          steps {
            withSonarQubeEnv('sonar-server') {
               sh '''${scannerHome}/bin/sonar-scanner -Dsonar.projectKey=projectuday_project2 \
                   -Dsonar.projectName=project2 \
                   -Dsonar.projectVersion=1.0 \
                   -Dsonar.sources=src/ \
                   -Dsonar.java.binaries=target/classes \
                   '''
            }
          }
      }
}
}