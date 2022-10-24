CREATE TABLE Zutat(
ZutatsNr NUMBER PRIMARY KEY,
ZutatsName VARCHAR2(20) NOT NULL,
Vob_Variante VARCHAR2(20),
Einheit_Bezeichnung_FK VARCHAR2(6) DEFAULT 'Stk'
);

CREATE TABLE Rezept(
ZutatsNr NUMBER PRIMARY KEY,
Anzahl NUMBER NOT NULL,
Beschreibung VARCHAR2(20),
Person_NR_FK NUMBER
);

CREATE TABLE Materialzutat(
ZutatsNr NUMBER PRIMARY KEY,
Material VARCHAR2(20)
);

CREATE TABLE Tag(
Wort_PK VARCHAR2(20) PRIMARY KEY
);

DROP TABLE Person;

CREATE TABLE Person(
PersonNr NUMBER PRIMARY KEY,
Vorname VARCHAR2(20) NOT NULL,
Nachname VARCHAR2(20) NOT NULL
);

DROP TABLE Bewertung;

CREATE TABLE Bewertung(
BewertungsNr NUMBER PRIMARY KEY,
Einfachheit NUMBER NOT NULL,
Leckerfaktor NUMBER NOT NULL,
Datum DATE NOT NULL,
Kommentar VARCHAR2(100),
PersonNr_FK NUMBER,
Rezept_ZutatsNr_FK NUMBER,
CONSTRAINT ChkEinfachheit CHECK (Einfachheit > 0 AND Einfachheit <= 5),
CONSTRAINT ChkLeckerfaktor CHECK (Leckerfaktor > 0 AND Leckerfaktor <= 5)
);

CREATE TABLE Kochanweisung(
KochanweisungsNr NUMBER PRIMARY KEY,
Text VARCHAR2(200) NOT NULL
);

CREATE TABLE Bild(
BildNr NUMBER PRIMARY KEY,
Name VARCHAR2(20),
Verzeichniss VARCHAR2(100) NOT NULL
);

CREATE TABLE Einheit(
Bezeichnung VARCHAR2(20) PRIMARY KEY
);

CREATE TABLE Vergibt(
PersonNr_FK NUMBER,
Wort_FK VARCHAR(20),
ZutatsNr_FK NUMBER,
PRIMARY KEY (PersonNr_FK,Wort_FK,ZutatsNr_FK)
);

CREATE TABLE Besteht_aus(
KochanweisungsNr_FK NUMBER,
ZutatsNr_FK NUMBER,
Reihenfolge VARCHAR(20) NOT NULL,
PRIMARY KEY (KochanweisungsNr_FK,ZutatsNr_FK)
);

CREATE TABLE Zeigt(
KochanweisungsNr_FK NUMBER,
BildNr_FK NUMBER,
Reihenfolge VARCHAR2(20) NOT NULL,
PRIMARY KEY (KochanweisungsNr_FK,BildNr_FK)
);

CREATE TABLE Verwendet(
Rezept_ZutatsNr_FK NUMBER,
ZutatsNr_FK NUMBER,
Menge NUMBER NOT NULL,
PRIMARY KEY (Rezept_ZutatsNr_FK,ZutatsNr_FK)
);
