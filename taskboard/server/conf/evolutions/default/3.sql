# --- !Ups

ALTER TABLE TICKETS ADD COLUMN PRIORITY VARCHAR(30);
UPDATE TICKETS SET PRIORITY = 'LOW';
ALTER TABLE TICKETS MODIFY COLUMN PRIORITY VARCHAR(30) NOT NULL;

INSERT INTO PROJECTS("NAME", "DESCRIPTION") VALUES('DEFAULT_PROJECT', 'DEFAULT_PROJECT');
ALTER TABLE TICKETS ADD COLUMN PROJECT INT;
UPDATE TICKETS SET PROJECT = SELECT LAST_INSERT_ID();
ALTER TABLE TICKETS MODIFY COLUMN PROJECT INT NOT NULL;
ALTER TABLE TICKETS ADD CONSTRAINT FK_PROJECT_ID FOREIGN KEY (PROJECT) REFERENCES "PROJECTS"("ID");

CREATE TABLE TICKET_STATES(ID INT NOT NULL PRIMARY KEY AUTO_INCREMENT, NAME VARCHAR(255) NOT NULL UNIQUE);

ALTER TABLE TICKETS ADD COLUMN STATE VARCHAR(30);
UPDATE TICKETS SET STATE = 'OPENED';
ALTER TABLE TICKETS MODIFY COLUMN STATE VARCHAR(30) NOT NULL;

# --- !Downs

ALTER TABLE TICKETS DROP CONSTRAINT FK_PRIORITY_ID;
ALTER TABLE TICKETS DROP COLUMN PRIORITY;
DROP TABLE PRIORITIES;