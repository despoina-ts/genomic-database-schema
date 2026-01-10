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

-- Data inserts
INSERT INTO gene (gene_id, gene_name, description, gene_type, gc_content, chrom, gene_start, gene_end, transcript_count, gene_synonym)
VALUES
('ENSG00000285479', 'CACNA1C', 'calcium voltage-gated channel subunit alpha1 C [Source:HGNC Symbol Acc:HGNC:1390]', 'protein_coding', 47.12, 'HG1815_PATCH', 312916, 1046066, 50, 'CACNA1C-IT2'),
('ENSG00000106733', 'NMRK1', 'nicotinamide riboside kinase 1 [Source:HGNC Symbol Acc:HGNC:26057]', 'protein_coding', 40.5, '9', 75060573, 75088217, 7, 'BA235O14.2'),
('ENSG00000090863', 'GLG1', 'golgi glycoprotein 1 [Source:HGNC Symbol Acc:HGNC:4316]', 'protein_coding', 42.38, '16', 74447427, 74607144, 14, 'CFR-1'),
('ENSG00000090857', 'PDPR', 'pyruvate dehydrogenase phosphatase regulatory subunit [Source:HGNC Symbol Acc:HGNC:30264]', 'protein_coding', 47.1, '16', 70114332, 70162537, 11, 'PDP3'),
('ENSG00000275331', 'ABCC6', 'ATP binding cassette subfamily C member 6 [Source:HGNC Symbol Acc:HGNC:57]', 'protein_coding', 49.86, 'HSCHR16_1_CTG1', 1806848, 1881517, 8, 'EST349056'),
('ENSG00000006125', 'AP2B1', 'adaptor related protein complex 2 subunit beta 1 [Source:HGNC Symbol Acc:HGNC:563]', 'protein_coding', 39.93, '17', 35578046, 35726413, 22, 'CLAPB1'),
('ENSG00000288427', 'CLSTN3', 'calsyntenin 3 [Source:HGNC Symbol Acc:HGNC:18371]', 'protein_coding', 51.75, 'HG1398_PATCH', 57384, 86631, 16, 'KIAA0726'),
('ENSG00000291428', 'BRSK2', 'BR serine/threonine kinase 2 [Source:HGNC Symbol Acc:HGNC:11405]', 'protein_coding', 63.85, 'HG152_PATCH', 124165, 196955, 15, 'SAD-A'),
('ENSG00000150712', 'MTMR12', 'myotubularin related protein 12 [Source:HGNC Symbol Acc:HGNC:18191]', 'protein_coding', 44.08, '5', 32226994, 32312987, 7, '3-PAP'),
('ENSG00000170579', 'DLGAP1', 'DLG associated protein 1 [Source:HGNC Symbol Acc:HGNC:2905]', 'protein_coding', 39.67, '18', 3496032, 4455307, 22, 'GKAP'),
('ENSG00000139618', 'BRCA2', 'BRCA2 DNA repair associated [Source:HGNC Symbol Acc:HGNC:1101]', 'protein_coding', 38.2, '13', 32315086, 32400268, 19, 'BRCC2, FACD, FAD, FAD1, FANCD, FANCD1, XRCC11'),
('ENSG00000176697', 'BDNF', 'brain derived neurotrophic factor [Source:HGNC Symbol Acc:HGNC:1033]', 'protein_coding', 40.05, '11', 27654893, 27722058, 17, 'None');

INSERT INTO promoter (promoter_id, chrom, promoter_start, promoter_end, extended_start, extended_end, gene_biotype)
VALUES
('ENSR5_9GS9T', '5', 32312928, 32313340, 32312928, 32313340, 'protein_coding'),
('ENSR9_934RNX', '9', 75088145, 75088524, 75088145, 75088524, 'protein_coding'),
('ENSR16_BHWNS', '16', 70113842, 70114382, 70113393, 70114382, 'protein_coding'),
('ENSR16_BJRQW', '16', 74607102, 74607634, 74607102, 74608415, 'protein_coding'),
('ENSR17_B93NL', '17', 35586784, 35587525, 35586617, 35587525, 'protein_coding'),
('ENSR18_93QQ6', '18', 4455256, 4455543, 4455256, 4455543, 'protein_coding'),
('ENSR13_9GSBD', '13', 32314759, 32315096, 32314759, 32315096, 'protein_coding'),
('ENSR13_8XMM3', '13', 32315353, 32315518, 32315353, 32315518, 'protein_coding'),
('ENSR11_9DZT2', '11', 27699657, 27700157, 27699657, 27700444, 'protein_coding'),
('ENSR11_C4Q7S', '11', 27700445, 27701543, 27700445, 27702085, 'protein_coding'),
('ENSR11_73M294', '11', 27719737, 27719848, 27719737, 27719848, 'protein_coding');

