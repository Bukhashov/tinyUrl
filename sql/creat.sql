-- Active: 1673682557377@@127.0.0.1@5432@tiny_url

CREATE TABLE links (
    id int NOT NULL PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    short   VARCHAR,
    link    VARCHAR,
    counter INT 
);
