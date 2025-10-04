# Initiation à la théorie des langages — Présentation & objectifs

Ce module **prépare théoriquement à la construction de compilateurs**. Il introduit les notions fondamentales (mots, langages, automates, grammaires) et les met en pratique via la chaîne **Lex/Flex** (analyse lexicale) et **Yacc/Bison** (analyse syntaxique) pour bâtir un mini-analyseur / mini-compilateur.

## Objectifs de la matière
- Comprendre la notion de **mot**, **alphabet**, **langage** et les opérations usuelles (concaténation, étoile de Kleene, résiduels, morphismes).
- Modéliser des **langages rationnels** via **expressions régulières** et **automates finis** (déterministes, non déterministes, complétion, produit cartésien, minimisation).
- Manipuler des **grammaires algébriques** (non contextuelles) : dérivations, arbres, ambiguïté, précédence/associativité.
- Mettre en pratique avec **Lex/Flex** (analyseur lexical) et **Yacc/Bison** (analyseur syntaxique) pour construire un mini-analyseur/mini-compilateur.

## En bref
- **Théorie** : langages formels, fermetures et transformations (résiduels, morphismes), automates (DFA/NFA), grammaires (ambiguïté, arbres, priorités).
- **Pratique** : spécification de tokens (regex) avec Flex, grammaire et actions sémantiques avec Bison, intégration `yylex()` ↔ `yyparse()`, gestion d’erreurs, tests.

> Ce dépôt contient la realisation d'un projet de gestion de ticket de concert'