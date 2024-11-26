pipeline{
    agent{
        label "Maven-builds"
    }
    tools{
      sonar 'sonar6.2'
    }
    stages{
      stage('build source code'){
        steps{
            sh '/opt/apache-maven-3.9.9/bin/mvn clean install -Dmaven.test.skip=true'
        }
      }
      stage('SonarQube Analysis') {
            steps {
                script {
                    sh """
                    mvn sonar:sonar \
                        -Dsonar.projectKey=projectuday_project2 \
                        -Dsonar.projectName=project2 \
                        -Dsonar.host.url=https://sonarcloud.io \
                        -Dsonar.login=sonarcreds \
                        -Dsonar.java.binaries=target/classes \
                        -Dsonar.organization=projectuday
                    """
                }
            }
    }
}
}