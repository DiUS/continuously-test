FROM ubuntu:saucy
MAINTAINER Kevin Littlejohn <kevin@littlejohn.id.au>

# Strange little bug in /tmp permissions
RUN chmod go+w,u+s /tmp

# Fix the locale
RUN localedef -c -i en_AU -f UTF-8 en_AU.UTF-8 || :

# RUN apt-get -yq update && apt-get -yq upgrade

# Requirements for RoR
# RUN apt-get -yq install ruby-dev
# RUN apt-get -yq install make
# RUN apt-get -yq install ruby2.0
# RUN apt-get -yq install libsqlite3-dev
# RUN apt-get -yq install nodejs
RUN apt-get -yq install git
# RUN gem install rails

# Add a hackday user
RUN adduser --disabled-password --gecos "" hackday; \
  echo "hackday ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
RUN mkdir -p /var/lib/hackday && chown hackday.hackday /var/lib/hackday
ENV HOME /home/hackday
USER hackday

# Add the project to the container
ADD . /opt/hackday
RUN sudo chown -R hackday.hackday /opt/hackday

# Set our base directory
WORKDIR /opt/hackday
RUN git -v

# EXPOSE 3000

# CMD ["rails", "s"]
