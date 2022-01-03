--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: color_products; Type: TYPE; Schema: public; Owner: gb_user
--

CREATE TYPE public.color_products AS ENUM (
    'red',
    'orange',
    'yellow',
    'green',
    'blue',
    'violet',
    'pink',
    'black',
    'white',
    'brown',
    'multicolor'
);


ALTER TYPE public.color_products OWNER TO gb_user;

--
-- Name: gender_of_persons; Type: TYPE; Schema: public; Owner: gb_user
--

CREATE TYPE public.gender_of_persons AS ENUM (
    'man',
    'woman',
    'kids'
);


ALTER TYPE public.gender_of_persons OWNER TO gb_user;

--
-- Name: grade_of_product; Type: TYPE; Schema: public; Owner: gb_user
--

CREATE TYPE public.grade_of_product AS ENUM (
    '1',
    '2',
    '3',
    '4',
    '5'
);


ALTER TYPE public.grade_of_product OWNER TO gb_user;

--
-- Name: size_products; Type: TYPE; Schema: public; Owner: gb_user
--

CREATE TYPE public.size_products AS ENUM (
    'XXS',
    'XS',
    'S',
    'M',
    'L',
    'XL',
    'XXL'
);


ALTER TYPE public.size_products OWNER TO gb_user;

--
-- Name: status_of_orders; Type: TYPE; Schema: public; Owner: gb_user
--

CREATE TYPE public.status_of_orders AS ENUM (
    'in processing',
    'awaiting payment',
    'assembly',
    'sent',
    'received',
    'canceled'
);


ALTER TYPE public.status_of_orders OWNER TO gb_user;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: carts; Type: TABLE; Schema: public; Owner: gb_user
--

CREATE TABLE public.carts (
    id integer NOT NULL,
    user_id integer NOT NULL,
    item_product_id integer NOT NULL,
    quantity integer NOT NULL
);


ALTER TABLE public.carts OWNER TO gb_user;

--
-- Name: carts_id_seq; Type: SEQUENCE; Schema: public; Owner: gb_user
--

CREATE SEQUENCE public.carts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.carts_id_seq OWNER TO gb_user;

--
-- Name: carts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gb_user
--

ALTER SEQUENCE public.carts_id_seq OWNED BY public.carts.id;


--
-- Name: categories; Type: TABLE; Schema: public; Owner: gb_user
--

CREATE TABLE public.categories (
    id integer NOT NULL,
    name character varying(100)
);


ALTER TABLE public.categories OWNER TO gb_user;

--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: gb_user
--

CREATE SEQUENCE public.categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categories_id_seq OWNER TO gb_user;

--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gb_user
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- Name: designers; Type: TABLE; Schema: public; Owner: gb_user
--

CREATE TABLE public.designers (
    id integer NOT NULL,
    name character varying(100)
);


ALTER TABLE public.designers OWNER TO gb_user;

--
-- Name: designers_id_seq; Type: SEQUENCE; Schema: public; Owner: gb_user
--

CREATE SEQUENCE public.designers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.designers_id_seq OWNER TO gb_user;

--
-- Name: designers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gb_user
--

ALTER SEQUENCE public.designers_id_seq OWNED BY public.designers.id;


--
-- Name: items_products; Type: TABLE; Schema: public; Owner: gb_user
--

CREATE TABLE public.items_products (
    id integer NOT NULL,
    product_id integer NOT NULL,
    color public.color_products,
    size public.size_products,
    price numeric(9,2) NOT NULL
);


ALTER TABLE public.items_products OWNER TO gb_user;

--
-- Name: items_products_id_seq; Type: SEQUENCE; Schema: public; Owner: gb_user
--

CREATE SEQUENCE public.items_products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.items_products_id_seq OWNER TO gb_user;

--
-- Name: items_products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gb_user
--

ALTER SEQUENCE public.items_products_id_seq OWNED BY public.items_products.id;


--
-- Name: materials; Type: TABLE; Schema: public; Owner: gb_user
--

CREATE TABLE public.materials (
    id integer NOT NULL,
    name character varying(100)
);


ALTER TABLE public.materials OWNER TO gb_user;

--
-- Name: materials_id_seq; Type: SEQUENCE; Schema: public; Owner: gb_user
--

CREATE SEQUENCE public.materials_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.materials_id_seq OWNER TO gb_user;

--
-- Name: materials_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gb_user
--

ALTER SEQUENCE public.materials_id_seq OWNED BY public.materials.id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: gb_user
--

CREATE TABLE public.orders (
    id integer NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp without time zone,
    status public.status_of_orders
);


ALTER TABLE public.orders OWNER TO gb_user;

--
-- Name: orders_details; Type: TABLE; Schema: public; Owner: gb_user
--

CREATE TABLE public.orders_details (
    order_id integer NOT NULL,
    item_product_id integer NOT NULL,
    quantity integer NOT NULL
);


ALTER TABLE public.orders_details OWNER TO gb_user;

--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: gb_user
--

CREATE SEQUENCE public.orders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.orders_id_seq OWNER TO gb_user;

--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gb_user
--

ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: gb_user
--

CREATE TABLE public.products (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    gender public.gender_of_persons,
    descripton text,
    category_id integer NOT NULL,
    photo_name character varying(150) NOT NULL,
    material_id integer NOT NULL,
    designer_id integer NOT NULL
);


ALTER TABLE public.products OWNER TO gb_user;

--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: gb_user
--

CREATE SEQUENCE public.products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.products_id_seq OWNER TO gb_user;

--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gb_user
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- Name: profiles; Type: TABLE; Schema: public; Owner: gb_user
--

CREATE TABLE public.profiles (
    user_id integer,
    date_of_birth date,
    gender character(1),
    country character varying(100),
    city character varying(100),
    address character varying(255),
    created_at timestamp without time zone
);


ALTER TABLE public.profiles OWNER TO gb_user;

--
-- Name: reviews; Type: TABLE; Schema: public; Owner: gb_user
--

CREATE TABLE public.reviews (
    id integer NOT NULL,
    user_id integer NOT NULL,
    order_id integer NOT NULL,
    item_product_id integer NOT NULL,
    review_text text,
    grade public.grade_of_product,
    created_at timestamp without time zone
);


ALTER TABLE public.reviews OWNER TO gb_user;

--
-- Name: reviews_id_seq; Type: SEQUENCE; Schema: public; Owner: gb_user
--

CREATE SEQUENCE public.reviews_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.reviews_id_seq OWNER TO gb_user;

--
-- Name: reviews_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gb_user
--

ALTER SEQUENCE public.reviews_id_seq OWNED BY public.reviews.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: gb_user
--

CREATE TABLE public.users (
    id integer NOT NULL,
    first_name character varying(50) NOT NULL,
    last_name character varying(50) NOT NULL,
    email character varying(120) NOT NULL,
    phone character varying(15) NOT NULL,
    password_hash character varying(100) NOT NULL
);


ALTER TABLE public.users OWNER TO gb_user;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: gb_user
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO gb_user;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gb_user
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: carts id; Type: DEFAULT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.carts ALTER COLUMN id SET DEFAULT nextval('public.carts_id_seq'::regclass);


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- Name: designers id; Type: DEFAULT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.designers ALTER COLUMN id SET DEFAULT nextval('public.designers_id_seq'::regclass);


--
-- Name: items_products id; Type: DEFAULT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.items_products ALTER COLUMN id SET DEFAULT nextval('public.items_products_id_seq'::regclass);


--
-- Name: materials id; Type: DEFAULT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.materials ALTER COLUMN id SET DEFAULT nextval('public.materials_id_seq'::regclass);


--
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


