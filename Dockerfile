# This file creates a container that contains chef-client and berkshelf
#
# Author: Paul Czarkowski
# Date: 08/04/2013


FROM paulczar/docker-chef-client
MAINTAINER Paul Czarkowski "paul@paulcz.net"

ADD ezbake /usr/bin/ezbake

RUN chmod +x /usr/bin/ezbake

CMD ["/usr/bin/ezbake"]
