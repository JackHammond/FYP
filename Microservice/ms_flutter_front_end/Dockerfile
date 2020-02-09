FROM debian:latest AS build-env

# Install flutter dependencies
RUN apt-get update 
RUN apt-get install -y curl git wget unzip libgconf-2-4 gdb libstdc++6 libglu1-mesa fonts-droid-fallback lib32stdc++6 python3
RUN apt-get clean

# Clone the flutter repo
RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter

# Run flutter doctor and set path
RUN /usr/local/flutter/bin/flutter doctor -v
#ENV PATH="usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:$"

ENV PATH="$PATH:/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin"


# Enable flutter web
RUN flutter channel master
RUN flutter upgrade
RUN flutter config --enable-web

# Copy files to container and build
RUN mkdir /usr/local/front_end
COPY . /usr/local/front_end
WORKDIR /usr/local/front_end
RUN /usr/local/flutter/bin/flutter build web

FROM nginx
COPY --from=build-env /usr/local/front_end/build/web /usr/share/nginx/html

