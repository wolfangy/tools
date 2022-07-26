# Elasticsearch Preparation

## Installation

Step 1:

`wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -`

Step 2:

`sudo apt-get install apt-transport-https`



Step 3 Install the elasticsearch 7.x:

`echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list`

Step 4:

`sudo apt-get update && sudo apt-get install elasticsearch`


## Configuration

GOTO:

`sudo vim /etc/elasticsearch/elasticsearch.yml`

```bash
node.name: node-1
...

network.host: 0.0.0.0
...

discovery.seed_hosts: ["127.0.0.1"]
...

cluster.initial_master_nodes: ["node-1"]
```

## Lauching

Step 1:

`sudo /bin/systemctl daemon-reload`

Step 2:

`sudo /bin/systemctl enable elasticsearch.service`

Step 3:

`sudo /bin/systemctl start elasticsearch.service`

## Testing

```bash
curl -XGET 127.0.0.1:9200
```

## Prepare tools

```bash
cd ~
mkdir bin
vim curj
#input following:
#!bin/bash
#/usr/bin/curl -H "Content-Type: application/json" "$@"
chmod a+x curj
cd ~
source .profile
```
