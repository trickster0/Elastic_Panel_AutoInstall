apt update
apt-get install curl apt-transport-https -y
curl -s https://artifacts.elastic.co/GPG-KEY-elasticsearch | apt-key add -

echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | tee /etc/apt/sources.list.d/elastic-7.x.list

apt-get update

apt-get install elasticsearch -y

rm /etc/elasticsearch/elasticsearch.yml
cp elasticsearch.yml /etc/elasticsearch/elasticsearch.yml
/bin/systemctl enable elasticsearch.service
apt-get install kibana -y
rm /etc/kibana/kibana.yml
cp kibana.yml /etc/kibana/kibana.yml
/bin/systemctl enable kibana.service
cp instances.yml /usr/share/elasticsearch/instances.yml




/usr/share/elasticsearch/bin/elasticsearch-certutil cert ca --pem --in /usr/share/elasticsearch/instances.yml --out certs.zip

apt-get install unzip -y

unzip /usr/share/elasticsearch/certs.zip -d /usr/share/elasticsearch/

mkdir /etc/elasticsearch/certs/ca -p

cd /usr/share/elasticsearch/

cp ca/ca.crt /etc/elasticsearch/certs/ca

cp elasticsearch/elasticsearch.crt /etc/elasticsearch/certs

cp elasticsearch/elasticsearch.key /etc/elasticsearch/certs

chown -R elasticsearch: /etc/elasticsearch/certs

chmod -R 770 /etc/elasticsearch/certs

mkdir /etc/kibana/certs/ca -p

cp ca/ca.crt /etc/kibana/certs/ca

cp kibana/kibana.crt /etc/kibana/certs

cp kibana/kibana.key /etc/kibana/certs

chown -R kibana: /etc/kibana/certs

chmod -R 770 /etc/kibana/certs

/bin/systemctl start elasticsearch.service

/bin/systemctl start kibana.service

cp /usr/share/elasticsearch/certs.zip /home/elastic/
chown elastic /home/elastic/certs.zip


apt install unzip -y

unzip /home/elastic/certs.zip -d /usr/share/elasticsearch/

mkdir /etc/elasticsearch/certs/ca -p

cp /usr/share/elasticsearch/ca/ca.crt /etc/elasticsearch/certs/ca

cp /usr/share/elasticsearch/elasticsearch/elasticsearch.crt /etc/elasticsearch/certs

cp /usr/share/elasticsearch/elasticsearch/elasticsearch.key /etc/elasticsearch/certs

chown -R elasticsearch: /etc/elasticsearch/certs



echo y | /usr/share/elasticsearch/bin/elasticsearch-setup-passwords auto | tee -a /home/elastic/passwords.txt
export pass=$(cat /home/elastic/passwords.txt | grep "PASSWORD elastic" | cut -d " " -f 4)
sed -i "s/qlRBLpf5fxYdCKGzCmEY/$pass/g" /etc/kibana/kibana.yml
export pass=nothinghere

/bin/systemctl restart elasticsearch.service

/bin/systemctl restart kibana.service


mkdir /usr/local/share/ca-certificates/extra

cp /usr/share/elasticsearch/ca/ca.crt /usr/local/share/ca-certificates/extra/ca.crt

update-ca-certificates

apt-get install elastic-agent

#elastic-agent enroll -f --fleet-server-es=https://192.168.2.70:9200 --fleet-server-service-token=token-generated-from-your-fleet-here
#elastic-agent
