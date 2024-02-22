# Use the .NET SDK image as a base image
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build

# Set the working directory in the container
WORKDIR /app

# Copy the project files to the working directory
COPY . ./

# Restore dependencies and build the application
RUN dotnet restore
RUN dotnet build -c Release --no-restore

# Publish the application
RUN dotnet publish -c Release -o out

# Use the ASP.NET Core runtime image as a base image for the final image
FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS runtime

# Set the working directory in the container
WORKDIR /app

# Copy the published application to the container
COPY --from=build /app/out ./

# Expose the port that the application will listen on
EXPOSE 80

# Define the entry point for the container
ENTRYPOINT ["dotnet", "my-dotnet-app.dll"]
