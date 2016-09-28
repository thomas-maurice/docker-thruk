# docker-thruk
A Docker image for the Shinken interface Thruk

## Build it
```
docker build -t thruk .
```

## Run it
```
$ docker run -e LIVESTATUS_CONN=localhost:50000 \ # Livestatus connection used to speak with shinken
             -e LOGCACHE_CONN=mysql://root:password@localhost:3306/thruk \ # Database connection to store the event log
             -e PORT=80 \ # Port on which the UI is accessible
             -it thruk
```

## Contributing
I'd gladly accept pull requests !
