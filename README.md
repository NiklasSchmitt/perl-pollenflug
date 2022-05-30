# Pollenflug!
this is a website shows the current Pollenbelastung in the air.

data provided by DWD https://www.dwd.de/DE/leistungen/gefahrenindizespollen/gefahrenindexpollen.html#buehneTop

images provided by https://github.com/leahoswald/lovelace-dwd-pollenprognose-card

# deployment
there are two ways how this application can get deployed with help of Docker:
## option 1: app & apache in the same container
use the Dockerfile in the root-folder and build pollenflug

`docker build -t pollenflug .`

`docker run --name pollenflug --hostname pollenflug -d -it pollenflug:latest`


## option 2: app container & apache container
build the app:

`docker build -t pollenflug .`

`docker run --name pollenflug-app --hostname pollenflug-app -d -it pollenflug:latest`

build apache server with help of the Dockerfile located in /apache:

`cd apache && docker build -t pollenflug-apache .`

`docker run --link pollenflug-app:pollenflug-app --hostname pollenflug-apache --name pollenflug-apache -d -it pollenflug-apache:latest`
