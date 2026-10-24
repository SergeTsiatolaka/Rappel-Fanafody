# RAPPEL FANAFODY

Référentiel local des médicaments, 100 % hors connexion.

## Source médicale

La base embarquée est construite à partir du fichier `importer/src/main/resources/guideline-339-fr.pdf` fourni avec ce projet. Le PDF est la source de vérité. Aucune indication, posologie, présentation ou contre-indication n'est complétée à partir d'Internet ou d'une connaissance externe.

Le PDF fourni dans cette conversation indique **Janvier 2026** sur sa page de copyright et contient 678 pages. Il ne faut pas remplacer cette date par une autre date sans fournir une nouvelle source.

## Architecture

`Compose UI → ViewModel → UseCase → Repository → Room DAO → SQLite`

La base `app/src/main/assets/databases/rappel_fanafody.db` est préchargée dans l'APK avec `Room.databaseBuilder(...).createFromAsset(...)`.

## Ouvrir

1. Ouvrir le dossier dans Android Studio.
2. Utiliser un JDK 17.
3. Laisser Gradle synchroniser les dépendances.
4. Sélectionner la configuration `app`.

## Compiler

```bash
./gradlew assembleDebug
./gradlew assembleRelease
./gradlew bundleRelease
./gradlew test
./gradlew connectedCheck
```

APK debug : `app/build/outputs/apk/debug/app-debug.apk`

APK release : `app/build/outputs/apk/release/app-release.apk`

AAB : `app/build/outputs/bundle/release/app-release.aab`

Le script `gradlew` fourni utilise Gradle 9.6 et peut télécharger la distribution si aucun Gradle système n'est disponible. L'application elle-même n'a besoin d'aucune connexion réseau après installation.

## Rebuild de la base

Le PDF doit être placé comme :

`importer/src/main/resources/guideline-339-fr.pdf`

L'importeur JVM peut être lancé avec :

```bash
./gradlew :importer:run --args="importer/src/main/resources/guideline-339-fr.pdf /tmp/rappel_fanafody.db"
```

Il produit également un rapport `import-report.txt` à côté de la base.

Pour la version de référence livrée dans ce projet, la base a été générée à partir du PDF fourni et contrôlée pour ne conserver que les entrées vérifiables. Les renvois explicites « Voir » non résolus automatiquement sont conservés dans le rapport et ne sont pas transformés en données médicales inventées.

## Mise à jour du PDF

1. Remplacer `guideline-339-fr.pdf`.
2. Exécuter l'importeur.
3. Contrôler le rapport d'import.
4. Remplacer `app/src/main/assets/databases/rappel_fanafody.db` par la nouvelle base.
5. Lancer les tests.

Le parsing ne doit jamais ajouter une posologie ou une indication absente de la source.

## Signature

Pour un APK de production, créer une clé de signature privée et la stocker hors du dépôt. Configurer `signingConfigs.release` dans `app/build.gradle.kts` avec des variables d'environnement ou `gradle.properties` local non versionné. Ne jamais committer un mot de passe de clé.

## Play Store

Avant publication : vérifier l'identité de l'application, la politique de confidentialité, les captures d'écran, l'icône, la fiche Store, la signature Play App Signing et les exigences Android en vigueur.

## Fonctionnalités

- recherche DCI locale, sans Internet ;
- normalisation des accents et de la casse ;
- alias uniquement lorsqu'ils sont explicitement présents dans la source ;
- fiche médicament ;
- favoris Room ;
- historique Room ;
- partage Android natif ;
- impression via Android Print Framework ;
- avertissement médical ;
- écran À propos avec photo du créateur ;
- mode clair/sombre via le thème système.

## Confidentialité

Aucun compte, aucune publicité, aucun analytics obligatoire, aucun tracking et aucune transmission des recherches vers un serveur.
