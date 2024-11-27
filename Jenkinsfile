def registry = 'https://uday9.jfrog.io/'
def imageName = 'uday9.jfrog.io/dockeruday-docker-local/ttrend'
def version   = '2.1.2'
pipeline{
    agent {
      label "Maven-builds"
    }
    stages{
      stage('build source code'){
        steps{
            sh '/opt/apache-maven-3.9.9/bin/mvn clean deploy -Dmaven.test.skip=true'
        }
      }
      stage("Jar Publish") {
        steps {
            script {
                    echo '<--------------- Jar Publish Started --------------->'
                     def server = Artifactory.newServer url:registry+"/artifactory" ,  credentialsId:"jfrogcreds"
                     def properties = "buildid=${env.BUILD_ID},commitid=${GIT_COMMIT}";
                     def uploadSpec = """{
                          "files": [
                            {
                              "pattern": "jarstaging/(*)",
                              "target": "uday-libs-release-local/{1}",
                              "flat": "false",
                              "props" : "${properties}",
                              "exclusions": [ "*.sha1", "*.md5"]
                            }
                         ]
                     }"""
                     def buildInfo = server.upload(uploadSpec)
                     buildInfo.env.collect()
                     server.publishBuildInfo(buildInfo)
                     echo '<--------------- Jar Publish Ended --------------->'  
            
            }
        }   
    }
      stage(" Docker Build ") {
        steps {
          script {
             echo '<--------------- Docker Build Started --------------->'
             app = docker.build(imageName+":"+version)
             echo '<--------------- Docker Build Ends --------------->'
        }
      }
    }

      stage (" Docker Publish "){
        steps {
            script {
               echo '<--------------- Docker Publish Started --------------->'  
                docker.withRegistry(registry, 'jfrogcreds'){
                    app.push()
                }    
               echo '<--------------- Docker Publish Ended --------------->'  
            }
        }
    }
      
    }
}