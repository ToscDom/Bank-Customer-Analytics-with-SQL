# Bank Customer Analytics with SQL

## Project Overview
This project focuses on creating a **denormalized feature table** to support supervised machine learning models aimed at predicting customer behaviors.

## Objectives
The primary objective is to prepare a feature-rich dataset for machine learning training by aggregating and enriching customer data. The final table, keyed by `id_cliente` (customer ID), includes both **quantitative** and **qualitative** indicators derived from the available database.

## Database Structure
The database consists of the following tables:
1. **Cliente:** Contains personal information about customers (e.g., age).
2. **Conto:** Details of customer accounts.
3. **Tipo_conto:** Describes various account types.
4. **Tipo_transazione:** Lists possible transaction types.
5. **Transazioni:** Records transactional details for customer accounts.

## Behavioral Indicators
The indicators are calculated per customer (`id_cliente`) and include:

### Basic Indicators
1. Customer's age (from `Cliente` table).

### Transaction Indicators
2. Total number of outgoing transactions across all accounts.
3. Total number of incoming transactions across all accounts.
4. Total amount of outgoing transactions across all accounts.
5. Total amount of incoming transactions across all accounts.

### Account Indicators
6. Total number of accounts owned.
7. Number of accounts owned by type (one indicator per account type).

### Transaction Indicators by Account Type
8. Number of outgoing transactions by account type (one indicator per type).
9. Number of incoming transactions by account type (one indicator per type).
10. Amount of outgoing transactions by account type (one indicator per type).
11. Amount of incoming transactions by account type (one indicator per type).
