FROM curlimages/curl:7.81.0 AS download
ARG OTEL_AGENT_VERSION="1.33.5"
RUN curl --silent --fail -L "https://github.com/open-telemetry/opentelemetry-java-instrumentation/releases/download/v${OTEL_AGENT_VERSION}/opentelemetry-javaagent.jar" \
  -o "$HOME/opentelemetry-javaagent.jar"

FROM maven:eclipse-temurin AS build
COPY . /build
RUN cd /build && mvn package --quiet

FROM eclipse-temurin:17
# Healthcheck is done by Kubernetes probes
HEALTHCHECK NONE




EXPOSE 5000

ADD https://repo1.maven.org/maven2/io/pyroscope/otel/0.10.1.11/otel-0.10.1.11.jar pyroscope-otel.jar

ENV PYROSCOPE_APPLICATION_NAME=my-app
ENV PYROSCOPE_FORMAT=jfr
ENV PYROSCOPE_PROFILING_INTERVAL=10ms
ENV PYROSCOPE_PROFILER_EVENT=itimer
ENV PYROSCOPE_PROFILER_LOCK=10ms
ENV PYROSCOPE_PROFILER_ALLOC=512k
ENV PYROSCOPE_UPLOAD_INTERVAL=15s
ENV OTEL_JAVAAGENT_EXTENSIONS=./pyroscope-otel.jar
ENV OTEL_PYROSCOPE_ADD_PROFILE_URL=false
ENV OTEL_PYROSCOPE_ADD_PROFILE_BASELINE_URL=false
ENV OTEL_PYROSCOPE_START_PROFILING=true

## Useful for debugging
# ENV PYROSCOPE_LOG_LEVEL=debug

## Those environment variables need to be overwritten at runtime, if you are using Grafana Cloud
ENV PYROSCOPE_SERVER_ADDRESS=http://pyroscope.pyroscope:4040
# ENV PYROSCOPE_BASIC_AUTH_USER=123     ## Grafana Cloud Username
# ENV PYROSCOPE_BASIC_AUTH_PASSWORD=glc_secret ## Grafana Cloud Password / API Token

## Add the pyroscope and the opentelemetry java-agents

COPY --from=build /build/target/*.jar /app.jar
COPY --from=download /home/curl_user/opentelemetry-javaagent.jar /opentelemetry-javaagent.jar
ENTRYPOINT ["java", \
  "-Dserver.port=5000",\ 
  "-javaagent:/opentelemetry-javaagent.jar", \
  "-jar", "/app.jar" \
  ]

