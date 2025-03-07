# Use the official .NET image as a parent image
FROM mcr.microsoft.com/dotnet/aspnet:5.0 AS base
WORKDIR /app
EXPOSE 80

# Use the SDK image to build the application
FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /src

# Copy the .csproj and restore any dependencies (via dotnet restore)
#COPY Shopping/Shopping.API/Shopping.API.csproj Shopping.API/
COPY . .  
RUN dotnet restore "Shopping/Shopping.API/Shopping.API.csproj"
RUN dotnet build "Shopping/Shopping.API/Shopping.API.csproj" -c Release -o /app/build


# Publish the application
FROM build AS publish
RUN dotnet publish "Shopping/Shopping.API/Shopping.API.csproj" -c Release -o /app/publish

# Use the base image to run the application
FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "Shopping.API.dll"]