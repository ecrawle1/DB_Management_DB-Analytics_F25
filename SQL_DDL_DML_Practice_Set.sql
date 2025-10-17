CREATE SCHEMA AUTHORIZATION HorseRacing

create table BARN(
    bId NUMBER(1),
    bName VARCHAR2(2),
    CONSTRAINT BARN_bId_pk PRIMARY KEY (bId)
);

create table Person (
    pId VARCHAR2(3),
    PName VARCHAR2(20) NOT NULL,
    pPhone VARCHAR2(10),
    pAddress VARCHAR2(40),
    CONSTRAINT Person_pId_pk PRIMARY KEY (pId)
);

create table RaceHorse(
    regNum VARCHAR2(3) PRIMARY KEY,
    hName VARCHAR2(20) NOT NULL,
    gender VARCHAR2(6),
    hType VARCHAR2(13),
    purchaseDate VARCHAR2(10),
    purchasePrice VARCHAR2(10),
    trainedBy VARCHAR2(3),
    stableAt NUMBER(1),
    CONSTRAINT RaceHorse_stableAt_fk FOREIGN KEY (stableAt) REFERENCES Barn (bId) ON DELEETE CASCADE,
    CONSTRAINT RaceHorse_trainedBy_fk FOREIGN KEY (trainedBy) REFERENCES Person (pId) ON DELETE SET NULL
);

create table Offspring (
    regNum VARCHAR2(3),
    parent VARCHAR2(3),
    CONSTRAINT Offspring_regNum_parent_pk PRIMARY KEY (regNum, parent),
    CONSTRAINT Offspring_regNum_fk FOREIGN KEY (regNum) REFERENCES RaceHorse (regNum) on  DELETE SET NULL,
    CONSTRAINT Offspring_parent_fk FOREIGN KEY (parent) REFERENCES RaceHorse (regNum) on DELETE SET NULL
);

create table OwnedBy (
    regNum VARCHAR2(3),
    pId VARCHAR2(3),
    ownerPercentage NUMBER(3),
    CONSTRAINT OwnedBy_regNum_pId_pk PRIMARY KEY (regNum, pId)
    CONSTRAINT OwnedBy_regNum_fk FOREIGN KEY (regNum) REFERENCES RaceHorse (regNum) on DELEETE CASCADE,
    CONSTRAINT OwnedBy_pId_fk FOREIGN KEY (pId) REFERENCES Person (pId) on DELEETE CASCADE
);

create table RaceSchedule (
    schId VARCHAR2(3) PRIMARY KEY,
    schYear VARCHAR2(4),
    schMonth VARCHAR2(2),
    schDay VARCHAR2(2),
);

create table Race (
    schId VARCHAR2(3),
    rNumber NUMBER(4),
    purse NUMBER(10),
    CONSTRAINT Race_schId_rNumber_pk PRIMARY KEY (schId, rNumber)
    CONSTRAINT Race_schId_fk FOREIGN KEY (schId) REFERENCES RaceSchedule (schId) on DELETE CASCADE
);

create table Entry (
    schId VARCHAR2(3),
    rNumber NUMBER(4),
    gate NUMBER(2),
    finalPos NUMBER(2),
    jockey VARCHAR2(3),
    horse VARCHAR2(3),
    CONSTRAINT Entry_schId_rNumber_gate_pk PRIMARY KEY (schId, rNumber, gate),
    CONSTRAINT Entry_schId_rNumber_fk FOREIGN KEY (schId, rNumber) REFERENCES Race (schId, rNumber) on DELEETE CASCADE,
    CONSTRAINT Entry_jockey_fk FOREIGN KEY (jockey) REFERENCES Person (pId) on DELEETE SET NULL,
    CONSTRAINT Entry_horse_fk FOREIGN KEY (horse) REFERENCES RaceHorse (regNum) on DELEETE CASCADE
);
