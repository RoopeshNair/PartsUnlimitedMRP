while [[ ${1} ]]
do

case "${1}" in
	-a|--storage-account)
	STORAGEACCOUNT="$2"
	shift # past argument
	;;
	-k|--storage-key)
	STORAGEKEY="$2"
	shift # past argument
	;;
	-d|--drop-folder)
	DROPFOLDER="$2"
	shift # past argument
	;;
	-s|--sources-folder)
	SOURCESFOLDER="$2"
	shift # past argument
	;;
	-c|--container)
	CONTAINER="$2"
	shift # past argument
	;;
	-p|--tomcatpwd)
	TOMPWD="$2"
	shift # past argument
	;;
	-m|--virtual-machine)
	VIRTUALMACHINE="$2"
	shift # past argument
	;;
	*)
			#unknown option
	;;
esac
shift #past argument or value
done



echo STORAGE ACCOUNT		= "${STORAGEACCOUNT}"
echo STORAGE KEY		= "${STORAGEKEY}"
echo CONTAINER			= "${CONTAINER}"
echo DROP FOLDER		= "${DROPFOLDER}"
echo SOURCES FOLDER		= "${SOURCESFOLDER}"
echo VIRTUAL MACHINE		= "${VIRTUALMACHINE}"
#echo PWD		= "${TOMPWD}"

# Delete previous blobs Usage: storage blob delete [options] [container] [blob]
#azure storage blob delete -q -a "${STORAGEACCOUNT}" -k "${STORAGEKEY}" "${CONTAINER}" "integration-service-0.1.0.jar"
#azure storage blob delete -q -a "${STORAGEACCOUNT}" -k "${STORAGEKEY}" "${CONTAINER}" "ordering-service-0.1.0.jar"
#azure storage blob delete -q -a "${STORAGEACCOUNT}" -k "${STORAGEKEY}" "${CONTAINER}" "mrp.war"
#azure storage blob delete -q -a "${STORAGEACCOUNT}" -k "${STORAGEKEY}" "${CONTAINER}" "MongoRecords.js"
#azure storage blob delete -q -a "${STORAGEACCOUNT}" -k "${STORAGEKEY}" "${CONTAINER}" "Install-MRP-app.sh"
#echo "Deleted prior artifact version from " "${CONTAINER}"

# Upload necessary files to blob storage
#azure storage blob upload -q -a "${STORAGEACCOUNT}" -k "${STORAGEKEY}" "${DROPFOLDER}/drop/Backend/IntegrationService/build/libs/integration-service-0.1.0.jar" "${CONTAINER}"
#azure storage blob upload -q -a "${STORAGEACCOUNT}" -k "${STORAGEKEY}" "${DROPFOLDER}/drop/Backend/OrderService/build/libs/ordering-service-0.1.0.jar" "${CONTAINER}"
#azure storage blob upload -q -a "${STORAGEACCOUNT}" -k "${STORAGEKEY}" "${DROPFOLDER}/drop/Clients/build/libs/mrp.war" "${CONTAINER}"
#azure storage blob upload -q -a "${STORAGEACCOUNT}" -k "${STORAGEKEY}" "${SOURCESFOLDER}/deploy/MongoRecords.js" "${CONTAINER}"
#azure storage blob upload -q -a "${STORAGEACCOUNT}" -k "${STORAGEKEY}" "${SOURCESFOLDER}/deploy/Install-MRP-app.sh" "${CONTAINER}"

# Use CustomScriptForLinux extension to deploy the app on VM
SCRIPTURI="https://$STORAGEACCOUNT.blob.core.windows.net/$CONTAINER/Install-MRP-app.sh"
echo SCRIPT URI 		= "${SCRIPTURI}"
azure vm extension set -u "${VIRTUALMACHINE}" CustomScriptForLinux Microsoft.OSTCExtensions 1.*

# azure vm extension set -v "${VIRTUALMACHINE}" CustomScriptForLinux Microsoft.OSTCExtensions 1.* -i '{"fileUris":["'$SCRIPTURI'"], "commandToExecute": "sudo bash 'Install-MRP-app.sh' -a '${STORAGEACCOUNT}' -c '${CONTAINER}'"}'


 azure vm extension set -v "${VIRTUALMACHINE}" CustomScriptForLinux Microsoft.OSTCExtensions 1.* -i '{"fileUris":["'$SCRIPTURI'"], "commandToExecute": "sudo bash 'Install-MRP-app.sh' -a '${STORAGEACCOUNT}' -c '${CONTAINER}'", "timestamp":123456789}'


 #curl -T "${DROPFOLDER}/drop/Clients/build/libs/mrp.war" "http://pumrpvm1.cloudapp.net:9080/manager/text/deploy?path=/mrp&update=true" -u tomcat:${TOMPWD}
