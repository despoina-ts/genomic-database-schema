-- Database
CREATE DATABASE IF NOT EXISTS gene_db;
USE gene_db;

-- Reset (rerunnable)
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS gene_variant;
DROP TABLE IF EXISTS gene_promoter;
DROP TABLE IF EXISTS exon;
DROP TABLE IF EXISTS transcript;
DROP TABLE IF EXISTS variant;
DROP TABLE IF EXISTS promoter;
DROP TABLE IF EXISTS protein;
DROP TABLE IF EXISTS gene_synonym;
DROP TABLE IF EXISTS gene;
SET FOREIGN_KEY_CHECKS = 1;

-- Tables
CREATE TABLE gene (
  gene_id VARCHAR(50) PRIMARY KEY,
  gene_name VARCHAR(255),
  description TEXT,
  gene_type VARCHAR(100),
  gc_content FLOAT,
  chrom VARCHAR(50),
  gene_start INT,
  gene_end INT,
  transcript_count INT,
  gene_synonym VARCHAR(255)
);

CREATE TABLE promoter (
  promoter_id VARCHAR(50) PRIMARY KEY,
  chrom VARCHAR(50),
  promoter_start INT,
  promoter_end INT,
  extended_start INT,
  extended_end INT,
  gene_biotype VARCHAR(100)
);

CREATE TABLE variant (
  clinvar_id INT PRIMARY KEY,
  chrom VARCHAR(50),
  position INT,
  clinical_significance VARCHAR(255),
  rsId VARCHAR(50),
  ncbiAccession VARCHAR(255),
  ncbiID VARCHAR(255)
);

CREATE TABLE exon (
  exon_id VARCHAR(50) PRIMARY KEY,
  gene_id VARCHAR(50) NOT NULL,
  FOREIGN KEY (gene_id) REFERENCES gene(gene_id)
);

CREATE TABLE transcript (
  transcript_id VARCHAR(50) PRIMARY KEY,
  transcript_name VARCHAR(255),
  transcript_start INT,
  transcript_end INT,
  transcript_type VARCHAR(100),
  refseq VARCHAR(255),
  gene_id VARCHAR(50) NOT NULL,
  FOREIGN KEY (gene_id) REFERENCES gene(gene_id)
);

CREATE TABLE gene_promoter (
  gene_id VARCHAR(50) NOT NULL,
  promoter_id VARCHAR(50) NOT NULL,
  PRIMARY KEY (gene_id, promoter_id),
  FOREIGN KEY (gene_id) REFERENCES gene(gene_id),
  FOREIGN KEY (promoter_id) REFERENCES promoter(promoter_id)
);

CREATE TABLE gene_variant (
  gene_id VARCHAR(50) NOT NULL,
  variant_id INT NOT NULL,
  PRIMARY KEY (gene_id, variant_id),
  FOREIGN KEY (gene_id) REFERENCES gene(gene_id),
  FOREIGN KEY (variant_id) REFERENCES variant(clinvar_id)
);

CREATE TABLE protein (
  protein_id INT PRIMARY KEY,
  gene_id VARCHAR(50) NOT NULL,
  FOREIGN KEY (gene_id) REFERENCES gene(gene_id)
);

CREATE TABLE gene_synonym (
  gene_synonym_id INT PRIMARY KEY,
  gene_id VARCHAR(50) NOT NULL,
  gene_synonym VARCHAR(255),
  FOREIGN KEY (gene_id) REFERENCES gene(gene_id)
);

