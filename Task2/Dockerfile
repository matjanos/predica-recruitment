FROM mcr.microsoft.com/dotnet/core/aspnet:2.1
WORKDIR /app
COPY ./bin/Release/netcoreapp2.1/publish .
ENV ASPNETCORE_ENVIRONMENT Production
EXPOSE 5001
EXPOSE 5000
ENTRYPOINT dotnet Task2.dll