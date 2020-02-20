FROM ubuntu:16.04

MAINTAINER Keoni Gandall "koeng101@gmail.com"

RUN apt-get update -y 
RUN apt-get install -y software-properties-common && apt-get update
RUN add-apt-repository ppa:octave/stable
RUN apt-get update -y && \
    apt-get install -y python3.5 unzip python3-pip python3-dev git octave liboctave-dev

RUN git clone https://github.com/iGEM-Measurement-Tools/Excel_Process_Validator.git
RUN octave --no-gui --quiet --eval "pkg install -forge io"
RUN cd Excel_Process_Validator && git checkout develop && make install

COPY ./requirements.txt /app/requirements.txt

WORKDIR /app

RUN pip3 install -r requirements.txt

COPY . /app

ENTRYPOINT [ "python3" ]

CMD [ "app.py" ]

