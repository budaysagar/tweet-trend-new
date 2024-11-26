pipeline{
    agent{
        label "Maven-builds"
    }
    stages{
      stage('build source code'){
        steps{
            sh '/opt/apache-maven-3.9.9/bin/mvn clean install -Dmaven.test.skip=true'
        }
      }
    }
}