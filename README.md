# UnoconvAPI
Unoconv as a webservice

Based on [tfk-api-unoconv container](https://github.com/zrrrzzt/tfk-api-unoconv)

## Docker

###Build image

```sh
$ docker build -t unoconv-api .
```

### Get image

```sh
$ docker pull imkulikov/unoconv-api
```

### Run image

```sh
$ docker run -d -p 80:3000 --name unoconv-api unoconv-api
```

## Usage

Post the file you want to convert to the server and get the converted file in return.

See all possible conversions on the [unoconv website](http://dag.wiee.rs/home-made/unoconv/).

API for the webservice is /unoconv/{format-to-convert-to} so a docx to pdf would be

```sh
$ curl --form file=@myfile.docx http://localhost/unoconv/pdf > myfile.pdf
```

### With unoconv filters
```sh
$ curl --form file=@myfile.docx --form 'filters=["Quality=100","Resolution=600","PageRange=1-1"]' http://localhost/unoconv/pdf > myfile.pdf
```

## Environment

You can change the webservice port and filesize-limit by changing environment variables.

SERVER_PORT default is 3000

PAYLOAD_MAX_SIZE default is 1048576000 (1000 MB)

You can change the environment variables in the run command.

```sh
$ docker run -e PAYLOAD_MAX_SIZE=2097152 -e SERVER_PORT=80 -d -p 80:80 --name unoconv-api unoconv-api
```