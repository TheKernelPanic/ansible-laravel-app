# Ansible - Provisioner for laravel app

## Docker environment

```batch
docker run -dit --name "ansible-laravel-blog" -v "%cd%:/usr/share/workdir" --workdir "/usr/share/workdir" ubuntu:20.04
```

Ansible user permissions:
```
ansible ALL=(ALL) NOPASSWD: ALL
```

Install ansible:
```bash
apt update 
apt install ansible -y
```

Copy rsa key
```bash
mkdir /root/.ssh
cp /usr/share/workdir/rsa/id_rsa /root/.ssh/id_rsa
chmod -R 600 /root/.ssh
```

or generate with and authorized in remote server
```bash
ssh-keygen
```

## Ansible command execution

```bash
ansible-playbook playbook-production.yaml -i hosts -u ansible
```

## Additional configuration

Certbot (letsencrypt)
```bash
sudo certbot register --email "[EMAIL]" --non-interactive --agree-tos
sudo certbot --nginx -d [DOMAIN] --no-redirect --noninteractive
```

MySQL root password

```bash
sudo mysql -u root -p
```
```sql
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password';
FLUSH PRIVILEGES;
```

Create database
```sql
CREATE DATABASE [DB_NAME] CHARACTER SET utf8 COLLATE utf8_general_ci;
```

Create user
```sql
CREATE USER '[DB_USER]'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON [DB_NAME].* TO '[DB_USER]'@'localhost';
FLUSH PRIVILEGES;
```