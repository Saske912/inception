FROM debian:buster
RUN apt-get -y update && apt-get install -y wget gnupg gnupg2 lsb-release sudo procps && \
wget -qO- https://repos.influxdata.com/influxdb.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/influxdb.gpg > /dev/null && \
echo "deb [signed-by=/etc/apt/trusted.gpg.d/influxdb.gpg] https://repos.influxdata.com/debian buster stable" | \
sudo tee /etc/apt/sources.list.d/influxdb.list > /dev/null && \
sudo apt-get -y update && sudo apt-get -y install influxdb2
ADD conf/start.sh .
RUN chmod +x start.sh
EXPOSE 8086
CMD /bin/sh start.sh
#RUN apt-get -y update && apt-get install -y influxdb
#CMD influxd
RUN #apt-get -y update && apt-get install -y python-pip
RUN #pip install influxdb requests