--
-- Name: products id; Type: DEFAULT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- Name: reviews id; Type: DEFAULT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.reviews ALTER COLUMN id SET DEFAULT nextval('public.reviews_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: carts; Type: TABLE DATA; Schema: public; Owner: gb_user
--

COPY public.carts (id, user_id, item_product_id, quantity) FROM stdin;
1	30	39	2
2	58	47	1
3	85	21	1
4	63	23	2
5	24	26	2
6	44	54	3
7	17	13	2
8	29	99	1
9	66	35	2
10	90	52	2
11	31	23	2
12	32	81	2
13	59	19	1
14	42	99	2
15	52	29	2
16	12	32	3
17	75	77	1
18	4	43	2
19	45	33	2
20	96	16	2
21	75	41	1
22	30	1	2
23	37	96	2
24	55	21	2
25	48	87	3
26	100	17	3
27	38	35	2
28	93	31	2
29	30	39	2
30	83	67	2
31	10	14	1
32	23	31	2
33	5	5	2
34	89	30	2
35	94	86	2
36	15	37	1
37	14	77	2
38	46	18	1
39	78	47	1
40	4	87	2
41	7	14	1
42	78	94	2
43	56	50	2
44	2	40	1
45	32	20	1
46	41	100	2
47	16	78	2
48	54	13	1
49	26	14	1
50	89	39	1
51	49	68	1
52	50	49	2
53	94	18	3
54	97	97	1
55	56	31	3
56	91	69	2
57	48	12	2
58	42	79	2
59	92	74	2
60	86	81	3
61	26	7	2
62	76	80	3
63	24	80	2
64	50	27	1
65	3	56	2
66	52	34	1
67	80	76	1
68	21	67	2
69	74	45	1
70	82	65	2
71	16	79	3
72	35	54	3
73	68	62	2
74	4	85	1
75	96	86	2
76	32	65	1
77	24	11	1
78	32	40	1
79	50	80	1
80	65	33	3
81	8	22	2
82	86	42	3
83	23	67	1
84	34	96	2
85	91	69	2
86	23	98	3
87	49	42	1
88	66	67	2
89	86	13	3
90	39	40	2
91	77	82	2
92	27	47	2
93	15	99	2
94	55	72	2
95	91	47	1
96	91	44	2
97	32	78	2
98	27	96	1
99	94	37	2
100	70	42	1
\.


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: gb_user
--

COPY public.categories (id, name) FROM stdin;
1	Dresses
2	Tops
3	Sweaters/Knits
4	Jackets/Coats
5	Blazers
6	Denim
7	Leggings/Pants
8	Skirts/Shorts
9	Accessories
\.


--
-- Data for Name: designers; Type: TABLE DATA; Schema: public; Owner: gb_user
--

COPY public.designers (id, name) FROM stdin;
1	MacKensie Hooper
2	Basia Mosley
3	Seth Wiggins
4	Cooper Frederick
5	Catherine Curtis
6	Baker Huber
7	Emery Pope
8	Tanner Bell
9	Lacey Hobbs
10	Gareth Osborne
11	Kylan Richardson
12	Lane Hays
13	Lynn Gay
14	Unity Gay
15	Kirestin Mcgee
16	Mollie Vang
17	Dominique Davenport
18	Kieran Holman
19	Colt Mathews
20	Yuri Gallegos
21	Quail Nguyen
22	Maryam Love
23	Talon Livingston
24	Simone Shelton
25	Quintessa Welch
26	Ariana Gonzales
27	Dieter Cain
28	Mary Sharpe
29	Kay Key
30	Bryar Bentley
\.


--
-- Data for Name: items_products; Type: TABLE DATA; Schema: public; Owner: gb_user
--

COPY public.items_products (id, product_id, color, size, price) FROM stdin;
1	17	red	XXS	59.36
2	41	orange	XXS	91.00
3	18	yellow	XS	82.70
4	65	green	XS	63.60
5	92	blue	S	57.54
6	5	violet	S	79.58
7	72	pink	M	84.37
8	17	black	M	98.01
9	40	white	L	99.99
10	63	brown	L	50.01
11	15	multicolor	XL	65.87
12	94	red	XL	79.06
13	69	orange	XXL	88.69
14	88	yellow	XXL	58.57
15	41	green	XXS	99.58
16	49	blue	XXS	95.06
17	3	violet	XS	84.95
18	22	pink	XS	73.57
19	52	black	S	62.78
20	44	white	S	51.69
21	42	brown	M	83.19
22	29	multicolor	M	80.67
23	46	red	L	88.77
24	33	orange	L	58.07
25	48	yellow	XL	59.00
26	85	green	XL	56.18
27	63	blue	XXL	57.19
28	63	violet	XXL	69.18
29	65	pink	XXS	50.51
30	76	black	XXS	94.57
31	49	white	XS	84.97
32	100	brown	XS	70.17
33	7	multicolor	S	68.69
34	81	red	S	63.69
35	35	orange	M	55.59
36	57	yellow	M	50.57
37	16	green	L	52.63
38	42	blue	L	91.91
39	49	violet	XL	90.57
40	6	pink	XL	80.80
41	32	black	XXL	85.66
42	44	white	XXL	64.55
43	29	brown	XXS	94.57
44	90	multicolor	XXS	84.57
45	95	red	XS	80.52
46	94	orange	XS	77.96
47	5	yellow	S	60.33
48	86	green	S	62.85
49	38	blue	M	99.23
50	7	violet	M	93.27
51	15	pink	L	74.57
52	38	black	L	62.58
53	86	white	XL	54.33
54	15	brown	XL	54.85
55	25	multicolor	XXL	79.50
56	23	red	XXL	77.04
57	50	orange	XXS	71.56
58	47	yellow	XXS	84.58
59	78	green	XS	94.05
60	41	blue	XS	99.02
61	23	violet	S	82.69
62	48	pink	S	88.55
63	87	black	M	83.00
64	20	white	M	54.54
65	4	brown	L	70.06
66	45	multicolor	L	60.19
67	46	red	XL	66.61
68	27	orange	XL	65.82
69	14	yellow	XXL	82.58
70	39	green	XXL	97.57
71	24	blue	XXS	55.66
72	87	violet	XXS	86.10
73	7	pink	XS	84.84
74	7	black	XS	82.35
75	72	white	S	74.63
76	76	brown	S	54.00
77	85	multicolor	M	84.52
78	14	red	M	69.52
79	13	orange	L	85.57
80	3	yellow	L	88.98
81	69	green	XL	74.87
82	52	blue	XL	66.56
83	10	violet	XXL	66.66
84	71	pink	XXL	55.55
85	65	black	XXS	96.87
86	15	white	XXS	63.56
87	2	brown	XS	54.11
88	4	multicolor	XS	92.61
89	21	red	S	84.54
90	22	orange	S	53.57
91	74	yellow	M	54.22
92	40	green	M	85.56
93	76	blue	L	99.57
94	90	violet	L	74.07
95	81	pink	XL	66.58
96	16	black	XL	52.55
97	47	white	XXL	25.58
98	48	brown	XXL	65.66
99	43	multicolor	XXS	58.47
100	73	red	XXS	54.25
\.


--
-- Data for Name: materials; Type: TABLE DATA; Schema: public; Owner: gb_user
--

COPY public.materials (id, name) FROM stdin;
1	cotton
2	linen
3	denim
4	wool
5	silk
6	polyester
7	leather
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: gb_user
--

COPY public.orders (id, user_id, created_at, status) FROM stdin;
1	43	2021-04-27 23:06:09	in processing
2	45	2021-06-09 23:00:05	in processing
3	85	2021-06-27 04:51:32	awaiting payment
4	60	2021-06-26 09:10:50	awaiting payment
5	44	2021-11-25 22:08:48	assembly
6	89	2022-04-08 17:15:02	assembly
7	85	2021-07-24 17:56:21	sent
8	67	2021-07-05 23:23:22	sent
9	84	2021-10-01 02:53:35	received
10	89	2021-08-11 21:55:15	received
11	51	2021-09-08 07:52:32	canceled
12	34	2021-07-08 19:24:46	canceled
13	78	2022-01-07 18:24:04	in processing
14	64	2021-12-05 17:08:09	in processing
15	70	2021-06-04 00:20:30	awaiting payment
16	62	2022-03-19 19:27:43	awaiting payment
17	46	2022-10-25 23:42:42	assembly
18	84	2022-09-25 05:40:28	assembly
19	86	2022-10-25 22:03:39	sent
20	83	2022-10-15 22:13:06	sent
21	46	2022-07-29 22:29:31	received
22	45	2021-09-27 22:06:28	received
23	29	2022-01-07 08:59:43	canceled
24	13	2021-01-19 04:36:10	canceled
25	38	2022-06-29 03:00:34	in processing
26	4	2022-10-23 00:47:28	in processing
27	68	2021-01-07 11:14:43	awaiting payment
28	79	2022-03-28 21:24:26	awaiting payment
29	70	2022-05-04 06:11:22	assembly
30	54	2022-07-31 06:54:09	assembly
31	4	2022-04-12 13:02:31	sent
32	41	2021-07-17 20:47:03	sent
33	29	2022-11-17 12:30:03	received
34	20	2022-11-16 04:37:33	received
35	93	2021-07-03 04:16:31	canceled
36	39	2022-01-21 10:26:17	canceled
37	86	2022-10-28 00:19:21	in processing
38	86	2022-10-19 15:47:52	in processing
39	23	2022-06-30 04:31:50	awaiting payment
40	73	2021-01-19 01:12:51	awaiting payment
41	4	2021-03-19 09:24:56	assembly
42	80	2021-11-05 12:09:17	assembly
43	22	2022-03-22 01:07:46	sent
44	89	2021-09-25 04:13:23	sent
45	51	2020-12-31 17:27:32	received
46	3	2021-05-05 18:33:51	received
47	59	2022-05-14 21:49:57	canceled
48	3	2022-01-14 13:10:38	canceled
49	34	2021-09-06 18:47:22	in processing
50	83	2022-10-06 16:06:01	in processing
51	32	2022-01-24 22:11:42	awaiting payment
52	100	2022-06-26 13:54:00	awaiting payment
53	14	2022-12-11 07:36:33	assembly
54	73	2021-12-05 15:39:52	assembly
55	66	2022-11-15 01:38:25	sent
56	48	2021-01-19 14:37:00	sent
57	7	2022-09-11 05:50:14	received
58	49	2021-10-06 22:51:28	received
59	15	2021-04-16 00:35:31	canceled
60	15	2021-11-03 11:40:44	canceled
61	4	2021-03-27 02:58:42	in processing
62	94	2021-03-22 11:17:36	in processing
63	17	2022-04-05 14:23:10	awaiting payment
64	65	2022-09-17 18:04:10	awaiting payment
65	94	2022-06-09 09:39:00	assembly
66	63	2022-03-22 18:38:53	assembly
67	70	2022-10-08 02:30:44	sent
68	84	2021-03-23 05:47:45	sent
69	93	2021-11-25 02:08:04	received
70	21	2021-12-15 18:15:19	received
71	29	2022-03-25 08:39:16	canceled
72	83	2022-09-26 22:19:15	canceled
73	74	2021-01-27 01:00:42	in processing
74	74	2021-06-21 22:51:37	in processing
75	99	2021-02-06 06:26:19	awaiting payment
76	66	2021-10-12 00:45:40	awaiting payment
77	84	2022-12-05 09:26:29	assembly
78	45	2022-12-02 22:56:57	assembly
79	57	2021-02-10 17:35:06	sent
80	17	2021-05-26 21:23:18	sent
81	55	2021-01-22 00:26:30	received
82	4	2022-11-04 18:47:59	received
83	20	2021-07-18 23:41:01	canceled
84	71	2022-11-22 22:43:13	canceled
85	92	2021-01-03 12:33:12	in processing
86	90	2022-11-13 04:08:41	in processing
87	70	2021-04-08 10:53:27	awaiting payment
88	15	2021-05-19 11:20:40	awaiting payment
89	97	2022-12-10 01:58:38	assembly
90	15	2022-05-30 17:52:15	assembly
91	17	2022-05-26 16:40:53	sent
92	7	2021-05-16 18:14:04	sent
93	67	2022-05-17 02:10:00	received
94	6	2021-08-09 23:57:24	received
95	80	2022-03-24 09:58:43	canceled
96	62	2021-11-13 18:53:13	canceled
97	44	2021-02-11 06:23:23	in processing
98	62	2022-09-08 05:56:09	in processing
99	35	2022-12-26 13:20:15	awaiting payment
100	26	2022-03-12 05:01:08	awaiting payment
\.


--
-- Data for Name: orders_details; Type: TABLE DATA; Schema: public; Owner: gb_user
--

COPY public.orders_details (order_id, item_product_id, quantity) FROM stdin;
95	50	1
69	48	2
43	10	2
79	97	2
4	82	2
27	39	1
96	42	1
86	7	2
85	51	2
12	19	1
59	38	2
33	81	2
26	45	1
29	42	2
58	94	2
5	73	2
87	39	2
14	78	1
2	21	2
55	27	3
13	17	2
67	14	3
72	84	2
56	25	2
70	57	1
1	27	2
89	23	2
70	80	2
5	24	2
66	39	2
78	20	3
38	62	2
83	30	1
56	73	3
35	32	1
23	38	2
71	75	2
18	84	3
18	74	2
44	72	1
44	83	3
90	44	1
16	56	3
3	61	2
6	17	1
61	26	2
27	43	2
67	15	3
89	8	2
48	19	2
23	69	2
8	35	2
23	28	2
60	6	2
44	37	2
62	49	2
30	71	3
9	40	3
92	100	1
16	77	2
87	28	1
94	38	2
73	38	2
10	39	1
94	11	1
61	2	1
80	35	2
72	65	2
37	93	2
23	82	2
41	65	2
39	28	1
35	27	3
13	4	1
79	28	2
18	39	2
6	85	3
61	25	3
66	99	2
45	55	1
57	63	2
57	16	3
20	19	1
84	93	2
9	17	3
32	71	2
5	23	2
2	88	2
44	32	2
45	84	1
19	60	3
34	71	1
47	46	1
76	43	1
89	84	3
66	50	2
95	11	1
77	90	2
55	16	3
27	51	2
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: gb_user
--

COPY public.products (id, name, gender, descripton, category_id, photo_name, material_id, designer_id) FROM stdin;
1	faucibus ut, nulla.	man	vehicula aliquet libero. Integer in magna. Phasellus dolor	5	oyireqgp73	6	3
2	parturient	man	aliquet, sem ut cursus luctus, ipsum leo elementum	2	utoetkhd32	5	13
3	montes,	woman	Aliquam erat volutpat. Nulla facilisis.	2	hedjeddu87	4	12
4	vulputate dui, nec	woman	ullamcorper viverra. Maecenas iaculis aliquet diam.	2	ldtjdjhw70	1	19
5	non leo.	kids	eget metus eu erat semper rutrum.	2	fngdtuuj06	5	2
6	elit	kids	convallis erat, eget tincidunt dui augue eu tellus. Phasellus elit	5	ywfsonxn83	6	26
7	cursus purus. Nullam	man	at, velit. Pellentesque ultricies dignissim lacus. Aliquam rutrum lorem	4	gteghxmr28	5	21
8	orci. Phasellus dapibus	man	arcu vel quam dignissim pharetra. Nam ac	8	njplhccf97	4	26
9	massa lobortis	woman	magna tellus faucibus leo, in lobortis tellus justo sit	6	takxbayo75	2	26
10	Nulla aliquet. Proin	woman	nec mauris blandit mattis. Cras eget nisi dictum augue	2	rurftmym13	1	30
11	sagittis placerat.	kids	lobortis mauris. Suspendisse aliquet molestie tellus. Aenean egestas	4	ijokfdoh18	2	30
12	euismod	kids	placerat, augue. Sed molestie. Sed id	6	bwyklktq82	5	30
13	dolor sit	man	Donec sollicitudin adipiscing ligula. Aenean gravida	5	zqoentvm15	1	27
14	dictum	man	adipiscing elit. Curabitur sed tortor. Integer aliquam	6	yjnlabwd65	6	20
15	Nullam ut	woman	adipiscing elit. Etiam laoreet, libero et tristique pellentesque, tellus	4	pynvkywf81	4	15
16	nec, imperdiet	woman	cubilia Curae Donec tincidunt. Donec vitae erat vel pede	3	dotsovlj42	2	27
17	molestie sodales. Mauris	kids	pharetra nibh. Aliquam ornare, libero at auctor ullamcorper, nisl arcu	6	qtwehvmb49	6	5
18	egestas nunc	kids	mauris elit, dictum eu, eleifend nec, malesuada ut,	7	urvfugvy13	2	24
19	nec, euismod in,	man	sem semper erat, in consectetuer ipsum	8	vexfailr62	6	20
20	Integer in magna.	man	Mauris eu turpis. Nulla aliquet. Proin velit. Sed malesuada	2	wtmbqlee29	2	19
21	dolor sit amet,	woman	eu, euismod ac, fermentum vel, mauris. Integer sem	6	ndcwbwmt19	3	12
22	ultrices sit	woman	est. Nunc ullamcorper, velit in aliquet	5	sszsjcig07	2	12
23	libero	kids	Nulla dignissim. Maecenas ornare egestas ligula. Nullam feugiat placerat velit.	4	pajwcexp12	3	13
24	ipsum porta	kids	Nullam scelerisque neque sed sem egestas blandit.	9	zbubpvks26	6	18
25	Mauris quis	man	in lobortis tellus justo sit amet nulla.	3	edzdpfjg21	6	16
26	lacinia	man	orci luctus et ultrices posuere cubilia Curae Donec	1	yvrbptuf08	5	3
27	dolor. Donec	woman	metus urna convallis erat, eget tincidunt dui augue eu	6	gvswpjor17	2	20
28	arcu et	woman	sit amet, dapibus id, blandit at, nisi.	3	ghsiteso76	1	24
29	odio	kids	ac, feugiat non, lobortis quis, pede. Suspendisse dui. Fusce	8	qwgzmfdw82	2	1
30	quis	kids	sociosqu ad litora torquent per conubia nostra, per	9	emmcomfn38	2	18
31	Duis risus	man	purus sapien, gravida non, sollicitudin a, malesuada id, erat.	3	iuqsngyn07	3	12
32	elit,	man	ornare egestas ligula. Nullam feugiat placerat velit. Quisque	6	xexncwrf42	6	25
33	a, dui.	woman	tellus. Phasellus elit pede, malesuada vel, venenatis vel,	4	yqytlelq33	2	24
34	in faucibus orci	woman	dolor. Donec fringilla. Donec feugiat metus sit	5	myusovfq66	2	26
35	Quisque	kids	ut erat. Sed nunc est, mollis	8	apjunmie58	6	29
36	non	kids	magna sed dui. Fusce aliquam, enim nec tempus	8	cpltched08	2	1
37	Mauris eu	man	Nam nulla magna, malesuada vel, convallis in, cursus	6	goqqtxry83	6	17
38	consequat, lectus	man	facilisis lorem tristique aliquet. Phasellus fermentum convallis ligula. Donec luctus	2	uolrksbo72	2	23
39	sit	woman	id sapien. Cras dolor dolor, tempus non, lacinia	7	cebdiudt66	6	11
40	Sed	woman	sem egestas blandit. Nam nulla magna, malesuada vel, convallis	5	vdarfrnb35	2	18
41	dictum cursus. Nunc	kids	magna. Praesent interdum ligula eu enim. Etiam imperdiet	5	kysdczty93	2	11
42	et,	kids	vitae, erat. Vivamus nisi. Mauris nulla. Integer urna.	7	mqgilvpf55	6	7
43	tempor	man	magna. Suspendisse tristique neque venenatis lacus. Etiam bibendum fermentum metus.	6	llaksinv26	4	16
44	sodales nisi	man	Fusce mollis. Duis sit amet diam	8	gpztyioz85	4	4
45	Fusce dolor	woman	enim, gravida sit amet, dapibus id, blandit at,	9	jnitisjz42	2	28
46	mauris, aliquam eu,	woman	porttitor eros nec tellus. Nunc	5	pypwbzev56	2	5
47	libero. Proin	kids	lobortis. Class aptent taciti sociosqu ad litora torquent per	3	ugtimuom19	5	12
48	sit	kids	mi. Duis risus odio, auctor vitae,	3	agvebbkm24	2	28
49	nec	man	Duis at lacus. Quisque purus sapien, gravida non, sollicitudin	8	vxytxdnp78	3	18
50	cursus purus. Nullam	man	Phasellus nulla. Integer vulputate, risus	6	mdrtpwoo32	7	30
51	Cras interdum. Nunc	woman	ornare placerat, orci lacus vestibulum lorem, sit	8	tbcmoaiz21	6	1
52	augue malesuada	woman	ultricies dignissim lacus. Aliquam rutrum lorem ac risus.	5	nwjjdfit65	6	20
53	dui lectus	kids	velit. Pellentesque ultricies dignissim lacus. Aliquam rutrum	3	rreppceg08	6	3
54	elementum, dui	kids	ante ipsum primis in faucibus orci luctus	8	sflbppjh15	3	24
55	dui, nec	man	mus. Donec dignissim magna a tortor. Nunc commodo	8	kqmukagy15	6	11
56	congue. In	man	Nam interdum enim non nisi. Aenean	9	mfmjcpqs22	2	19
57	neque.	woman	dolor dolor, tempus non, lacinia at, iaculis quis,	1	aadugvwc55	2	3
58	Nulla facilisi. Sed	woman	Nunc mauris elit, dictum eu, eleifend	6	unpqbysl66	2	18
59	Sed pharetra, felis	kids	dis parturient montes, nascetur ridiculus mus. Donec dignissim magna	3	ygesquws27	2	15
60	purus	kids	sit amet risus. Donec egestas. Aliquam nec enim. Nunc	1	tjigjjgj06	3	11
61	rutrum. Fusce	man	nibh enim, gravida sit amet, dapibus id, blandit at,	4	roquoegt52	4	15
62	nulla vulputate	man	feugiat tellus lorem eu metus.	8	qulxidkf23	2	22
63	placerat velit. Quisque	woman	elementum sem, vitae aliquam eros turpis non	4	eiyskieo32	4	16
64	tempus	woman	lobortis quam a felis ullamcorper viverra. Maecenas	6	pyymsdsm24	4	10
65	dolor.	kids	sagittis augue, eu tempor erat neque	5	nehyyhxd89	5	17
66	ac libero	kids	Cum sociis natoque penatibus et magnis dis	4	hwirveir27	6	7
67	vel, venenatis	man	vel lectus. Cum sociis natoque penatibus et magnis dis parturient	6	fepiuymw25	3	27
68	mollis dui, in	man	eget mollis lectus pede et risus. Quisque libero	6	bfgmyjzo24	2	20
69	a odio semper	woman	aliquet molestie tellus. Aenean egestas hendrerit neque.	3	mgnzqnlc60	6	25
70	pretium neque.	woman	fringilla ornare placerat, orci lacus vestibulum lorem, sit amet	2	cfgxwdkg18	4	16
71	metus. Aenean sed	kids	erat. Sed nunc est, mollis non, cursus non, egestas a,	4	niumdnjx88	3	2
72	eget massa. Suspendisse	kids	Morbi neque tellus, imperdiet non, vestibulum nec, euismod	6	ivtbvqkd25	6	1
73	eu sem.	man	nec, leo. Morbi neque tellus, imperdiet non, vestibulum	5	tijtejtt12	1	30
74	condimentum	man	Donec elementum, lorem ut aliquam iaculis,	8	kjrjclvr72	3	9
75	Aenean egestas hendrerit	woman	ornare sagittis felis. Donec tempor, est ac mattis	9	rolictcm27	3	18
76	facilisis vitae,	woman	dictum eleifend, nunc risus varius	1	ixljbuhk65	7	8
77	interdum. Sed	kids	lacus. Cras interdum. Nunc sollicitudin commodo ipsum. Suspendisse non leo.	3	qqgwuaef16	2	11
78	auctor vitae,	kids	ipsum nunc id enim. Curabitur	1	lwxokdnf85	1	4
79	sed	man	aliquet magna a neque. Nullam ut	8	cxuijuwz64	7	24
80	Pellentesque ut ipsum	man	arcu. Aliquam ultrices iaculis odio. Nam interdum enim non nisi.	3	eicwozmb43	6	30
81	nibh. Quisque	woman	nec enim. Nunc ut erat. Sed nunc est,	7	xqseudxn36	6	14
82	hendrerit	woman	nec urna suscipit nonummy. Fusce fermentum fermentum arcu. Vestibulum	7	exmrthdb68	6	6
83	rhoncus. Nullam	kids	torquent per conubia nostra, per inceptos hymenaeos. Mauris	2	jexdbbbm14	5	8
84	massa. Quisque porttitor	kids	amet nulla. Donec non justo. Proin non massa non	2	gefhubah40	4	22
85	lobortis risus.	man	pharetra nibh. Aliquam ornare, libero at auctor	4	xmroutlm35	5	7
86	elit, a feugiat	man	sed sem egestas blandit. Nam nulla	2	cutxxexg74	6	2
87	amet ante.	woman	eleifend, nunc risus varius orci, in	6	mfqtnqlz27	3	21
88	quam.	woman	libero mauris, aliquam eu, accumsan sed, facilisis vitae, orci.	8	ddynbipc38	3	17
89	feugiat non,	kids	Class aptent taciti sociosqu ad litora torquent per	4	aunslwdk52	4	16
90	tincidunt	kids	nec tellus. Nunc lectus pede,	6	iwbccmnu16	7	3
91	sit	man	eu lacus. Quisque imperdiet, erat	5	drbyjens67	6	30
92	vitae, sodales	man	auctor odio a purus. Duis elementum, dui	1	luqdjvkg15	6	29
93	elit. Curabitur	woman	orci sem eget massa. Suspendisse eleifend.	3	neomgwdt88	6	9
94	elit, a feugiat	woman	ligula consectetuer rhoncus. Nullam velit dui, semper et,	2	ttquclvg31	3	30
95	Nullam ut	kids	laoreet ipsum. Curabitur consequat, lectus sit amet	8	irfdfmkr74	7	19
96	non, bibendum	kids	imperdiet non, vestibulum nec, euismod in, dolor. Fusce feugiat.	8	swlwrkur52	4	24
97	porttitor scelerisque neque.	man	vel, venenatis vel, faucibus id, libero.	3	ktnjrufc42	5	16
98	Praesent luctus. Curabitur	man	Proin vel arcu eu odio tristique	3	zkktuvbd64	3	24
99	dui, nec tempus	woman	lacinia orci, consectetuer euismod est arcu ac orci.	6	ypaexrvt06	2	10
100	mi enim,	woman	nec enim. Nunc ut erat.	4	dljxmmro45	7	8
\.


--
-- Data for Name: profiles; Type: TABLE DATA; Schema: public; Owner: gb_user
--

COPY public.profiles (user_id, date_of_birth, gender, country, city, address, created_at) FROM stdin;
99	2021-06-08	f	Peru	Gdańsk	Ap #580-9843 Ipsum. St.	2022-07-22 05:22:50
65	2021-11-04	f	Austria	Manchester	Ap #146-5848 Purus, St.	2022-07-15 23:23:52
73	2021-02-11	m	France	Serang	873-6193 Non, St.	2022-05-23 15:41:05
37	2021-10-20	m	Colombia	Daly	7839 Convallis Street	2021-08-16 13:02:14
83	2022-11-16	f	United Kingdom	Maracanaú	P.O. Box 514, 840 Dapibus Av.	2021-12-19 09:17:39
58	2021-06-01	f	Turkey	Orenburg	Ap #444-1779 Magna. St.	2022-07-13 05:10:51
18	2022-11-09	m	Mexico	Devonport	P.O. Box 589, 9115 Mi St.	2021-06-09 11:16:06
15	2022-06-10	m	Turkey	Padang Sidempuan	835-6902 Sit St.	2022-04-25 03:26:56
51	2021-04-15	f	India	Ulloa (Barrial]	Ap #204-7083 Enim St.	2021-07-03 16:03:48
92	2021-02-14	f	Canada	Korneuburg	Ap #446-8054 Pellentesque Rd.	2021-11-17 13:06:21
99	2022-02-24	m	Belgium	Cartago	945-6927 Semper St.	2021-05-28 18:32:09
33	2021-08-17	m	Mexico	Astore	Ap #916-340 Eget Road	2021-03-04 09:17:11
85	2021-11-22	f	Belgium	Saint-Dié-des-Vosges	380-7948 Risus. Av.	2021-09-18 22:54:10
69	2022-12-24	f	Italy	Hubli	3685 Orci. Rd.	2021-01-11 14:10:32
40	2021-12-20	m	Colombia	Rangiora	Ap #170-1392 Tincidunt Rd.	2022-10-07 03:16:34
84	2022-07-11	m	Ireland	Villahermosa	8295 Ultricies Ave	2022-09-21 14:17:45
80	2022-12-16	f	Russian Federation	Katsina	767-8114 Eu Rd.	2021-05-02 01:16:31
90	2021-08-19	f	Vietnam	Funtua	6651 Eleifend Avenue	2022-06-02 18:55:33
94	2021-12-14	m	Austria	Magangué	8996 Volutpat Rd.	2022-10-16 07:56:04
34	2022-03-03	m	Australia	Bastia	594-7650 Aliquet St.	2022-11-21 09:55:56
46	2022-03-10	f	Norway	Voronezh	226-3945 A St.	2021-05-25 13:35:27
85	2021-05-20	f	New Zealand	Berhampore	P.O. Box 637, 1984 Rhoncus. St.	2022-09-11 18:39:34
82	2022-10-03	m	China	Jamshedpur	Ap #356-3989 Egestas. Rd.	2022-09-25 15:44:58
99	2022-08-19	m	Pakistan	Siedlce	Ap #957-9518 Magna. Road	2021-09-04 15:20:21
13	2022-12-11	f	Chile	Kisi	P.O. Box 403, 7181 Aliquam St.	2021-09-01 20:29:32
62	2022-12-17	f	Netherlands	Đồng Hới	Ap #708-6214 Enim, St.	2022-06-15 10:12:31
17	2022-06-29	m	New Zealand	Palmerston	328-1718 Aliquam Rd.	2021-02-28 11:40:52
25	2022-11-27	m	Sweden	Barranca	556-1412 Vitae, Street	2021-10-05 04:39:19
86	2022-03-25	f	Norway	Astrakhan	Ap #202-1101 Neque St.	2022-11-22 13:05:11
58	2022-10-20	f	Sweden	Wernigerode	822-8926 Vulputate Road	2022-03-14 08:39:56
46	2022-05-01	m	China	Carmarthen	2400 Nisi St.	2021-09-04 12:56:00
32	2022-08-23	m	Italy	Ulloa (Barrial]	2743 Euismod Av.	2022-02-01 08:15:33
25	2021-04-15	f	Brazil	Tranås	7709 Ut Rd.	2021-02-28 13:12:34
83	2021-11-18	f	South Korea	Skövde	619-7973 Phasellus Av.	2021-07-11 01:37:27
4	2022-05-03	m	Ireland	Semarang	1368 Risus St.	2021-09-04 06:00:22
36	2021-12-18	m	Italy	Paranaguá	8731 Sem. Rd.	2022-02-26 23:44:42
35	2021-10-15	f	Peru	Tver	P.O. Box 385, 4092 Pede Road	2021-12-15 19:30:38
94	2022-01-06	f	Germany	Mazatlán	Ap #114-4384 Quis Street	2022-11-03 06:25:24
93	2022-05-28	m	Pakistan	Daman	941-3183 Eu St.	2022-03-17 03:10:25
98	2021-03-07	m	Mexico	Kurram Agency	Ap #577-7520 Orci Rd.	2021-08-30 14:03:07
17	2022-05-18	f	Colombia	Sète	516-1952 Ornare Rd.	2021-07-05 05:21:53
3	2021-09-29	f	Canada	Delta	Ap #211-1432 Fringilla Ave	2022-03-04 13:10:03
40	2021-09-13	m	Russian Federation	Galway	Ap #422-188 Tempor Ave	2022-02-01 03:34:53
94	2021-07-12	m	United Kingdom	Voronezh	P.O. Box 285, 2981 At, Rd.	2022-09-06 06:00:21
49	2021-02-21	f	Austria	Tây Ninh	252-7155 Montes, Rd.	2021-10-14 04:09:22
36	2022-12-27	f	France	Nova Iguaçu	P.O. Box 800, 585 Purus, Road	2021-05-09 19:40:01
86	2021-07-17	m	Mexico	Pachuca	Ap #542-8048 Aliquam Avenue	2022-11-01 04:34:52
30	2021-05-13	m	Ireland	Montauban	355-9701 In Road	2021-03-01 05:19:51
23	2022-03-16	f	Russian Federation	Anklam	Ap #233-9118 Ultrices, Av.	2022-11-26 17:13:14
83	2021-12-04	f	Costa Rica	Dehri	Ap #470-7960 Quisque Road	2022-09-04 04:58:25
93	2021-02-23	m	Pakistan	Exeter	857-2333 Faucibus Av.	2022-11-21 04:15:10
68	2022-09-12	m	Indonesia	Neustrelitz	Ap #949-3206 Convallis, St.	2021-09-06 21:50:39
41	2021-09-25	f	Indonesia	Suruç	952-7336 Odio, Road	2022-05-20 09:04:58
91	2022-05-18	f	Poland	Fortaleza	Ap #770-4208 Cras Ave	2022-12-18 05:41:02
60	2022-02-17	m	India	Governador Valadares	Ap #807-393 Sem. St.	2021-08-18 17:21:09
90	2021-03-30	m	South Korea	Telford	Ap #612-6865 Cursus. Street	2021-06-01 18:18:48
59	2022-08-05	f	Netherlands	Finspång	P.O. Box 884, 1995 A, Av.	2022-10-30 14:34:07
89	2022-11-11	f	Vietnam	Bitung	1399 A Av.	2021-04-10 05:57:01
18	2022-09-09	m	Indonesia	Mamuju	Ap #159-4654 Faucibus Street	2022-01-19 15:43:22
37	2022-05-03	m	Nigeria	Thionville	Ap #619-8429 Nec, Rd.	2021-10-02 01:14:08
16	2021-01-20	f	France	Novgorod	Ap #890-7740 Etiam Ave	2021-03-10 22:35:53
73	2021-10-01	f	France	Geelong	P.O. Box 720, 3416 Amet, Avenue	2022-05-14 02:34:57
81	2021-02-10	m	Austria	Vienna	157-3916 Egestas. Av.	2022-03-30 13:57:12
42	2021-07-01	m	Pakistan	Timon	P.O. Box 898, 1919 Sed Rd.	2022-03-14 15:45:50
32	2021-05-02	f	Canada	Belfast	341-7034 Scelerisque St.	2022-11-08 11:39:08
84	2022-10-22	f	Sweden	Cork	969-8133 Est. St.	2021-03-08 09:13:53
66	2022-12-20	m	Sweden	Opole	P.O. Box 935, 7065 Mauris Road	2022-02-11 20:09:35
45	2022-06-17	m	Ireland	Calamar	P.O. Box 332, 6364 Enim Road	2022-02-11 00:22:09
39	2021-06-13	f	Spain	Oslo	8138 Non, Av.	2022-06-30 17:45:52
77	2022-11-28	f	Vietnam	Zielona Góra	Ap #643-9750 Est, Ave	2022-03-17 17:05:29
7	2021-04-03	m	South Korea	St. Ives	Ap #840-7416 Dapibus Rd.	2022-03-01 03:15:43
91	2021-10-13	m	Canada	Gols	Ap #457-898 Velit Rd.	2022-07-02 07:48:09
30	2021-10-23	f	United Kingdom	Paço do Lumiar	P.O. Box 721, 1978 Pellentesque Av.	2022-11-17 05:42:32
96	2021-12-28	f	Colombia	Galway	7118 Sed Av.	2022-01-11 15:56:13
98	2022-07-27	m	Turkey	Bến Tre	3099 Fringilla Ave	2022-08-11 23:39:21
70	2022-07-24	m	Italy	Nicoya	174-1910 Luctus Ave	2022-09-19 15:08:25
93	2022-02-04	f	United Kingdom	Chuncheon	Ap #445-3608 Vulputate, Road	2022-11-25 05:49:50
79	2021-02-27	f	Australia	Hattian Bala	8349 Et Rd.	2021-01-26 21:55:24
87	2021-02-21	m	Nigeria	Canberra	Ap #939-3019 Sodales Ave	2021-06-26 10:31:37
36	2021-06-22	m	Russian Federation	Muradiye	Ap #485-3893 Lectus Rd.	2021-06-12 06:43:29
24	2022-03-22	f	Peru	Mazzano Romano	669-9142 Pellentesque Street	2021-06-21 19:01:58
62	2021-02-11	f	Canada	Mexico City	Ap #237-5262 Egestas Avenue	2021-12-03 15:19:58
20	2022-02-13	m	Nigeria	Cork	Ap #934-9956 Eget, Rd.	2021-06-10 12:45:31
94	2022-01-01	m	Colombia	Murmansk	847-9045 Ut St.	2022-05-25 03:58:13
95	2021-01-18	f	China	Recife	P.O. Box 127, 3300 Maecenas Avenue	2022-10-02 15:16:29
29	2021-09-04	f	Ireland	Ottawa	6544 Gravida. Rd.	2022-08-02 11:59:30
64	2021-01-14	m	Vietnam	Gilgit	P.O. Box 831, 9678 Cras St.	2021-03-04 04:51:04
75	2022-09-14	m	Chile	Malakand	P.O. Box 285, 2611 Molestie Av.	2021-05-13 18:10:26
32	2022-08-06	f	Indonesia	Mora	577-2562 Purus Rd.	2022-03-06 16:58:17
15	2022-04-20	f	Pakistan	Beausejour	9707 Commodo Rd.	2022-12-14 13:09:37
98	2021-04-27	m	China	Chiquinquirá	P.O. Box 512, 2793 Sit Road	2021-05-06 22:12:01
99	2021-09-28	m	Russian Federation	Madrid	9004 Ante. Street	2021-03-15 18:29:14
88	2022-09-12	f	Colombia	Logroño	667-3182 Enim Avenue	2021-05-24 19:46:14
7	2022-11-19	f	Ireland	Massa e Cozzile	P.O. Box 594, 2856 Phasellus Road	2021-01-27 02:14:01
20	2022-11-09	m	Norway	Garzón	164-9384 Luctus St.	2021-12-10 02:41:09
94	2022-08-04	m	Mexico	Bahawalpur	652-716 Tortor, Rd.	2022-12-03 15:18:58
80	2021-10-07	f	United States	Garzón	Ap #107-7042 Donec Ave	2021-04-28 21:18:11
29	2021-08-12	f	Costa Rica	Lamorteau	Ap #117-1316 Mauris St.	2021-07-04 14:52:46
43	2021-09-18	m	Nigeria	Sapele	221-8620 Phasellus Road	2022-02-07 16:47:43
34	2021-05-17	m	Italy	Torghar	Ap #876-1464 Lobortis, St.	2021-11-01 15:19:31
\.


--
-- Data for Name: reviews; Type: TABLE DATA; Schema: public; Owner: gb_user
--

COPY public.reviews (id, user_id, order_id, item_product_id, review_text, grade, created_at) FROM stdin;
1	84	90	75	lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada	1	2021-09-10 10:54:50
2	17	25	53	enim. Etiam imperdiet dictum magna. Ut tincidunt orci quis lectus. Nullam	3	2021-02-20 04:44:13
3	75	74	6	Morbi vehicula. Pellentesque tincidunt tempus risus. Donec egestas. Duis ac	3	2022-01-15 04:28:19
4	28	58	8	magnis dis parturient montes, nascetur ridiculus mus. Aenean eget magna. Suspendisse tristique neque venenatis lacus. Etiam	2	2021-04-26 16:51:35
5	51	71	46	mattis. Cras eget nisi dictum augue malesuada malesuada. Integer id magna et ipsum cursus vestibulum. Mauris magna. Duis	5	2021-05-10 18:28:53
6	24	46	47	pharetra nibh. Aliquam ornare, libero at auctor ullamcorper, nisl arcu iaculis	5	2022-04-22 19:01:17
7	34	46	40	malesuada. Integer id magna et ipsum cursus vestibulum. Mauris magna. Duis dignissim tempor arcu. Vestibulum ut eros	2	2022-12-09 20:06:38
8	92	19	30	sem, consequat nec, mollis vitae, posuere at, velit. Cras lorem lorem, luctus ut,	5	2021-09-01 09:34:31
9	39	56	57	nascetur ridiculus mus. Proin vel arcu eu odio tristique pharetra.	3	2021-04-16 20:37:34
10	89	83	43	in felis. Nulla tempor augue ac ipsum. Phasellus vitae mauris sit amet lorem semper auctor. Mauris vel	1	2021-06-14 21:24:06
11	55	2	33	quis, pede. Praesent eu dui. Cum sociis natoque penatibus et magnis dis	4	2021-01-27 20:51:42
12	49	4	65	luctus felis purus ac tellus. Suspendisse sed dolor. Fusce mi lorem, vehicula et, rutrum	1	2022-02-02 22:20:27
13	96	65	16	In nec orci. Donec nibh. Quisque nonummy ipsum non arcu. Vivamus sit amet risus. Donec egestas. Aliquam	2	2021-07-23 05:33:58
14	88	1	65	tincidunt, nunc ac mattis ornare, lectus ante dictum mi, ac mattis velit justo	2	2022-09-12 00:35:35
15	41	40	64	eu tellus. Phasellus elit pede, malesuada vel, venenatis vel, faucibus id, libero.	3	2021-01-29 22:30:12
16	37	59	10	Nunc ut erat. Sed nunc est, mollis non, cursus non, egestas a, dui. Cras pellentesque.	5	2021-01-27 19:08:17
17	91	56	32	dolor. Fusce mi lorem, vehicula et, rutrum eu, ultrices sit amet, risus. Donec nibh	1	2022-11-22 04:24:51
18	81	21	23	dui, semper et, lacinia vitae, sodales at, velit. Pellentesque ultricies dignissim lacus. Aliquam rutrum	3	2022-01-14 14:02:15
19	4	24	25	sit amet risus. Donec egestas. Aliquam nec enim. Nunc ut erat. Sed nunc est,	3	2022-05-25 17:44:28
20	29	40	44	amet risus. Donec egestas. Aliquam nec enim. Nunc ut erat. Sed nunc est, mollis non, cursus non, egestas a,	1	2021-09-19 23:20:35
21	16	76	58	velit. Sed malesuada augue ut lacus. Nulla tincidunt, neque vitae semper egestas, urna justo faucibus lectus, a sollicitudin orci sem	3	2022-09-04 00:07:32
22	24	71	62	dictum placerat, augue. Sed molestie. Sed id risus quis diam luctus lobortis. Class aptent taciti sociosqu ad	2	2021-03-31 15:59:59
23	60	61	12	in aliquet lobortis, nisi nibh lacinia orci, consectetuer euismod est arcu ac orci. Ut semper pretium	5	2021-06-19 21:00:36
24	76	53	56	faucibus orci luctus et ultrices posuere cubilia Curae Donec tincidunt. Donec vitae	5	2022-10-13 21:34:30
25	35	19	37	rhoncus. Proin nisl sem, consequat nec, mollis vitae, posuere at, velit. Cras lorem lorem, luctus	1	2022-05-21 18:52:58
26	5	21	29	pellentesque. Sed dictum. Proin eget odio. Aliquam vulputate ullamcorper magna. Sed eu eros. Nam consequat dolor	4	2021-04-28 03:51:11
27	65	46	27	Donec vitae erat vel pede blandit congue. In scelerisque scelerisque dui. Suspendisse ac metus vitae velit egestas	5	2021-06-09 02:47:16
28	75	20	64	Quisque porttitor eros nec tellus. Nunc lectus pede, ultrices a, auctor non, feugiat nec, diam. Duis	5	2022-07-13 03:38:45
29	33	76	42	ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae Donec tincidunt. Donec vitae erat	1	2021-12-05 23:54:50
30	28	38	55	libero mauris, aliquam eu, accumsan sed, facilisis vitae, orci. Phasellus	2	2021-02-21 18:33:32
31	78	50	24	ipsum nunc id enim. Curabitur massa. Vestibulum accumsan neque et nunc. Quisque ornare	5	2021-03-30 17:35:07
32	85	57	19	eget, dictum placerat, augue. Sed molestie. Sed id risus quis diam luctus lobortis. Class aptent taciti sociosqu	2	2022-07-26 07:25:47
33	9	77	41	nunc sit amet metus. Aliquam erat volutpat. Nulla facilisis. Suspendisse commodo tincidunt nibh. Phasellus	2	2021-10-06 15:02:29
34	73	5	63	posuere vulputate, lacus. Cras interdum. Nunc sollicitudin commodo ipsum. Suspendisse non	3	2022-12-20 13:57:06
35	97	98	26	Quisque libero lacus, varius et, euismod et, commodo at, libero. Morbi accumsan laoreet ipsum.	5	2022-08-24 17:37:37
36	24	7	55	Quisque varius. Nam porttitor scelerisque neque. Nullam nisl. Maecenas malesuada fringilla est. Mauris eu turpis. Nulla aliquet. Proin velit. Sed	3	2022-04-08 17:18:19
37	23	33	65	elementum at, egestas a, scelerisque sed, sapien. Nunc pulvinar arcu et pede. Nunc sed orci lobortis augue scelerisque	1	2021-04-06 18:52:12
38	17	78	19	Integer urna. Vivamus molestie dapibus ligula. Aliquam erat volutpat. Nulla dignissim. Maecenas ornare egestas	2	2021-09-20 15:24:40
39	99	27	18	sit amet ante. Vivamus non lorem vitae odio sagittis semper. Nam tempor diam dictum sapien.	3	2021-11-29 08:39:17
40	27	38	93	semper erat, in consectetuer ipsum nunc id enim. Curabitur massa. Vestibulum accumsan	2	2021-11-30 21:18:42
41	81	35	17	id, mollis nec, cursus a, enim. Suspendisse aliquet, sem ut cursus luctus, ipsum leo elementum sem,	5	2021-01-29 19:26:03
42	21	71	74	non, vestibulum nec, euismod in, dolor. Fusce feugiat. Lorem ipsum dolor sit amet, consectetuer	4	2021-02-05 22:02:39
43	91	48	100	volutpat ornare, facilisis eget, ipsum. Donec sollicitudin adipiscing ligula. Aenean gravida nunc sed pede. Cum	1	2022-12-13 06:55:36
44	100	13	37	egestas. Aliquam nec enim. Nunc ut erat. Sed nunc est, mollis non, cursus non, egestas a, dui. Cras	5	2021-10-01 17:40:39
45	81	4	55	luctus felis purus ac tellus. Suspendisse sed dolor. Fusce mi lorem, vehicula et, rutrum eu,	1	2021-03-10 05:10:24
46	15	89	31	ante blandit viverra. Donec tempus, lorem fringilla ornare placerat, orci lacus vestibulum lorem, sit amet ultricies	5	2022-10-01 08:52:11
47	57	16	56	in consequat enim diam vel arcu. Curabitur ut odio vel est tempor bibendum. Donec	2	2022-09-15 23:34:56
48	27	3	23	ornare tortor at risus. Nunc ac sem ut dolor dapibus gravida. Aliquam tincidunt, nunc ac	5	2021-06-27 00:41:51
49	65	16	45	Curabitur consequat, lectus sit amet luctus vulputate, nisi sem semper erat, in consectetuer ipsum nunc id enim. Curabitur massa.	3	2022-09-08 19:19:02
50	84	85	22	enim, gravida sit amet, dapibus id, blandit at, nisi. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus	5	2021-08-16 19:15:17
51	63	70	69	arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin	2	2022-06-03 15:32:48
52	66	93	56	enim. Suspendisse aliquet, sem ut cursus luctus, ipsum leo elementum	2	2021-06-28 02:09:14
53	29	98	38	ipsum ac mi eleifend egestas. Sed pharetra, felis eget varius ultrices,	3	2021-03-16 02:15:16
54	78	59	23	felis. Donec tempor, est ac mattis semper, dui lectus rutrum urna, nec	3	2022-10-26 16:01:46
55	60	20	40	vitae velit egestas lacinia. Sed congue, elit sed consequat auctor, nunc nulla vulputate dui, nec tempus mauris	5	2021-03-30 14:55:24
56	88	36	60	augue scelerisque mollis. Phasellus libero mauris, aliquam eu, accumsan sed, facilisis	1	2021-12-16 02:24:01
57	74	30	71	nec enim. Nunc ut erat. Sed nunc est, mollis non, cursus non, egestas a,	5	2021-12-27 23:00:13
58	57	78	44	faucibus leo, in lobortis tellus justo sit amet nulla. Donec non justo. Proin non massa non	5	2022-10-01 21:14:34
59	9	90	63	mauris ut mi. Duis risus odio, auctor vitae, aliquet nec,	1	2021-03-16 00:00:57
60	19	28	14	non enim. Mauris quis turpis vitae purus gravida sagittis. Duis	4	2021-05-04 10:20:31
61	75	81	23	in faucibus orci luctus et ultrices posuere cubilia Curae Phasellus ornare. Fusce mollis. Duis sit	5	2022-11-08 12:20:58
62	48	56	34	libero at auctor ullamcorper, nisl arcu iaculis enim, sit amet ornare lectus justo eu arcu. Morbi	4	2022-11-14 14:08:43
63	32	75	68	malesuada fames ac turpis egestas. Fusce aliquet magna a neque. Nullam ut nisi a odio semper cursus. Integer mollis. Integer	5	2022-09-19 03:54:28
64	49	83	48	sollicitudin commodo ipsum. Suspendisse non leo. Vivamus nibh dolor, nonummy ac, feugiat non, lobortis quis, pede. Suspendisse dui. Fusce diam	5	2022-10-11 13:11:11
65	30	6	10	sed pede nec ante blandit viverra. Donec tempus, lorem fringilla ornare placerat, orci lacus vestibulum lorem, sit amet ultricies	2	2021-07-18 04:33:54
66	90	43	4	et, lacinia vitae, sodales at, velit. Pellentesque ultricies dignissim lacus. Aliquam rutrum lorem ac	4	2022-02-10 10:06:07
67	14	87	74	semper, dui lectus rutrum urna, nec luctus felis purus ac tellus. Suspendisse sed dolor. Fusce mi lorem, vehicula	1	2021-12-28 08:37:14
68	16	86	6	magnis dis parturient montes, nascetur ridiculus mus. Aenean eget magna. Suspendisse tristique neque venenatis lacus. Etiam	3	2022-12-23 15:02:54
69	97	75	85	ante lectus convallis est, vitae sodales nisi magna sed dui. Fusce aliquam, enim nec tempus scelerisque, lorem ipsum	2	2021-12-29 20:38:55
70	96	16	73	gravida sagittis. Duis gravida. Praesent eu nulla at sem molestie sodales.	4	2021-09-27 09:53:00
71	91	96	93	lorem semper auctor. Mauris vel turpis. Aliquam adipiscing lobortis risus. In mi pede, nonummy ut, molestie in,	3	2022-05-11 02:11:18
72	86	13	22	convallis in, cursus et, eros. Proin ultrices. Duis volutpat nunc sit amet metus. Aliquam	3	2021-08-31 19:18:57
73	57	97	11	magna. Suspendisse tristique neque venenatis lacus. Etiam bibendum fermentum metus. Aenean sed pede nec ante blandit	3	2021-12-14 19:33:09
74	72	59	83	et nunc. Quisque ornare tortor at risus. Nunc ac sem ut dolor dapibus	5	2022-04-09 13:04:39
75	73	20	31	magna. Suspendisse tristique neque venenatis lacus. Etiam bibendum fermentum metus. Aenean	3	2021-02-28 07:03:45
76	30	89	84	nulla. Integer vulputate, risus a ultricies adipiscing, enim mi tempor lorem, eget mollis lectus pede et risus.	4	2021-01-28 13:02:35
77	91	26	32	tempor augue ac ipsum. Phasellus vitae mauris sit amet lorem semper auctor.	3	2021-03-01 18:10:02
78	40	36	49	non nisi. Aenean eget metus. In nec orci. Donec nibh. Quisque nonummy ipsum non arcu. Vivamus sit	5	2021-01-27 23:14:18
79	93	18	78	tellus. Nunc lectus pede, ultrices a, auctor non, feugiat nec, diam. Duis mi enim, condimentum eget,	1	2022-12-13 19:45:15
80	25	38	62	nibh vulputate mauris sagittis placerat. Cras dictum ultricies ligula. Nullam enim.	3	2021-11-15 12:21:36
81	37	45	95	Sed id risus quis diam luctus lobortis. Class aptent taciti	1	2022-12-20 02:57:06
82	63	43	81	in felis. Nulla tempor augue ac ipsum. Phasellus vitae mauris sit	4	2021-05-22 19:27:03
83	29	23	39	consequat auctor, nunc nulla vulputate dui, nec tempus mauris erat eget ipsum. Suspendisse sagittis. Nullam vitae	1	2021-06-19 05:36:10
84	45	15	69	vitae semper egestas, urna justo faucibus lectus, a sollicitudin orci	1	2021-07-25 06:42:02
85	58	39	39	pede. Nunc sed orci lobortis augue scelerisque mollis. Phasellus libero mauris, aliquam eu, accumsan sed, facilisis vitae, orci.	3	2022-06-19 03:33:20
86	32	75	6	lobortis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos hymenaeos. Mauris ut quam vel sapien	5	2021-08-05 07:35:00
87	6	99	70	at pede. Cras vulputate velit eu sem. Pellentesque ut ipsum ac mi eleifend egestas. Sed pharetra, felis eget varius	5	2021-01-03 02:09:14
88	50	85	4	per inceptos hymenaeos. Mauris ut quam vel sapien imperdiet ornare. In faucibus. Morbi	3	2021-02-15 20:53:46
89	95	37	100	quis diam. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Fusce aliquet magna a	5	2021-03-21 09:32:16
90	92	47	39	lectus sit amet luctus vulputate, nisi sem semper erat, in consectetuer ipsum nunc id enim. Curabitur	1	2021-06-27 14:31:55
91	48	20	42	tempus mauris erat eget ipsum. Suspendisse sagittis. Nullam vitae diam. Proin dolor. Nulla semper tellus id nunc	5	2022-04-16 05:49:58
92	12	10	65	Praesent eu nulla at sem molestie sodales. Mauris blandit enim consequat purus. Maecenas libero	4	2021-12-02 07:00:26
93	22	60	68	semper. Nam tempor diam dictum sapien. Aenean massa. Integer vitae nibh. Donec est mauris, rhoncus id, mollis nec,	4	2021-06-21 16:04:02
94	31	59	13	lorem ut aliquam iaculis, lacus pede sagittis augue, eu tempor erat neque non quam. Pellentesque habitant morbi tristique senectus et	3	2022-01-04 06:52:09
95	43	44	30	scelerisque neque. Nullam nisl. Maecenas malesuada fringilla est. Mauris eu turpis. Nulla	3	2021-07-20 17:10:43
96	38	31	83	et ultrices posuere cubilia Curae Donec tincidunt. Donec vitae erat vel pede blandit congue. In scelerisque scelerisque dui. Suspendisse	5	2021-04-11 21:01:27
97	2	6	36	Cras pellentesque. Sed dictum. Proin eget odio. Aliquam vulputate ullamcorper magna.	4	2022-11-30 01:14:05
98	9	33	39	Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Aliquam fringilla cursus purus. Nullam scelerisque	5	2021-11-27 19:17:01
99	58	20	1	convallis dolor. Quisque tincidunt pede ac urna. Ut tincidunt vehicula risus. Nulla eget metus eu	2	2021-11-25 08:51:56
100	2	27	14	aliquet magna a neque. Nullam ut nisi a odio semper	2	2022-11-17 13:21:28
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: gb_user
--

COPY public.users (id, first_name, last_name, email, phone, password_hash) FROM stdin;
1	Yoshio	Gill	nullam@yahoo.couk	(225) 355-5952	EWC90TYF3474GFPILOIV
2	Beck	Mcleod	odio.tristique@google.ca	1-470-850-8633	XNY77GNQ5284SNCGPHSV
3	Keiko	Jensen	commodo.auctor@aol.net	(203) 961-4204	HTO88FVG1020ATOPMITX
4	Denise	Frank	curabitur.egestas.nunc@outlook.ca	1-376-678-8787	LLH88QPF1479SHQPVBNT
5	Elton	Preston	nunc.risus@google.couk	(394) 416-1353	XYU13MNE1937BDPEWKDV
6	Indigo	Black	pharetra.ut.pharetra@protonmail.ca	(123) 232-6427	QKI95FRS2179SPQCRQFV
7	Kieran	Humphrey	dui@google.org	(711) 198-4824	JBE73RKG7882CZWGBQGE
8	Wayne	Dunlap	sed@icloud.org	1-267-447-8604	PQK45LYW6722JUYXWCJS
9	Haviva	Blevins	ut.erat@yahoo.com	(483) 581-2813	WGA13PDM4202FBEXMXKB
10	Elmo	Emerson	duis.gravida.praesent@icloud.org	(484) 111-3772	TXE26UAE8238NPPTYQLG
11	Carly	Welch	arcu.vivamus@hotmail.net	1-267-556-4718	IVF74OUH8285IWJZPGOM
12	Carissa	Kirby	augue.scelerisque@icloud.ca	1-731-648-6196	WTP32HHM1517EDPFAOIS
13	Faith	Mcmahon	nunc.sed@icloud.net	1-599-819-2238	VNC27LFQ7245ILSUMYZV
14	Lois	Bell	adipiscing.mauris@outlook.edu	1-941-220-3687	LNJ59HYQ2745APOAJVZG
15	Tiger	Little	iaculis.nec.eleifend@google.com	(561) 278-7247	UYY14RIJ1364PFVJPVKW
16	Octavius	Franks	inceptos.hymenaeos@hotmail.ca	(441) 253-8842	OJW02KQD0735BJLUCOCD
17	May	Lewis	nec.metus@icloud.org	1-422-858-4487	PFE58LOK1357FMKLVBYX
18	Ignatius	Underwood	massa@google.edu	1-677-394-3782	BLT66WGY2568RRFKFRDA
19	Chloe	Hurst	et@google.couk	1-553-613-6858	IMO80RPZ1285LHBGXWQJ
20	Nerea	Spencer	congue.turpis.in@hotmail.couk	1-716-316-3189	TUF21JTD0668MEDPKTKO
21	Maia	Sloan	cum.sociis@google.couk	(486) 407-7260	NED56UKC4128DYHPSFQO
22	Cameron	Pugh	dolor.dapibus@yahoo.edu	(112) 166-2574	JRT31EJT7901RUIJGTGR
23	Bryar	Richard	eu@hotmail.org	1-113-787-8113	MNO25PJP7277YVRKVQGE
24	Darrel	Bowers	lacus.cras.interdum@hotmail.ca	(751) 544-7164	IVI14HSV3111MDXFQXPP
25	Solomon	Shaw	sit.amet@outlook.org	(923) 747-1404	VBJ15KVY0656HFMMUKUF
26	Caesar	Vaughn	egestas.ligula@outlook.edu	(613) 410-8705	WVY92NBD6681GOBLFYOD
27	Aidan	Rush	nulla.aliquet@aol.ca	1-414-266-0751	DTM96LIR1043OOFSZGHW
28	Damian	Kidd	ante@google.edu	(842) 217-0156	ILH59JWJ4482EHAHDZQE
29	Stuart	Rose	natoque.penatibus@icloud.edu	1-166-675-4469	GJB87DPT4614HWBIPFCQ
30	Chava	Valdez	eget.dictum.placerat@protonmail.org	1-883-762-6409	HQR83UMJ2445FLHOSBDB
31	Vernon	Dorsey	velit.dui.semper@yahoo.couk	1-387-828-5031	PSM20DWX8221LVFFZTDO
32	Jenna	Sharpe	penatibus.et@hotmail.com	1-541-252-6640	KGP81DUL5477QCNRJNNN
33	Orli	Maldonado	amet@hotmail.couk	1-447-180-1643	ZAE33OJC7721MBLRFBXW
34	Cora	Perkins	rutrum.lorem@yahoo.edu	(224) 933-8880	KNI12OZT9219KFDOYSND
35	Chloe	Carlson	purus.gravida@icloud.couk	(248) 392-0727	BWK24SIT8663DMCPKOJG
36	Tamara	Burke	euismod.urna@hotmail.ca	1-633-706-3957	NCI11VVM8127FKRPKQBE
37	Hanae	Smith	mauris.ut.quam@hotmail.edu	(421) 226-8112	SEY18KYC2225CUJIEMCQ
38	Harlan	Bell	donec.felis@icloud.edu	(504) 607-7135	BGE47HEA6043VCWQQFAW
39	Quail	Cantu	a.enim@aol.couk	1-761-845-1578	XHF28IFV6248TWNDHHCH
40	Piper	Bradley	felis.ullamcorper.viverra@hotmail.couk	1-595-441-6161	GKM41TYG7156RYCXTLNQ
41	Wylie	Wilkinson	elit.aliquam@google.net	1-657-889-5538	JXV17NDI8426XHRYDBKY
42	Caesar	Mckay	pellentesque.ut.ipsum@protonmail.ca	1-773-687-1438	WEB85URN1917RFORWPPO
43	Lacey	Combs	aliquam@google.net	1-493-523-8698	BEZ73TCC7304YIWBFTRM
44	Kibo	Chen	nunc.mauris@outlook.ca	1-414-866-7076	SMW45JWV7157CIPEYIPR
45	Tamekah	Holland	mattis@outlook.ca	(583) 689-6337	OIZ85FLL7716XEBMDPTD
46	Byron	Meyer	feugiat.nec.diam@aol.edu	1-685-675-8857	VMF53MLQ6825TXHUFRLY
47	Adam	Wells	gravida.nunc.sed@hotmail.com	(396) 497-8974	NWE25KHE3831PMGBZFKB
48	Drake	Key	lectus.rutrum@aol.ca	(366) 113-8510	DLP14KEU4951WCFJTCRS
49	Shoshana	Sellers	fames@hotmail.net	1-722-430-0143	FQY42JTZ7445ETBHLQGQ
50	Gray	Contreras	eget.lacus@yahoo.org	1-760-242-6066	HYV44GWR2979MCLKDUBQ
51	Morgan	Harris	et.euismod.et@yahoo.ca	(828) 817-7502	JGV65BTP3463XKCFRGDH
52	Wayne	Hale	velit@icloud.net	1-638-270-8696	NEH33LDH4215WXSQXQQK
53	Lev	Fuller	erat.volutpat@hotmail.couk	1-778-272-1765	HJV85BRW9835OSIQONEH
54	Zephr	Whitney	aliquet@hotmail.ca	1-580-622-5421	STF81FWJ8598BFOYHLPG
55	Victor	Warren	non.cursus.non@aol.com	(212) 616-4931	HII53BAJ2184NGCMMRHL
56	Darrel	Moss	eu.eros.nam@protonmail.net	(419) 778-0440	ULF86LGY8679TDIEQDHE
57	Sylvester	Delaney	posuere.vulputate.lacus@icloud.org	1-653-775-9318	WCB18GBD5202RIGYZIEV
58	Hedda	O'connor	nec.malesuada.ut@protonmail.ca	(634) 559-8088	XVI38PGJ8634NWIZQOBS
59	Omar	Vaughan	orci.consectetuer.euismod@hotmail.net	(712) 266-8256	BVM20MFP1365BIJCQFSX
60	Sara	Wall	vel.arcu@aol.couk	(831) 292-8776	YLT34ZND5532TCWIPIVY
61	Piper	Nunez	neque.et.nunc@icloud.com	(584) 522-3525	FVP57QPU2475NXILNPDT
62	Jerry	Maddox	in.condimentum@hotmail.com	1-594-323-3557	HZR54IFJ9112XDILPXHF
63	Miriam	Washington	libero@yahoo.com	1-713-823-9121	TJI53JTL8069QABFRVWF
64	Ashely	Young	et.ultrices@outlook.edu	(861) 938-6598	UKS95VPO7873KFMQIYXO
65	Caryn	Douglas	sagittis@google.ca	1-642-584-4787	CLU97CNA4863FQVZKAQV
66	Addison	Buchanan	ac.mattis@google.org	(977) 717-6926	WXK70OJI1138SMIHETDL
67	Tamekah	Flores	mollis.vitae@icloud.edu	(223) 557-8824	QBP56UBH7625JIOSOYIS
68	Halla	Vaughan	lorem.ipsum@google.couk	1-148-762-5057	QWT68DHH7650YFYWLYWG
69	Griffith	Foreman	faucibus.orci@outlook.edu	1-212-267-8351	KWX51DTR6778HKQTPYIR
70	Malachi	Soto	a@yahoo.net	(341) 213-7348	YQR21MMU4167WRKRYDYV
71	Wendy	Dodson	magna.sed@google.edu	1-682-817-2181	EFQ05BGE1436RRFFOQLE
72	Seth	Love	egestas.hendrerit@icloud.org	(994) 147-2522	PWU15VOE2846WLVKSGTO
73	Sigourney	Bradley	gravida@google.couk	(584) 326-1539	ZGT98RGR7016SKSXNQKS
74	Caldwell	Rios	at.arcu@hotmail.edu	1-251-234-8182	FHF47DYL7814JXYLRIET
75	Drew	Riley	ante.bibendum@hotmail.couk	(521) 345-8411	LBG36KKR2447XPBNUNSV
76	Elaine	Collins	felis.nulla@hotmail.org	1-747-868-5035	HHO47YNU5162GXQSXPHQ
77	Suki	Fields	aenean.sed@aol.net	(644) 185-2273	MRF82YLN5025MLYSYCYG
78	Summer	Hancock	sapien@google.com	1-669-475-2358	PCH42QXU5968CUNQCRHF
79	Warren	Cook	malesuada.fames@icloud.couk	(840) 855-1693	ZNK13PAG2833JAMGPKQD
80	Neil	Osborn	lacus@aol.ca	(380) 858-7264	SGP03RCD1806QKYWXEVV
81	Veronica	Burnett	in.consectetuer.ipsum@hotmail.org	1-868-288-5089	GIT14QIL4405NNIPVSLR
82	Desirae	Moon	varius.orci@google.ca	1-253-260-8651	WZV96LJL4242LGLFHDBQ
83	Stella	Cleveland	fusce.aliquam.enim@google.couk	(104) 877-6787	PDU98LHD6262MREYQYFT
84	William	Farrell	netus@protonmail.com	1-350-564-0787	WVS93MPZ7045QCDDQRLS
85	Aquila	Nicholson	metus.aenean.sed@google.com	(883) 348-6682	RQR71KXA2868KUCYDPKR
86	Cheyenne	Deleon	libero.est.congue@hotmail.edu	1-618-555-3525	BEH67RDV5082FQQNTALW
87	Walter	Snow	vitae.posuere.at@icloud.ca	(366) 545-5836	XKC51QXE4568VZHQNFOG
88	Alexandra	Austin	a.aliquet.vel@yahoo.net	1-554-239-7876	VST15LMU4571VNEGUVKJ
89	Nayda	Parker	auctor.vitae.aliquet@hotmail.com	1-286-483-9061	XDR61TFY5002FRFRLMOT
90	Zelda	Franklin	ornare.libero.at@outlook.org	(206) 481-6462	WDO19OEH0323RXCHIWKK
91	Aimee	Frost	nonummy.ipsum@google.org	(478) 648-8818	HPL55LQX9851WQFPQSWG
92	Octavius	Willis	proin.mi.aliquam@hotmail.com	(269) 744-8274	IBV76MPD7418GYBTJQXB
93	Anika	Cervantes	erat@hotmail.org	1-446-985-8977	WHU01GGN9583SXLTGDXU
94	Jordan	Rodgers	egestas@google.couk	(355) 579-5213	NIJ92SUQ8317IBZKBEWM
95	Buckminster	Ramsey	neque@outlook.com	(621) 861-2511	EEE62RUQ8693SFJOTLXJ
96	Hashim	Meyer	pharetra@yahoo.edu	1-391-763-3227	JZD30DFD2038KZMKUPHU
97	Jordan	Fry	nullam.ut.nisi@yahoo.com	1-187-377-8496	ADO48EUP6384SEDCXIIZ
98	Griffin	Bean	odio.auctor@outlook.com	(471) 861-8897	WAI66MKM3297JDVJZTJL
99	Diana	Haney	cursus.et@yahoo.couk	1-514-641-4365	DRJ47DYG5822JXMQMSGV
100	Charity	Cain	interdum@icloud.edu	1-725-431-6662	MRY35LZT4141SOIXOCNP
\.


--
-- Name: carts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gb_user
--

SELECT pg_catalog.setval('public.carts_id_seq', 100, true);


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gb_user
--

SELECT pg_catalog.setval('public.categories_id_seq', 9, true);


--
-- Name: designers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gb_user
--

SELECT pg_catalog.setval('public.designers_id_seq', 30, true);


--
-- Name: items_products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gb_user
--

SELECT pg_catalog.setval('public.items_products_id_seq', 100, true);


--
-- Name: materials_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gb_user
--

SELECT pg_catalog.setval('public.materials_id_seq', 7, true);


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gb_user
--

SELECT pg_catalog.setval('public.orders_id_seq', 100, true);


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gb_user
--

SELECT pg_catalog.setval('public.products_id_seq', 100, true);


--
-- Name: reviews_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gb_user
--

SELECT pg_catalog.setval('public.reviews_id_seq', 100, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gb_user
--

SELECT pg_catalog.setval('public.users_id_seq', 100, true);


--
-- Name: carts carts_pkey; Type: CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.carts
    ADD CONSTRAINT carts_pkey PRIMARY KEY (id);


--
-- Name: categories categories_name_key; Type: CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_name_key UNIQUE (name);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: designers designers_name_key; Type: CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.designers
    ADD CONSTRAINT designers_name_key UNIQUE (name);


--
-- Name: designers designers_pkey; Type: CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.designers
    ADD CONSTRAINT designers_pkey PRIMARY KEY (id);


--
-- Name: items_products items_products_pkey; Type: CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.items_products
    ADD CONSTRAINT items_products_pkey PRIMARY KEY (id);


--
-- Name: materials materials_name_key; Type: CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.materials
    ADD CONSTRAINT materials_name_key UNIQUE (name);


--
-- Name: materials materials_pkey; Type: CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.materials
    ADD CONSTRAINT materials_pkey PRIMARY KEY (id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: products products_photo_name_key; Type: CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_photo_name_key UNIQUE (photo_name);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: reviews reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_pkey PRIMARY KEY (id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_phone_key; Type: CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_phone_key UNIQUE (phone);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

