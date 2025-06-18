export http_proxy=http://localhost:20171
export https_proxy=$http_proxy
export ftp_proxy=$http_proxy
export rsync_proxy=$http_proxy
export no_proxy="localhost,127.0.0.1,localaddress,.localdomain.com"
export all_proxy="socks5://localhost:20170"

systemctl start v2ray.service v2raya.service
echo 'v2ray started'
sleep 1

# firefox localhost:2017
vivaldi --url http://localhost:2017
