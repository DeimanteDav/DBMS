CREATE TABLE customer (
    customerid INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY, 
    name       VARCHAR(100) NOT NULL,
    phone      VARCHAR(15),
    street     VARCHAR,
    city       VARCHAR,
    zip        VARCHAR DEFAULT ''
);

CREATE TABLE tool (
    toolid       INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name         VARCHAR(100) NOT NULL,
    type         VARCHAR(50) NOT NULL,
    priceperday  NUMERIC(6,2) NOT NULL,
    manufacturer VARCHAR(50) DEFAULT 'Unknown'
);

ALTER TABLE tool
  ADD CONSTRAINT chk_tool_price_positive
  CHECK (priceperday > 0);

CREATE UNIQUE INDEX ux_tool_name_manufacturer ON tool (name, manufacturer);


CREATE TABLE rental (
    rentalid  INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    customerid INT NOT NULL,
    startdate  DATE NOT NULL DEFAULT CURRENT_DATE,
    enddate    DATE NOT NULL,
    CONSTRAINT fk_rental_customer FOREIGN KEY (customerid)
        REFERENCES customer(customerid)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

ALTER TABLE rental
  ADD CONSTRAINT chk_rental_dates_order
  CHECK (enddate >= startdate);

CREATE INDEX idx_rental_customer ON rental (customerid); -- kitokio


CREATE TABLE rentalDetail (
    rentalid   INT NOT NULL,
    toolid     INT NOT NULL,
    quantity   INT NOT NULL,
    returndate DATE,
    CONSTRAINT pk_rentalDetail PRIMARY KEY (rentalid, toolid),
    CONSTRAINT fk_rd_rental FOREIGN KEY (rentalid) REFERENCES rental(rentalid) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_rd_tool   FOREIGN KEY (toolid)   REFERENCES tool(toolid)   ON UPDATE CASCADE ON DELETE RESTRICT
);

ALTER TABLE rentalDetail
  ADD CONSTRAINT chk_rentalDetail_quantity_positive
  CHECK (quantity > 0);

CREATE INDEX idx_rentalDetail_tool ON rentalDetail (toolid);
