FROM --platform=$BUILDPLATFORM mcr.microsoft.com/dotnet/sdk:9.0-alpine AS build
WORKDIR /WebApi

COPY . .
RUN dotnet publish -c Release -o out

FROM --platform=$BUILDPLATFORM mcr.microsoft.com/dotnet/aspnet:9.0-alpine AS final

WORKDIR /WebApi
COPY --from=build /WebApi/out .

ENV ASPNETCORE_URLS=http://+:8080
EXPOSE 8080

ENTRYPOINT ["dotnet", "CourseManagementWebApi.dll"]
