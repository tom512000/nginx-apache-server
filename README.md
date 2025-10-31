# Serveurs Apache & Nginx sous Docker

### Environnement Docker de serveurs Apache & Nginx – Sites HTTP, HTTPS et Authentification

Ce projet met en place un environnement complet sous Docker Compose permettant de tester la configuration et la sécurisation de serveurs Apache et Nginx, incluant :
- 🧩 Hébergement de plusieurs sites virtuels (site1.local, site2.local)
- 🔐 Authentification HTTP Basic (sur site2.local)
- 🔒 HTTPS avec certificats auto-signés
- 🛡️ Sécurisation des en-têtes HTTP (OWASP)
- 🧱 Architecture 100 % automatisée (aucune commande manuelle dans les conteneurs)
- 🔄 Reverse Proxy et mise en cache des contenus

Les deux serveurs (**Apache et Nginx**) disposent chacun d’une page d’accueil principale (index.html) listant les différents sites et leurs versions **HTTP/HTTPS**.

## ⚙️ Structure du projet
```text
projet-serveurs/
├── docker-compose.yml
├── init/
│   ├── setup_apache.sh
│   ├── setup_nginx.sh
│   ├── generate_certs.sh
│   └── shared_htpasswd
│
├── apache/
│   ├── conf/          # Fichiers VirtualHost Apache
│   ├── sites/         # Contenu des sites + page principale
│   └── ssl/           # Certificats auto-signés
│
└── nginx/
    ├── conf/          # Fichiers server block Nginx
    ├── sites/         # Contenu des sites + page principale
    └── ssl/           # Certificats auto-signés
```

## 🚀 Démarrage rapide
### 1️⃣ Prérequis
- [Docker Desktop](https://www.docker.com/products/docker-desktop/)
- [Git](https://git-scm.com/install/) (facultatif)
- Windows, macOS ou Linux

### 2️⃣ Cloner ou copier le projet
```bash
git clone https://github.com/tom512000/nginx-apache-server.git
cd nginx-apache-server
```

### 3️⃣ Ajouter les entrées locales dans ton fichier `hosts`
- Sous Windows :
```bash
C:\Windows\System32\drivers\etc\hosts
# puis ajoute :
127.0.0.1 site1.local
127.0.0.1 site2.local
```

- Sous Linux / macOS :
```bash
sudo nano /etc/hosts
# puis ajoute :
127.0.0.1 site1.local
127.0.0.1 site2.local
```

### 4️⃣ Lancer les conteneurs
```bash
docker-compose up -d --build
```

### 5️⃣ Arrêter les conteneurs (facultatif)
```bash
docker-compose down -v
```

## 🌍 Accès aux sites
### 🔹 Serveur Nginx
| Type | URL | Détails |
|------|-----|---------|
| Accueil | http://localhost:90 | Liste des sites |
| Site 1 (HTTP) | http://site1.local:90 | Page publique (Reverse Proxy + Cache) |
| Site 2 (HTTP → HTTPS) | http://site2.local:90 | Redirection vers HTTPS |
| Site 2 (HTTPS sécurisé) | https://site2.local:446 | Auth (user1 / password123) + SSL auto-signé + Compression |

### 🔹 Serveur Apache
| Type | URL | Détails |
|------|-----|---------|
| Accueil | http://localhost:91 | Liste des sites |
| Site 1 (HTTP) | http://site1.local:91 | Page publique (Reverse Proxy + Cache) |
| Site 2 (HTTP → HTTPS) | http://site2.local:91 | Redirection vers HTTPS |
| Site 2 (HTTPS sécurisé) | https://site2.local:444 | Auth (user1 / password123) + SSL auto-signé + Compression |

> ⚠️ Accepte les certificats auto-signés dans ton navigateur si besoin pour accéder aux sites HTTPS.

## 🔑 Identifiants d’accès
| Utilisateur | Mot de passe | Fichier utilisé |
|------|-----|---------|
| user1 | password123 | `.htpasswd` dans `/apache` et `/nginx` |
