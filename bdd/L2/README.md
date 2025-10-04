## Base de données — Microsoft Access (L2) : Présentation & objectifs

Ce dépôt accompagne un mini-projet du module **Base de données** réalisé avec **Microsoft Access**. 

Il couvre la modélisation , la normalisation, la mise en œuvre dans Access (tables, relations, intégrité), l’écriture de requêtes SQL Access

## Objectifs du module
- Concevoir un **schéma relationnel** à partir d’un modèle conceptuel (entités/associations, cardinalités, clés).
- Appliquer la **normalisation** (1FN → 3FN) et identifier les **dépendances fonctionnelles**.
- Implémenter la base dans **Microsoft Access** : tables, **clés primaires/étrangères**, index, intégrité référentielle (cascade/empêcher suppression).
- Rédiger des **requêtes SQL (Access)** pour l’extraction, le filtrage, l’agrégation et les mises à jour.
- Construire des **formulaires** pour la saisie/consultation

## Compétences démontrées
- Passage MCD/MERISE → MLD → schéma relationnel (choix des clés, types, contraintes).
- Écriture de **requêtes Access** : `SELECT ... FROM ... INNER JOIN ... WHERE ... GROUP BY ... HAVING ... ORDER BY`.
- Utilisation de fonctions Access (`IIf`, `Nz`, `DatePart`, `Format`, `Like`, `Between`, `DateDiff`, etc.).
- Réalisation d’**interfaces** (formulaires liés, sous-formulaires) et d’**états** (groupements, totaux).

## Contenus vus en cours/TD
- **Modélisation** : entités, attributs, identifiants, associations (1–1, 1–N, N–N).
- **SQL Access** :
  - **Sélection/Jointures** : `INNER JOIN` (non imbriqué recommandé), `LEFT JOIN`, `UNION` (requête union Access).
  - **Agrégats** : `COUNT`, `SUM`, `AVG`, `MIN`, `MAX`, `GROUP BY`, `HAVING`.
  - **Filtres** : `WHERE`, `LIKE`, `IN`, `BETWEEN #date1# AND #date2#`, `IS NULL/NOT NULL`.