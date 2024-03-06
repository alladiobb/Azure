#Criando Marquina Virtual
az vm create
--resource-group "learn-686f7a41-2cc9-4753-8d69-fd6abc65e1f3"
--name my-vm 
--public-ip-sku Standard 
--image Ubuntu2204 
--admin-username azureuser 
--generate-ssh-keys

#Configurando Nginx na VM
az vm extension set 
--resource-group "learn-686f7a41-2cc9-4753-8d69-fd6abc65e1f3"
--vm-name my-vm 
--name customScript 
--publisher Microsoft.Azure.Extensions 
--version 2.1 
--settings '{"fileUris":["https://raw.githubusercontent.com/MicrosoftDocs/mslearn-welcome-to-azure/master/configure-nginx.sh"]}' 
--protected-settings '{"commandToExecute": "./configure-nginx.sh"}'


#Verificar as VMs criadas
az vm list

az vm list-ip-addresses

#guadar resultado em uma variável Bash 
IPADDRESS= "$(az vm list-ip-addresses 
--resource-group "learn-686f7a41-2cc9-4753-8d69-fd6abc65e1f3"
--name my-vm 
--query "[].virtualMachine.network.publicIpAddresses[*].ipAddress"
--output tsv)"

#imprimindo o valor da variável
echo $IPADDRESS       

#baixando a home page
curl --connect-timeout 5 http://$IPADDRESS

#Listar os grupos de segurança de rede que estão associados a VM
az network nsg list 
--resource-group "learn-686f7a41-2cc9-4753-8d69-fd6abc65e1f3"
--query '[].name'
--output tsv

#Listar as regras associadas ao NSG
az network nsg rule list 
--resource-group "learn-686f7a41-2cc9-4753-8d69-fd6abc65e1f3"
--nsg-name my-vmNSG