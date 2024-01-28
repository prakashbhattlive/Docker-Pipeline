def ContainerName="docker-pipeline"
def tag="latest"
def dockerHubUser="prakashbhatt"
def httpPort="8090"

node {

   stage('Checkout') {
      checkout scm
   }
   stage('Build') {
     sh "mvn clean install"
   }

   stage('Image Prune') {
     sh "docker image prune -f"
   }

   stage('Image Build') {
     sh "docker build -t $ContainerName:$tag -t $ContainerName --pull --no-cache ."
     echo "Image build complete"
   }

   stage('Push to Docker Registry') {
     withCredentails([usernamePassword(credentialsID: 'DockerCred', usernameVariable: 'dockerUser', passwordVariable: 'dockerPassword')]) {
     sh "docker login -u  $dockerUser -p $dockerPassword"
     sh "docker tag   $ContainerName:$tag $dockerUser/$ContainerName:$tag"
     sh "docker push  $dockerUser/$ContainerName:$tag"
     echo "Image Push Complete"
     }
   }

   stage('Run App') {
     sh "dokcer rm $ContainerName -f"
     sh "docker pull $dockerUser/$ContainerName"
     sh "docker run -d --rm -p $httpPort:$httpPort --name  $ContainerName $dockerUser/$ContainerName:$tag"
     echo "Application started on port : ${httpPort} (http)"
   }
  
   }
