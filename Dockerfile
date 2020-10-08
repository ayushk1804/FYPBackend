
FROM ubuntu

RUN apt-get update
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get -y install tzdata
RUN echo "Asia/Kolkata" | tee /etc/timezone
RUN dpkg-reconfigure --frontend noninteractive tzdata
RUN apt-get install -y gnupg
RUN apt-get install -y wget
RUN apt-get install -y sudo
RUN apt-get install -y systemctl
RUN wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add -
RUN echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list
RUN apt-get update

#RUN apt install -y software-properties-common
#RUN apt install python3.8
#RUN apt-get install python
#RUN apt-get update
#RUN apt-get install openjdk-8-jre
#RUN apk add mongodb
#RUN apk add --no-cache python3
#VOLUME /data/db
#EXPOSE 27017 28017
#RUN apk add openjdk8-jre
RUN mkdir /app
COPY start.sh /app/
RUN chmod +x /app/start.sh
COPY ./build/libs/demo*all.jar /app/demo.jar
WORKDIR /app
ENTRYPOINT ["/app/start.sh"]
#CMD mongod --bind_ip 0.0.0.0 & java -server -XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap -XX:InitialRAMFraction=2 -XX:MinRAMFraction=2 -XX:MaxRAMFraction=2 -XX:+UseG1GC -XX:MaxGCPauseMillis=100 -XX:+UseStringDeduplication -jar demo.jar
#CMD java -server -XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap -XX:InitialRAMFraction=2 -XX:MinRAMFraction=2 -XX:MaxRAMFraction=2 -XX:+UseG1GC -XX:MaxGCPauseMillis=100 -XX:+UseStringDeduplication -jar demo.jar

#### We select the base image from. Locally available or from https://hub.docker.com/
###FROM openjdk:8-jre-alpine
###
#### We define the user we will use in this instance to prevent using root that even in a container, can be a security risk.
###ENV APPLICATION_USER ktor
###
#### Then we add the user, create the /app folder and give permissions to our user.
###RUN adduser -D -g '' $APPLICATION_USER
###RUN mkdir /app
###RUN chown -R $APPLICATION_USER /app
###
#### Marks this container to use the specified $APPLICATION_USER
###USER $APPLICATION_USER
###
#### We copy the FAT Jar we built into the /app folder and sets that folder as the working directory.
###COPY ./build/libs/my-application.jar /app/my-application.jar
###WORKDIR /app
###
#### We launch java to execute the jar, with good defaults intended for containers.
###CMD ["java", "-server", "-XX:+UnlockExperimentalVMOptions", "-XX:+UseCGroupMemoryLimitForHeap", "-XX:InitialRAMFraction=2", "-XX:MinRAMFraction=2", "-XX:MaxRAMFraction=2", "-XX:+UseG1GC", "-XX:MaxGCPauseMillis=100", "-XX:+UseStringDeduplication", "-jar", "my-application.jar"]

#ENV APPLICATION_USER 1033
#RUN adduser -D -g '' $APPLICATION_USER
#
##RUN chmod -R go+w /data/db
#
#
#
#
##RUN ["chmod","-R","go+w","/data/db"]
#
#
#
#

#
##ENV APPLICATION_USER 1033
#
#
#CMD [ "mongod", "--bind_ip", "0.0.0.0" ]
#RUN mongod --bind_ip 0.0.0.0

#RUN chown -R $APPLICATION_USER /app
#
#USER $APPLICATION_USER
##RUN chown $APPLICATION_USER:$APPLICATION_USER /data/db


#

#CMD ["sh", "-c", "java -server -XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap -XX:InitialRAMFraction=2 -XX:MinRAMFraction=2 -XX:MaxRAMFraction=2 -XX:+UseG1GC -XX:MaxGCPauseMillis=100 -XX:+UseStringDeduplication -jar demo.jar"]
#RUN java -server -XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap -XX:InitialRAMFraction=2 -XX:MinRAMFraction=2 -XX:MaxRAMFraction=2 -XX:+UseG1GC -XX:MaxGCPauseMillis=100 -XX:+UseStringDeduplication -jar demo.jar
#RUN mongod --bind_ip 0.0.0.0


#RUN mkdir /appbuild



#FROM openjdk:8 AS build
#FROM mvertes/alpine-mongo
#
#WORKDIR /appbuild
#
#RUN ./gradlew clean build
#
##FROM mvertes/alpine-mongo
##RUN apk add openjdk8-jre
##RUN ["chown", "-r" ,"/root/run.sh"]
##RUN ["chmod", "+x" ,"/root/run.sh"]

#
#RUN mkdir /app
#RUN mkdir /app/resources
#RUN chown -R $APPLICATION_USER /app
#RUN chmod -R 777 /app
#
##USER $APPLICATION_USER
#
#COPY --from /appbuild/build/libs/demo*all.jar /app/demo.jar
#COPY --from /appbuild/resources/ /app/resources/
#
#
##COPY /appbuild/build/libs/demo*all.jar /app/demo.jar
##COPY /appbuild/resources/ /app/resources/
#
#WORKDIR /app
#
#CMD ["sh", "-c", "java -server -XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap -XX:InitialRAMFraction=2 -XX:MinRAMFraction=2 -XX:MaxRAMFraction=2 -XX:+UseG1GC -XX:MaxGCPauseMillis=100 -XX:+UseStringDeduplication -jar demo.jar"]
##CMD ["java -jar demo.jar"]
##FROM alpine:3.9
#
###RUN apk add mongodb
#
##VOLUME /data/db
##EXPOSE 27017 28017
##
###COPY run.sh /root
###ENTRYPOINT [ "/root/run.sh" ]
##CMD [ "mongod", "--bind_ip", "0.0.0.0" ]