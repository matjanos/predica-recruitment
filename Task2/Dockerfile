FROM mcr.microsoft.com/dotnet/core/aspnet:2.1
WORKDIR /app
COPY ./bin/Release/netcoreapp2.1/publish .
ENV ASPNETCORE_ENVIRONMENT Production
EXPOSE 80
EXPOSE 443
ENTRYPOINT dotnet Task2.dll
