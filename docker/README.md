
Instalação da Hyper-V
```
DISM /Online /Enable-Feature /All /FeatureName:Microsoft-Hyper-V

New-VM -Name Testmachine -path C:\vm-machine --MemoryStartupBytes 512MB
New-VMSwitch -name RedeMaquinaVirtual  -NetAdapterName NomePlacaRede -AllowManagementOS $true
New-VM -Name Win10VM -MemoryStartupBytes 4GB -BootDevice VHD -VHDPath .\VMs\Win10.vhdx -Path .\VMData -Generation 2 -Switch ExternalSwitch
New-VHD -Path c:\vm-Machine\Testmahcine\Testmachine.vhdx -SizeBytes 10GB -Dynamic
Add-VMHardDiskDrive -VMName TestMachine -path "C:\vm-machine\Testmachine\Testmachine.vhdx"
Set-VMDvdDrive -VMName -ControllerNumber 1 -Path 'c:\minha.iso'
Start-VM -Name
Get-VM
```

Desintalação do docker, para reinstalação futura
```cmd
"C:\Program Files\Docker\Docker\Docker Desktop Installer.exe" uninstall
```

Preparação para instalação do Postgresql no Windows 10 via docker desktop
```cmd
netsh advfirewall firewall add rule name="Postgres Splitgraph TCP" protocol=TCP dir=in localport=5433 action=allow
netsh advfirewall firewall add rule name="Postgres Splitgraph UDP" protocol=UDP dir=in localport=5433 action=allow

net localgroup docker-users dominio\usuario /add
```

```cmd
docker-machine.exe create --driver hyperv --hyperv-virtual-switch "myexternalswitch" --hyperv-cpu-count "1" --hyperv-memory "1024" --hyperv-disk-size "20000" mydockervm

MACHINE_IP="MACHINE IP"
MACHINE_NAME="MACHINE NAME"
SSH_USER="MACHINE USERNAME"
SSH_PUBLIC_KEY="MACHINE USERNAME PUBLIC KEY PATH"
# If you did an ssh-copy-id to the machine: ~/.ssh/id_rsa
docker-machine create --driver generic --generic-ip-address=${MACHINE_IP} --generic-ssh-key ${SSH_PUBLIC_KEY} --generic-ssh-user ${SSH_USER} ${MACHINE_NAME}

#docker run -p 5432:5432 --name yourContainerName -e POSTGRES_PASSWORD=yourPassword -d postgres

docker create -v /var/lib/postgresql/data --name PostgresData alpine
docker run -p 5432:5432 --name yourContainerName -e POSTGRES_PASSWORD=yourPassword -d --volumes-from PostgresData postgres
```
