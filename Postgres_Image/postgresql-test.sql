DROP TABLE "bam.hausrat_neugeschaeft";
CREATE TABLE "bam.hausrat_neugeschaeft" (
    pid        			 varchar(20),
    beitrag     		 DECIMAL,
    tarif       		 varchar(50),
    vertriebskanal       varchar(50),
    qm					 INTEGER,
    state				 varchar(50),
    datum				 TIMESTAMP,
    haustyp				 varchar(10)
);

INSERT INTO "bam.hausrat_neugeschaeft" VALUES ('0000000001', 30+ROUND(RANDOM()*100), 'Standard', 'Vermittler', 50+ROUND(RANDOM()*100)*2.0*RANDOM()*100 , 'Aktiv', CURRENT_DATE - INTEGER '5', 'efh');
INSERT INTO "bam.hausrat_neugeschaeft" VALUES ('0000000002', 30+ROUND(RANDOM()*100), 'Premium', 'Vermittler', 50+ROUND(RANDOM()*100)*2.0*RANDOM()*100 , 'Aktiv', CURRENT_DATE - INTEGER '5', 'efh');
INSERT INTO "bam.hausrat_neugeschaeft" VALUES ('0000000003', 30+ROUND(RANDOM()*100), 'Eco', 'Vermittler', 50+ROUND(RANDOM()*100)*2.0*RANDOM()*100 , 'Aktiv', CURRENT_DATE - INTEGER '5', 'efh');
INSERT INTO "bam.hausrat_neugeschaeft" VALUES ('0000000004', 30+ROUND(RANDOM()*100), 'Standard', 'Vermittler', 50+ROUND(RANDOM()*100)*2.0*RANDOM()*100 , 'Aktiv', CURRENT_DATE - INTEGER '4', 'efh');
INSERT INTO "bam.hausrat_neugeschaeft" VALUES ('0000000005', 30+ROUND(RANDOM()*100), 'Premium', 'Vermittler', 50+ROUND(RANDOM()*100)*2.0*RANDOM()*100 , 'Aktiv', CURRENT_DATE - INTEGER '4', 'efh');
INSERT INTO "bam.hausrat_neugeschaeft" VALUES ('0000000006', 30+ROUND(RANDOM()*100), 'Eco', 'Vermittler', 50+ROUND(RANDOM()*100)*2.0*RANDOM()*100 , 'Aktiv', CURRENT_DATE - INTEGER '3', 'efh');
INSERT INTO "bam.hausrat_neugeschaeft" VALUES ('0000000007', 30+ROUND(RANDOM()*100), 'Standard', 'Vermittler', 50+ROUND(RANDOM()*100)*2.0*RANDOM()*100 , 'Aktiv', CURRENT_DATE - INTEGER '3', 'mfh');
INSERT INTO "bam.hausrat_neugeschaeft" VALUES ('0000000008', 30+ROUND(RANDOM()*100), 'Premium', 'Vermittler', 50+ROUND(RANDOM()*100)*2.0*RANDOM()*100 , 'Aktiv', CURRENT_DATE - INTEGER '3', 'mfh');
INSERT INTO "bam.hausrat_neugeschaeft" VALUES ('0000000009', 30+ROUND(RANDOM()*100), 'Standard', 'Internet', 50+ROUND(RANDOM()*100)*2.0*RANDOM()*100 , 'Abgeschlossen', CURRENT_DATE - INTEGER '3', 'mfh');
INSERT INTO "bam.hausrat_neugeschaeft" VALUES ('0000000010', 30+ROUND(RANDOM()*100), 'Standard', 'Internet', 50+ROUND(RANDOM()*100)*2.0*RANDOM()*100 , 'Abgeschlossen', CURRENT_DATE - INTEGER '2', 'mfh');
INSERT INTO "bam.hausrat_neugeschaeft" VALUES ('0000000011', 30+ROUND(RANDOM()*100), 'Premium', 'Internet', 50+ROUND(RANDOM()*100)*2.0*RANDOM()*100 , 'Abgeschlossen', CURRENT_DATE - INTEGER '1', 'mfh');
INSERT INTO "bam.hausrat_neugeschaeft" VALUES ('0000000012', 30+ROUND(RANDOM()*100), 'Standard', 'Internet', 50+ROUND(RANDOM()*100)*2.0*RANDOM()*100 , 'Abgeschlossen', CURRENT_DATE - INTEGER '1', 'mfh');



SELECT * FROM "bam.hausrat_neugeschaeft";
