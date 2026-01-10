# Genomic Database Schema

This repository implements a relational database for storing and querying
genomic information, including genes, transcripts, promoters, exons, and
genetic variants. The goal of the project is to demonstrate how genomic
entities can be modeled, stored, and analyzed using a structured SQL
database.

The repository contains both the complete database schema and a Python
script that executes it, making the project fully reproducible.

---

## Repository Structure

mkdir -p genomic-database-schema/schema
cd genomic-database-schema

touch schema/schema.sql
touch schema/run_schema.py
touch README.md



- `schema.sql` defines the database, tables, relationships, and inserts
  all genomic data.
- `run_schema.py` executes the SQL file and prints the results of all
  analytical queries.

---

## Database Content

The database stores the following entities:

- Genes (gene identifiers, names, genomic location, GC content, and type)
- Transcripts linked to each gene
- Promoters associated with genes
- Exons belonging to genes
- Genetic variants linked to genes
- Relationships between genes, promoters, and variants

All entities are connected using foreign keys, forming a relational
genomic model.

---

## Implemented Queries

The SQL script includes analytical queries that retrieve:

- Genes with more than one promoter
- Protein-coding genes related to kinases
- Genes with more than one transcript
- Genes with genetic variants located inside their promoters
- Genes with genetic variants that affect coding regions

These queries illustrate how relational joins can be used to explore
functional and regulatory genomic relationships.

---

## Requirements

To run the project, the following are required:

- MySQL Server
- Python 3
- mysql-connector-python

Install the Python dependency with:

```bash
pip install mysql-connector-python

```
----
Ηοw to run : 

git clone https://github.com/despoina-ts/genomic-database-schema.git
cd genomic-database-schema
python schema/run_schema.py