INSERT INTO variant (clinvar_id, chrom, position, clinical_significance, rsId, ncbiAccession, ncbiID)
VALUES
(1168940, '13', 32315300, 'benign', '36221751', '0003582', '1157132'),
(2174981, '13', 32315355, 'uncertain_significance', 'none', '1901121', '0003582'),
(3390224, '13', 32323395, 'uncertain_significance', 'none', 'C3661900', '3549347'),
(1166054, '13', 32315411, 'likely_benign', '563971900', 'C2675520', '1157133'),
(3353313, '11', 27657817, 'likely_benign', 'none', 'NC_00011', '3512534'),
(3353378, '11', 27657830, 'likely_benign', 'none', 'NC_00014', '3512599'),
(3356097, '11', 27657844, 'likely_benign', 'none', 'NC_00078', '3515319'),
(2630210, '11', 27657906, 'uncertain_significance', 'none', 'NC_00099', '2798151'),
(433370, '16', 16150095, 'benign/likely_benign', '59461468', '0009925', '426778'),
(433369, '16', 16150116, 'benign', '3902401', '0009935', '426779'),
(433368, '16', 16150144, 'likely_pathogenic', '63750874', '0009965', '426780');

INSERT INTO exon (exon_id, gene_id)
VALUES
('ENSE00001484009', 'ENSG00000139618'),
('ENSE00003666217', 'ENSG00000139618'),
('ENSE00003659301', 'ENSG00000139618'),
('ENSE00003747332', 'ENSG00000139618'),
('ENSE00003714754', 'ENSG00000139618'),
('ENSE00000939167', 'ENSG00000139618'),
('ENSE00003743413', 'ENSG00000275331'),
('ENSE00003741616', 'ENSG00000275331'),
('ENSE00003733557', 'ENSG00000275331'),
('ENSE00003753781', 'ENSG00000275331');

INSERT INTO transcript (transcript_id, transcript_name, transcript_start, transcript_end, transcript_type, refseq, gene_id)
VALUES
('ENST00000380152.8', 'BRCA2-201', 32315508, 32400268, 'protein_coding', 'NM_000059.4', 'ENSG00000139618'),
('ENST00000530893.7', 'BRCA2-204', 32315505, 32400268, 'protein_coding', '-', 'ENSG00000139618'),
('ENST00000470094.2', 'BRCA2-202', 32315508, 32400265, 'Nonsense_mediated_decay', '-', 'ENSG00000139618'),
('ENST00000356660.9', 'BDNF-202', 27654893, 27700455, 'protein_coding', 'NM_001709.5', 'ENSG00000176697'),
('ENST00000314915.6', 'BDNF-201', 27654893, 27722058, 'protein_coding', '-', 'ENSG00000176697'),
('ENST00000525950.5', 'BDNF-211', 27654893, 27720779, 'protein_coding', '-', 'ENSG00000176697'),
('ENST00000347598.9', 'CACNA1C-220', 2052987, 2697950, 'protein_coding', '-', 'ENSG00000285479'),
('ENST00000399655.6', 'CACNA1C-220', 2052987, 2697950, 'protein_coding', 'NM_000719.7', 'ENSG00000285479'),
('ENST00000399603.6', 'CACNA1C-209', 2052987, 2697950, 'protein_coding', '-', 'ENSG00000285479'),
('ENST00000406454.8', 'CACNA1C-222', 2052987, 2692159, 'protein_coding', '-', 'ENSG00000285479');

INSERT INTO gene_promoter (gene_id, promoter_id)
VALUES
('ENSG00000150712', 'ENSR5_9GS9T'),
('ENSG00000106733', 'ENSR9_934RNX'),
('ENSG00000090863', 'ENSR16_BJRQW'),
('ENSG00000090857', 'ENSR16_BHWNS'),
('ENSG00000006125', 'ENSR17_B93NL'),
('ENSG00000170579', 'ENSR18_93QQ6'),
('ENSG00000139618', 'ENSR13_9GSBD'),
('ENSG00000176697', 'ENSR11_9DZT2'),
('ENSG00000139618', 'ENSR13_8XMM3'),
('ENSG00000176697', 'ENSR11_C4Q7S'),
('ENSG00000176697', 'ENSR11_73M294');

INSERT INTO gene_variant (gene_id, variant_id)
VALUES
('ENSG00000139618', 1168940),
('ENSG00000139618', 2174981),
('ENSG00000139618', 3390224),
('ENSG00000139618', 1166054),
('ENSG00000176697', 3353378),
('ENSG00000176697', 3353313),
('ENSG00000176697', 3356097),
('ENSG00000176697', 2630210),
('ENSG00000275331', 433370),
('ENSG00000275331', 433369),
('ENSG00000275331', 433368);

-- Queries
SELECT gene_id
FROM gene_promoter
GROUP BY gene_id
HAVING COUNT(promoter_id) > 1;

SELECT gene_name, description, gene_type
FROM gene
WHERE description LIKE '%kinase%'
  AND gene_type = 'protein_coding';

SELECT gene_id
FROM transcript
GROUP BY gene_id
HAVING COUNT(transcript_id) > 1;

SELECT DISTINCT g.gene_id, g.gene_name
FROM gene g
JOIN gene_promoter gp ON g.gene_id = gp.gene_id
JOIN promoter p ON gp.promoter_id = p.promoter_id
JOIN gene_variant gv ON g.gene_id = gv.gene_id
JOIN variant v ON gv.variant_id = v.clinvar_id
WHERE v.position BETWEEN p.promoter_start AND p.promoter_end;

SELECT DISTINCT g.gene_id, g.gene_name
FROM gene g
JOIN gene_variant gv ON g.gene_id = gv.gene_id
JOIN variant v ON gv.variant_id = v.clinvar_id
JOIN transcript t ON g.gene_id = t.gene_id
WHERE v.position BETWEEN t.transcript_start AND t.transcript_end;

