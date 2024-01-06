server {
    listen 80;
    server_name www.{{HOST}};

    return 301 $scheme://{{HOST}}$request_uri;
}