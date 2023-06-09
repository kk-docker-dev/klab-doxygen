# Doxygen server in docker

- Run `build.sh` to create docker image
- Run `run.sh` to start the doxygen server
- Explore the documentaion at http://localhost:9596
- Run `kill.sh` to delete the container

# Build doxygen documentaion for your projects

1. Copy the projects repository to the shared folder. By default it is `$HOME/Public`.<br>
	`cp -rvf <project-source-repo> $HOME/Public`

2. Run `run.sh` to login to the doxygen server console. The copied projects are available at `/host` directory.

3. Run `mkdox` command in the project root directory to build the doxygen documentation.<br>
   Enter the prompt input values and note the URL to explore the documentation.

4. Explore the project at http://localhost:9596/project-name

### Manage Docker image

**Build and push AMD64 image**

	sudo docker build -t kribakarans/doxygen:amd64 .
	sudo docker push kribakarans/doxygen:amd64

**Build and push ARM64 image**

	sudo docker build -t kribakarans/doxygen:arm64 .
	sudo docker push kribakarans/doxygen:arm64

**Create and push manifest**

	sudo docker manifest rm kribakarans/doxygen:latest
	sudo docker manifest create kribakarans/doxygen:latest kribakarans/doxygen:amd64 kribakarans/doxygen:arm64
	sudo docker manifest push kribakarans/doxygen:latest
