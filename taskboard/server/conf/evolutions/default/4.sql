# --- !Ups

CREATE TABLE WORKFLOWS (
            ID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
            WF_NAME VARCHAR NOT NULL,
            INITIAL_STATE FOREIGN KEY (STATES) REFERENCES(ID)
        );

CREATE TABLE PRIORITIES (
            ID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
            STR VARCHAR NOT NULL,
            WORKFLOW_ID INT NOT NULL FOREIGN KEY (WORKFLOWS) REFERENCES WORKFLOWS(ID)
        );

CREATE TABLE STATES (
            ID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
            STR VARCHAR NOT NULL,
            WORKFLOW_ID INT NOT NULL
        );

BEGIN;

    INSERT INTO WORKFLOWS(INITIAL_STATE, WF_NAME) VALUES(1, 'DEFAULT WORKFLOW');

    INSERT INTO STATES(STR, WORKFLOW_ID) VALUES('OPENED', 1);
    INSERT INTO STATES(STR, WORKFLOW_ID) VALUES('IN_PROGRESS', 1);
    INSERT INTO STATES(STR, WORKFLOW_ID) VALUES('DONE', 1);
    INSERT INTO STATES(STR, WORKFLOW_ID) VALUES('WILL_NOT_DO', 1);

    INSERT INTO PRIORITIES(STR, WORKFLOW_ID) VALUES('LOW', 1);
    INSERT INTO PRIORITIES(STR, WORKFLOW_ID) VALUES('MEDIUM', 1);
    INSERT INTO PRIORITIES(STR, WORKFLOW_ID) VALUES('HIGH', 1);

    ALTER TABLE PROJECTS ADD COLUMN WORKFLOW_ID INT;
    UPDATE PROJECTS SET WORKFLOW_ID = 1;
    ALTER TABLE PROJECTS ADD CONSTRAINT FK_WORKFLOW_ID FOREIGN KEY (WORKFLOWS) REFERENCES WORKFLOWS(ID);

COMMIT;

# --- !Downs

DROP TABLE PRIORITIES;
DROP TABLE STATES;
DROP TABLE WORKFLOWS;
ALTER TABLE PROJECTS DROP COLUMN WORKFLOW_ID;