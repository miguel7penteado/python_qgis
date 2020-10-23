
Preparação para instalação do Postgresql no Windows 10 via docker desktop
```
netsh advfirewall firewall add rule name="Postgres Splitgraph TCP" protocol=TCP dir=in localport=5433 action=allow
netsh advfirewall firewall add rule name="Postgres Splitgraph UDP" protocol=UDP dir=in localport=5433 action=allow

net localgroup docker-users dominio\usuario /add
```
