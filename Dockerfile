FROM maven as build

WORKDIR /app

COPY . .

RUN mvn clean package -Dskiptests

FROM amazoncorretto:22-al2023 as deploy

WORKDIR /app

ENV DATABASE_URL=jdbc:postgresql://cats-db-clswk:5432/cats_db_clswk
ENV SERVER_PORT=8080

COPY --from=build /app/target/*.jar app.jar

CMD ["java", "-jar","app.jar"]