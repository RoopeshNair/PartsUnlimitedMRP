while [[ ${1} ]]
do

case "${1}" in
	-a|--storage-account)
	DropStorageAccountName="$2"
	shift # past argument
	;;
	-c|--container)
	DropContainerName="$2"
	shift # past argument
	;;
	*)
			#unknown option
	;;
esac
shift #past argument or value
done

# Kill java to stop current website
sudo pkill -9 'java'

# Remove old artifacts
sudo rm -f /var/lib/partsunlimited/MongoRecords.js*
sudo rm -f /var/lib/partsunlimited/mrp.war*
sudo rm -f /var/lib/partsunlimited/ordering-service-0.1.0.jar*

# Install packages
sudo apt-get update
sudo apt-get install openjdk-8-jdk -y
sudo apt-get install openjdk-8-jre -y
sudo apt-get install mongodb -y
sudo apt-get install tomcat7 -y
sudo apt-get install wget -y

# Set Java environment variables
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export PATH=$PATH:/usr/lib/jvm/java-8-openjdk-amd64/bin

# Configure the storage account and container name here
AzureResource="https://$DropStorageAccountName.blob.core.windows.net/$DropContainerName/"

# Download MongoRecords.js from Azure blog storage
sudo wget ${AzureResource}MongoRecords.js -P /var/lib/partsunlimited

# Wait for 10 seconds to make sure previous step is completed
sleep 10

# Add the records to ordering database on MongoDB
mongo ordering /var/lib/partsunlimited/MongoRecords.js

# Change Tomcat listening port from 8080 to 9080
sudo sed -i s/8080/9080/g /etc/tomcat7/server.xml

# Download the client WAR file
sudo wget ${AzureResource}mrp.war -P /var/lib/partsunlimited/

# Wait for 10 seconds to make sure previous step is completed
sleep 10

# Copy WAR file to Tomcat directory for auto-deployment
sudo /etc/init.d/tomcat7 stop

sleep 5

sudo rm -rf /var/lib/tomcat7/webapps/mrp*
sudo cp /var/lib/partsunlimited/mrp.war /var/lib/tomcat7/webapps

# Restart Tomcat
sudo /etc/init.d/tomcat7 restart

# Download the Ordering Service jar from Azure storage
sudo wget ${AzureResource}ordering-service-0.1.0.jar -P /var/lib/partsunlimited/

# Wait for 20 seconds to make sure previous step is completed
sleep 20

# Run Ordering Service app
sudo java -jar /var/lib/partsunlimited/ordering-service-0.1.0.jar &

echo "MRP application successfully deployed. Go to http://$HOSTNAME.cloudapp.net:9080/mrp"
