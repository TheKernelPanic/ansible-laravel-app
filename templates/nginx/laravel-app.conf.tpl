server {
    listen 80;
    listen [::]:80;
    server_name {{HOST}};
    root /var/www/{{DIRNAME}}/public;

    index index.php;

    access_log /var/log/nginx/{{HOST}}-access.log;
    error_log /var/log/nginx/{{HOST}}-error.log error;

    if ($scheme = http) {
        return 301 https://$host$request_uri;
    }

    if ($http_user_agent ~* (DataForSeoBot|SemrushBot)) {
        return 403;
    }

    location / {
        try_files $uri $uri/ @rewrites;
    }

    location @rewrites {
        rewrite ^ /index.php;
    }

    location ~ \.php$ {
        try_files $uri =404;
        fastcgi_pass unix:/run/php/php{{VERSION}}-fpm.sock;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        include fastcgi_params;
    }

    listen [::]:443 ssl;
    listen 443 ssl;
    ssl_certificate /etc/letsencrypt/live/{{HOST}}/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/{{HOST}}/privkey.pem;
    include /etc/letsencrypt/options-ssl-nginx.conf;
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem;
}