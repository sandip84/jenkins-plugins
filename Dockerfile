FROM jenkins/jenkins:lts-jdk21

# Copy the plugin list into the image
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt

# Tell the CLI to install from that file
RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugins.txt