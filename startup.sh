PATH=/bin:/usr/bin:/usr/local/bin:/opt/ntfy:/opt/push-watch
if [ ! -e /etc/ntfy/client.yml ]; then
	echo "NTFY client.yml is not present"
	sleep 30
	exit 1
fi
cd /opt/push-watch
case ${1} in
	login)
		push-watch login ${2} ${3}
		;;
	*)
		push-watch watch ${PUSHOVER_ID} ${PUSHOVER_SECRET} -- sh -c send-to-ntfy
		;;
esac
