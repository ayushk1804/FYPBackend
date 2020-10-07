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
#FROM openjdk:8 AS build
##FROM mvertes/alpine-mongo
##RUN apk add openjdk8
#
#
#RUN mkdir /appbuild
#COPY . /appbuild
#
#WORKDIR /appbuild
#
#RUN ./gradlew clean build
#
#FROM mvertes/alpine-mongo
#RUN apk add openjdk8-jre
##RUN ["chown", "-r" ,"/root/run.sh"]
##RUN ["chmod", "+x" ,"/root/run.sh"]
#ENV APPLICATION_USER 1033
#RUN adduser -D -g '' $APPLICATION_USER
#
#RUN mkdir /app
#RUN mkdir /app/resources
#RUN chown -R $APPLICATION_USER /app
#RUN chmod -R 777 /app
#
##USER $APPLICATION_USER
#
#COPY --from=build /appbuild/build/libs/demo*all.jar /app/demo.jar
#COPY --from=build /appbuild/resources/ /app/resources/
#
#
##COPY /appbuild/build/libs/demo*all.jar /app/demo.jar
##COPY /appbuild/resources/ /app/resources/
#
#WORKDIR /app
#
#CMD ["sh", "-c", "java -server -XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap -XX:InitialRAMFraction=2 -XX:MinRAMFraction=2 -XX:MaxRAMFraction=2 -XX:+UseG1GC -XX:MaxGCPauseMillis=100 -XX:+UseStringDeduplication -jar demo.jar"]
##CMD ["java -jar demo.jar"]
FROM alpine:edge

RUN apk add --no-cache mongodb

VOLUME /data/db
EXPOSE 27017 28017

COPY run.sh /root
ENTRYPOINT [ "/root/run.sh" ]
CMD [ "mongod", "--bind_ip", "0.0.0.0" ]