

CREATE TABLE IF NOT EXISTS Products (
    code INT(4)  UNSIGNED ZEROFILL NOT NULL,
    name CHAR(50),
    stock INT NOT NULL,
    value FLOAT,
    id_category tinyint NULL,
    PRIMARY KEY (code)
);

CREATE TABLE IF NOT EXISTS Categories (
    id tinyint NOT NULL,
    Name CHAR(50) NOT NULL,
    Description VARCHAR(200),
    PRIMARY KEY (id)

);

ALTER TABLE Products ADD FOREIGN KEY (id_category) REFERENCES Categories(id);
