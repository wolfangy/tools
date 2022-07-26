# LogStash Preparation

## Installation

```bash
sudo apt install openjdk-8-jre-headless

sudo apt-get update

sudo apt-get install logstash
```

## configuration sample

```conf
input {
  file {
    path => "/home/stduent/access_log"
    start_position => "beginning"
  }
}

filter {
  grok {
    match => {"message" => "%{COMBINEDAPACHELOG}" }
  }
  date {
    match => ["timestamp", "dd/MMM/yyyy:HH:mm:ss Z"]
  }
}

output {
  elasticsearch {
    hosts => ["localhost:9200"]
  }
  stdout {
    codec => rubydebug
  }
}
```
