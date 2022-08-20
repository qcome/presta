# Installation

Test automatisation install prestashop

## Générer/lancer une app
<!---
 --1. Récupérer le fichier **init.sh** et l'exécuter :
 -->
```console
$ sh ./prestashop.sh {nom_app}
```

> **Note :** Si serveur **DigitalOcean**, peut être exécuté lors de l'initialisation d'une droplet en renseignant la partie [User data](https://www.digitalocean.com/docs/droplets/how-to/provide-user-data/#how-to-provide-user-data)

 2. Accéder à http://IPSERVEUR:8080/ pour config
 
 3. Config base de données:
 
```
adress: some-mysql
nom: prestashop
user: root
pwd: admin

```

Il faut git et ./ssh/id_rsa de set up

# TODO
 
 > To get the latest internationalization data upgrade the ICU system package and the intl PHP extension.
 > Docker Compose
