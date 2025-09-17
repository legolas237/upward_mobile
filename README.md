# Upward. (Mobile TODO APP for Onboarding dev mobile flutter 2025)

* [Description](#description)
* [Installation](#installation)
* [Architecture](#architecture)
* [Difficultés & Solutions](#difficultés)
* [Démo](#demo)

<a name="description"></a>
## 1. Description
Upward est une application mobile de gestion de tâches (TODO) qui
a été conçue comme un projet d'intégration, nous permettant de mettre
en pratique mes compétences de développeur mobile Flutter.

### 1.1 Fonctionnalités
- Gestion basique des tâches (CRUD):
    - `Affichage de la liste des tâches`
    - `Création`
    - `Modification`
    - `Suppréssion`
    - `Modification du statut`
- Bonus :
    - `Tâche illustrée(avec des images ...)`
    - `Recherche de tâche par date`
    - `Note vocale`
    - `Tâche accompagnée de checklist`
    - `Internationalisation (Français, English)`
    - `Light et Dark mode `

### 1.2 Structure du projet
Conformément aux recommandations d'architecture, le projet
est organisé de manière logique. Les écrans (identifiés par `xxx_screen.dart`) ont été
regroupés, les widgets sont `modulaires et réutilisables`, et une séparation des couches a été mise en place
pour optimiser la lisibilité et la maintenance du code.

La structure du projet est détaillée ci-dessous
lib.
+---app<br />
+---l10n<br />
+---models<br />
+---repositories<br />
+---routes<br />
+---screens<br />
+---services<br />
+---theme<br />
+---utilities<br />
+---viewmodels<br />
¦   &nbsp;&nbsp;&nbsp;&nbsp; +---localization<br />
¦   &nbsp;&nbsp;&nbsp;&nbsp; +---onboarding<br />
¦   &nbsp;&nbsp;&nbsp;&nbsp; +---tasks<br />
¦   &nbsp;&nbsp;&nbsp;&nbsp; +---theme<br />
+---widgets<br />

<a name="installation"></a>
## 2. Installation
### 2.1 Pré-requis
- Environment: `^3.8.1`
- Dart: `SDK Version: 3.8.1`
- Flutter: `^3.32.4 • channel stable` • https://github.com/flutter/flutter.git
- Android studio/Vs Code pour Window or Mac et tous les autres outils et plugins nécessaire pour le développement avec le Framework Flutter • https://docs.flutter.dev/get-started/install
- Un émulateur ou un appareil mobile physique (Dans le cadre de ce projet, seuls les appareil Android sont supportés)

#### 2.2 Cloner ou télécharger le code
    Cloner: git clone https://github.com/legolas237/upward_mobile.git
    Ou télécharger: https://github.com/legolas237/upward_mobile/archive/refs/heads/main.zip
    cd upward_mobile
    git branch develop

#### 2.3 Installation des dépendances
    flutter pub get

#### 2.4 Exécution des tests
    flutter test

#### 2.5 Lancer l'application
    Connecter un appareil physique et lanceer l'application avec 
    flutter run 
    ou utiliser les outils de développement intégrés de l'IDE Android studio ou VsCode

#### Troubleshooting? view online docs : https://github.com/flutter/flutter.git

<a name="architecture"></a>
## 3. Choix techniques & architectures
Les choix techniques et l'architecture du projet ont été faits en se
basant sur notre expérience et les recommandations de l'équipe d'intégration.

### 1. Gestion des états (view model) avec les `Cubit` - https://bloclibrary.dev/fr/
`Cubit` est un outil de gestion d'état léger et plus simple
qui permet de séparer la logique métier de l'interface utilisateur (UI) en utilisant des méthodes
simples pour émettre de nouveaux états, plutôt que des événements ce qui en fait un choix évident dans le modèle d'architecture `MVVM (Model-View-ViewModel)`
pour la gestion d'état simplifiée, la séparation des préoccupations et la prévisibilité du flux de données.

- <span style="color: #99c3ff;">Gestion simplifiée des états</span>:
  Cubit utilise une approche plus directe pour la gestion d'état en exposant simplement une liste d'états.
  Cubit expose des méthodes directement. Cela le rend plus simple à comprendre et à mettre
  en œuvre, particulièrement pour les cas d'utilisation où la logique est moins complexe ce qui est le cas pour notre application de TODO List.

- <span style="color: #99c3ff;">Séparation des Préoccupations </span>:
  Cubit favorise une séparation claire des préoccupations, ce qui est l'un des principes fondamentaux du modèle MVVM. Il agit comme le ViewModel :
    * <strong>View (Widgets)</strong> : Les widgets Flutter (l'interface utilisateur) ne font que consommer les états et afficher les informations. Ils ne contiennent aucune logique métier.
    * <strong>ViewModel (Cubit)</strong> : Couplé avec les `repositories` et `services` Cubit gère la logique métier de l'application. Il prend en charge les appels réseau dans notre cas l'extraction de données de la base de données locale, la manipulation de données, et met à jour l'état en conséquence.
    * <strong>Model (Classes de données)</strong> : Le modèle représente les données brutes. Les classes de données (ex. Task, TaskAttachment etc ..) sont utilisées par le Cubit pour gérer l'état de manière structurée.

- <span style="color: #99c3ff;">Prévisibilité du flux de données </span>:
  Le flux de données avec Cubit est unidirectionnel et prévisible.
    * La vue envoie des commandes au Cubit (via l'appel de méthodes).
    * Le Cubit exécute la logique métier et émet un nouvel état.
    * La vue réagit à ce nouvel état en se reconstruisant pour afficher les données mises à jour.

### 2. Injection de dépendance - https://docs.flutter.dev/app-architecture/case-study/dependency-injection
L'utilisation de `BlocProvider` et `BlocBuilder` permet d'injecter le Cubit dans l'arbre des widgets et de
reconstruire uniquement la partie de l'interface qui a besoin de l'être,
optimisant ainsi les performances.

### 3. Persistence de données (base de données locale) `hive` https://pub.dev/packages/hive
Hive est le choix idéal pour nous car c'est une base de données clé-valeur NoSQL rapide et légère,
spécialement conçue pour les applications Flutter et Dart.
Elle offre un moyen simple et efficace de stocker et de récupérer des données localement sur l'appareil de l'utilisateur.
En outre, vu la simplicité de la couche de données nous avons supprimer la couche service en ne concervant que la couche `repository`

### 4. Sérialisation et Dé-sérialisation `hive_generator, build_runner`
Utiliser Hive avec les annotations `(@HiveType et @HiveField)` et le package `hive_generator` permet une sérialisation et désérialisation
automatique des objets Dart. Ce processus génère des fichiers (.g.dart) contenant les `TypeAdapters` nécessaires, qui sont les interfaces utilisées par
Hive pour la persistance locale des données.

### 5. Navigation `Interface Navigator de flutter`
Par expérience, nous avons choisi d'utiliser la navigation native de Flutter pour
passer d'un écran à l'autre. Cette approche offre une plus grande flexibilité et de meilleures performances par rapport aux solutions tierces.

### 6. Tests unitaires, tests de widgets `test, mockito,`
Les tests unitaires fondamentaux ont été mis en œuvre pour valider les opérations CRUD (Création, Lecture, Mise à jour, Suppression)
des tâches, ainsi que pour les méthodes utilitaires. Après les tests unitaires, des tests de widgets ont été réalisés pour s'assurer que les composants
de l'interface utilisateur s'affichent correctement et interagissent comme attendu, garantissant une bonne expérience utilisateur.

<a name="difficultés"></a>
## 4. Difficultés & Solutions
- La principale difficulté rencontrée a été la gestion des tests de composants (widgets), une tâche qui s'avére toujours chronophage. Compte tenu du temps
  alloué pour la réalisation du projet, nous avons pu couvrir cette partie de manière partielle.
- Suite à nos expérimentations, nous avons choisi de ne pas utiliser les packages `build_value` ou `freezed`. Bien qu'ils soient efficaces
  pour la sérialisation, leur complexité, notamment dans les fichiers `.g.dart` générés, ne correspondait pas à nos besoins. Notre objectif était de maintenir
  des fichiers de code généré simples et basiques. Nous avons donc opté pour `hive_annotation` et `build_runner` pour résoudre ce problème, car cette approche nous a permis
  de conserver des fichiers de sérialisation plus faciles à lire et à gérer.

<a name="demo"></a>
## 4. Démo vidéo
- https://youtu.be/VK3cQGQbMNA

<br />
<br />
