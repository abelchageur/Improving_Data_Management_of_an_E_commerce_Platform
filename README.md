# Amélioration de la Gestion des Données d’une Plateforme E-Commerce

## Description
Dans un secteur e-commerce de plus en plus compétitif, l’exploitation efficace des données est essentielle pour optimiser la gestion des stocks, améliorer la satisfaction client et fournir des analyses exploitables aux décideurs. Ce projet met en œuvre un pipeline complet de traitement et d’analyse des données en utilisant **Talend** pour les opérations ETL, **SQL Server** pour l’entrepôt de données et **Power BI** pour la visualisation et l’analyse. L’objectif est de garantir un traitement fiable des données, des insights approfondis et une conformité avec les réglementations comme le **RGPD**.

---

## Table des Matières
1. [Préparation des Données](#préparation-des-données)
2. [ETL avec Talend](#etl-avec-talend)
3. [Modélisation en SQL Server](#modélisation-en-sql-server)
4. [T-SQL Unit Testing](#t-sql-unit-testing)
5. [Création des Data Marts](#création-des-data-marts)
6. [Analyse et Visualisation avec Power BI](#analyse-et-visualisation-avec-power-bi)
7. [Orchestration avec Talend JobConductor](#orchestration-avec-talend-jobconductor)

---

## Préparation des Données
- Application du script de Data Splitter pour diviser le dataset en **JSON** et **CSV**.
- Utilisation de **Python** ou **Talend** pour la conversion des données.
- Validation de l’intégrité des données après transformation.
- Stockage des fichiers transformés dans des répertoires distincts.

---

## ETL avec Talend

### Extraction des Données
- Connexion de **Talend** aux fichiers CSV et JSON.
- Configuration des connexions et vérification du chargement des données.

### Transformation des Données
- **Nettoyage** : gestion des valeurs manquantes, harmonisation des types.
- **SCD (Slowly Changing Dimensions)** :
  - **CustomerDimension** : Type 2 (historisation des changements).
  - **ProductDimension** : Type 1 (corrections directes) et Type 3 (stockage des anciennes valeurs).
- **Calculs avancés** : ajout de colonnes calculées (chiffre d’affaires, détection d’anomalies).

### Chargement des Données
- Insertion des données transformées dans **SQL Server** avec **tMSSqlOutput**.
- Chargement des **dimensions** en premier, suivi des **tables de faits**.
- Activation de la journalisation via **tLogCatcher**.

---

## Modélisation en SQL Server

### Création du Schéma de Constellation
- **Tables de Dimensions** :
  - `DateDimension`, `ProductDimension`, `CustomerDimension`, `SupplierDimension`, `ShipperDimension`
- **Tables de Faits** :
  - `SalesFact` : ventes (quantité, prix, total).
  - `InventoryFact` : stock (quantité, seuils, réapprovisionnement).

### Optimisation des Performances
- **Indexation** des colonnes critiques.
- **Partitionnement** des tables volumineuses.

### Sécurité et Conformité
- Permissions par rôle utilisateur.
- Masquage dynamique des données sensibles.

---

## T-SQL Unit Testing
- Validation des données après le chargement avec **tSQLt**.
- Exemples de tests :
  ```sql
  EXEC tSQLt.AssertEquals(
    (SELECT COUNT(*) FROM SalesFact WHERE SaleID IS NULL), 
    0, 
    'Test failed: SalesFact has NULL SaleID.'
  );
## Création des Data Marts

### Data Mart des Ventes
- `SalesFact`, `TimeDimension`, `ProductDimension`, `CustomerDimension`.

### Data Mart de l’Inventaire
- `InventoryFact`, `TimeDimension`, `ProductDimension`, `SupplierDimension`.

### Analyses
- **Meilleurs produits et catégories**.
- **Segmentation des clients**.
- **Niveaux critiques de stock**.

---

## Analyse et Visualisation avec Power BI

### Tableaux de bord dynamiques
- **Tendances des ventes**.
- **Cartes géographiques des ventes**.
- **Niveaux d’inventaire et délais de réapprovisionnement**.

### Analyse prédictive
- **Prévisions avec ARIMA**.

### Alertes
- **Détection des seuils critiques (rupture de stock)**.

---

## Orchestration avec Talend JobConductor

- **Automatisation du pipeline ETL**.
- **Dépendances entre tâches** (chargement des dimensions avant les faits).
- **Suivi et journalisation des exécutions**.

---

## Installation et Exécution

### Prérequis
- **Talend Open Studio**
- **Microsoft SQL Server**
- **Power BI Desktop**
- **Python (optionnel)**

### Installation
1. Cloner ce repository :
   ```bash
   git clone https://github.com/votre-repo/ecommerce-data-pipeline.git
   cd ecommerce-data-pipeline
2. **Configurer Talend** pour exécuter les jobs ETL.
3. **Déployer les scripts SQL Server** pour créer l’entrepôt de données.
4. **Charger les données** et **exécuter les tests unitaires**.
   
## Exécution

1. **Lancer les jobs Talend** via **JobConductor**.
2. **Ouvrir Power BI** et **actualiser les dashboards**.
