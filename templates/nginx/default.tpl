server {
    listen 80 default_server;
    listen [::]:80 default_server;

    location / {
        return 301 https://{{HOST}};
    }
    location = / {
        deny all;
    }
}