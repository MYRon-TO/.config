systemctl start v2ray.service v2raya.service
echo 'v2ray started'
sleep 1

# firefox localhost:2017
vivaldi --url http://localhost:2017
