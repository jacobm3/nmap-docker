# Start from the latest Fedora image
# Using Fedora because Nmap.org doesn't publish Debian packages.
FROM fedora:latest

# Install necessary tools
RUN dnf install -y curl python3.10

# Fetch the latest Nmap rpm URL and store it into a variable
RUN export OBJ_URL=$(curl -s https://nmap.org/dist/ | grep -oP 'href="nmap-.*?.x86_64.rpm"' | head -n 1 | awk -F'"' '{print "https://nmap.org/dist/"$2}') && curl -O $OBJ_URL
RUN export OBJ_URL=$(curl -s https://nmap.org/dist/ | grep -oP 'href="nping-.*?.x86_64.rpm"' | head -n 1 | awk -F'"' '{print "https://nmap.org/dist/"$2}') && curl -O $OBJ_URL
RUN export OBJ_URL=$(curl -s https://nmap.org/dist/ | grep -oP 'href="ncat-.*?.x86_64.rpm"' | head -n 1 | awk -F'"' '{print "https://nmap.org/dist/"$2}') && curl -O $OBJ_URL
RUN dnf -y install nmap-*.rpm nping-*.rpm ncat-*.rpm

# Cleanup
RUN rm -f nmap-*.rpm nping-*.rpm ncat-*.rpm && dnf clean all

# Default command
CMD ["nmap", "--version"]
