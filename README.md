# Simplepage

## Docker web app that show a welcome page and your ip

### How to use

* if you are using raspberry pi check cpu architecture using
`cat /proc/cpuinfo | grep model`
* on raspberry pi just run 
`docker run --platform=linux/arm/v7 -dp 80:80 your_repository/simplepage:latest`
* if `linux/arm/v7` is not working change it according to your architecture
* on classic pc `docker run -dp 80:80 your_repository/simplepage:latest`
* have fun!