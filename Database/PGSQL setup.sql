-- This script was generated by the ERD tool in pgAdmin 4.
-- Please log an issue at https://redmine.postgresql.org/projects/pgadmin4/issues/new if you find any bugs, including reproduction steps.
BEGIN;

CREATE TABLE IF NOT EXISTS public.users
(
    id character varying(50) PRIMARY KEY,
    name character varying(50) NOT NULL,
    surname character varying(50) NOT NULL,
    email character varying(50) NOT NULL,
    password character varying(50) NOT NULL,
    address character varying(200) NOT NULL
);

CREATE TABLE IF NOT EXISTS public.orders
(
    id character varying(50) PRIMARY KEY,
    user_id character varying(50) REFERENCES users(id),
    status character varying(20) NOT NULL,
    total_quantity integer,
    total_price integer
);

CREATE TABLE IF NOT EXISTS public.items
(
    name character varying(50) PRIMARY KEY,
    price integer,
    quantity integer,
    description character varying(200)
);

CREATE TABLE IF NOT EXISTS public.cart_items
(
    order_id character varying(50) REFERENCES orders(id),
    user_id character varying(50) REFERENCES users(id),
    item_name character varying(50) REFERENCES items(name),
    PRIMARY KEY (order_id, item_name),
    quantity integer,
    total_price integer
);

CREATE TABLE IF NOT EXISTS public.shop
(
    id character varying(50) PRIMARY KEY,
    name character varying(50),
    email character varying(50),
    phone_nr integer,
    address_id integer,
    capital integer
);

-- ALTER

ALTER TABLE IF EXISTS public.orders
    ADD FOREIGN KEY (user_id)
    REFERENCES public.users(id)
    ON DELETE CASCADE;



ALTER TABLE IF EXISTS public.cart_items
    ADD FOREIGN KEY (order_id)
    REFERENCES public.orders (id)
    ON DELETE CASCADE;


ALTER TABLE IF EXISTS public.cart_items
    ADD FOREIGN KEY (item_name)
    REFERENCES public.items (name)
    ON UPDATE CASCADE
    ON DELETE CASCADE;


ALTER TABLE IF EXISTS public.cart_items
    ADD FOREIGN KEY (user_id)
    REFERENCES public.users (id) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE;


-----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------
-- POPULATING ITEMS 


INSERT INTO items VALUES ('apple', 2, 50, 'Red, Green, Red n Yellow');
INSERT INTO items VALUES ('banana', 1, 50, 'Yellow fruit');
INSERT INTO items VALUES ('mango', 4, 50, 'Sweet delicious fruit');
INSERT INTO items VALUES ('kiwi', 3, 50, 'Brownish hairy and green inside');
INSERT INTO items VALUES ('grape', 3, 50, 'Many dots');
INSERT INTO items VALUES ('orange', 2, 50, 'They are yellow in color');
INSERT INTO items VALUES ('donut', 2, 50, 'Cops love em??');
INSERT INTO items VALUES ('cheese', 7, 50, 'Say cheeeese');
INSERT INTO items VALUES ('Computer', 200, 50, 'Humanity"s super-power');
INSERT INTO items VALUES ('rock', 1000, 50, 'The most stable object');

INSERT INTO users VALUES ('usrid', 'testName', 'testSurname', 'a@b.c', '1234', '22 Jump str');

INSERT INTO orders VALUES ('theorder66', 'usrid', 'current', 0, 0);


END;