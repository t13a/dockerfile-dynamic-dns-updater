# Dynamic DNS Updater

A Dockerfile for [Dynamic DNS Updater](https://github.com/swyngaard/dynamic-dns-updater), a dynamic DNS Updater with [cPanel API 2](https://documentation.cpanel.net/display/SDK/Guide+to+cPanel+API+2).

## Getting Started

Run with environment variables:

```sh
$ docker run --rm \
-e USERNAME=username \
-e PASSWORD=password \
-e DOMAIN=domain.tld \
-e SUB_DOMAIN='sub1 sub2' \
-e CPANEL_URL=https://cpanel:2087/ \
t13a/dynamic-dns-updater
```

or run with volume:

```sh
$ docker run --rm \
-v $(pwd)/params:/params:ro \
t13a/dynamic-dns-updater
```
