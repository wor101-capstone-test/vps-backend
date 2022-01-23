--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: characters; Type: TABLE; Schema: public; Owner: wor101
--

CREATE TABLE public.characters (
    id integer NOT NULL,
    player_character boolean DEFAULT false,
    name character varying(150) NOT NULL,
    picture_link text,
    stat_block_name character varying(150),
    stat_block_link text,
    main_location integer,
    alignment character varying(50),
    ancestory character varying(150),
    gender character varying(150),
    short_description text,
    CONSTRAINT characters_alignment_check CHECK (((alignment)::text = ANY ((ARRAY['Lawful Good'::character varying, 'Lawful Neutral'::character varying, 'Lawful Evil'::character varying, 'Neutral Good'::character varying, 'True Neutral'::character varying, 'Neutral Evil'::character varying, 'Chaotic Good'::character varying, 'Chaotic Neutral'::character varying, 'Chaotic Evil'::character varying])::text[])))
);


ALTER TABLE public.characters OWNER TO wor101;

--
-- Name: characters_id_seq; Type: SEQUENCE; Schema: public; Owner: wor101
--

CREATE SEQUENCE public.characters_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.characters_id_seq OWNER TO wor101;

--
-- Name: characters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wor101
--

ALTER SEQUENCE public.characters_id_seq OWNED BY public.characters.id;


--
-- Name: characters_interactions; Type: TABLE; Schema: public; Owner: wor101
--

CREATE TABLE public.characters_interactions (
    id integer NOT NULL,
    character_id integer NOT NULL,
    interaction_id integer NOT NULL
);


ALTER TABLE public.characters_interactions OWNER TO wor101;

--
-- Name: characters_interactions_id_seq; Type: SEQUENCE; Schema: public; Owner: wor101
--

CREATE SEQUENCE public.characters_interactions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.characters_interactions_id_seq OWNER TO wor101;

--
-- Name: characters_interactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wor101
--

ALTER SEQUENCE public.characters_interactions_id_seq OWNED BY public.characters_interactions.id;


--
-- Name: interactions; Type: TABLE; Schema: public; Owner: wor101
--

CREATE TABLE public.interactions (
    id integer NOT NULL,
    attitude character varying(25),
    date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    short_description character varying(250) NOT NULL,
    full_description text,
    CONSTRAINT interactions_attitude_check CHECK (((attitude)::text = ANY ((ARRAY['friendly'::character varying, 'indifferent'::character varying, 'hostile'::character varying])::text[])))
);


ALTER TABLE public.interactions OWNER TO wor101;

--
-- Name: interactions_id_seq; Type: SEQUENCE; Schema: public; Owner: wor101
--

CREATE SEQUENCE public.interactions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.interactions_id_seq OWNER TO wor101;

--
-- Name: interactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wor101
--

ALTER SEQUENCE public.interactions_id_seq OWNED BY public.interactions.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: wor101
--

CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying(50) NOT NULL,
    password text NOT NULL,
    email text,
    status text DEFAULT 'pending'::text NOT NULL,
    CONSTRAINT users_status_check CHECK ((status = ANY (ARRAY['pending'::text, 'user'::text, 'admin'::text])))
);


ALTER TABLE public.users OWNER TO wor101;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: wor101
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO wor101;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wor101
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: characters id; Type: DEFAULT; Schema: public; Owner: wor101
--

ALTER TABLE ONLY public.characters ALTER COLUMN id SET DEFAULT nextval('public.characters_id_seq'::regclass);


--
-- Name: characters_interactions id; Type: DEFAULT; Schema: public; Owner: wor101
--

ALTER TABLE ONLY public.characters_interactions ALTER COLUMN id SET DEFAULT nextval('public.characters_interactions_id_seq'::regclass);


--
-- Name: interactions id; Type: DEFAULT; Schema: public; Owner: wor101
--

ALTER TABLE ONLY public.interactions ALTER COLUMN id SET DEFAULT nextval('public.interactions_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: wor101
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: characters; Type: TABLE DATA; Schema: public; Owner: wor101
--

COPY public.characters (id, player_character, name, picture_link, stat_block_name, stat_block_link, main_location, alignment, ancestory, gender, short_description) FROM stdin;
2	f	Bernhard 'Badger' Ilmatoivia	\N	knight	\N	15	Lawful Neutral	human	male	Maintains a good reputation as a man of character. This ex-adventurer runs Badger's and is rumoured to be fabulously wealthy.
3	f	Henni Eronen	\N	scout	\N	8	Chaotic Good	human	female	Runs Eronen's Safe Travels. A former adventurer, Henni is extremely knowledgeable about the town’s surrounds.
4	f	Kerttuli Ilmarinen	\N	Braalite priest	\N	14	Neutral Evil	human	female	Works at the Crooked House by day and venerates Braal by night in the house's deepest, mould-ridden cellar.
6	f	Nurlon Rekunen	\N	veteran	\N	4	Lawful Good	half-elf	male	Runs the Dancing Bear which caters to adventurers and travellers. He is a former adventurer and Nalthra’s twin.
7	f	Orkus Darzak	\N	priest	\N	11	Chaotic Evil	dwarf	male	Worships Braal by animating the dead of Dulwich. Driven insane while adventuring in Gloamhold, Orkus lurks in the tunnels and catacombs beneath the cemetery.
8	f	Ossi Karppanen	\N	commoner	\N	3	Lawful Neutral	human	male	Leads the lumber guild, and seeks to instate a ruling council of merchants. He is one of Dulwich's richest citizens, and consequently has much power and influence.
9	f	Saini Alanen	\N	wizard	\N	9	Neutral Good	human	female	Oversees a small, independent library where she conducts research on the local area and assists in political matters.
10	f	Tuula Tenhunen	\N	knight	\N	1	Lawful Neutral	half-orc	female	Leads the town guard and is fiercely loyal to Wido Gall. She has the nick-name the “Iron Maiden” due to the mask she always wears.
11	f	Valto Ilakka	\N	assassin	\N	16	Neutral Evil	human	male	Runs the Three Bells, and is a mass murderer who preys on patrons that won't be missed.
12	f	Voitto Markku	\N	spy	\N	7	Lawful Evil	human	male	Leads the Shadow Spiders. He is an odious, dangerous fellow.
13	f	Vuokko Laiten	\N	priest	\N	2	Lawful Neutral	human	female	Serves as Conn's high priestess in Dulwich, She is young for the role, and some see her as unsuitable. Both Wido Gall and the merchants vie for her favour.
14	f	Wido Gall	\N	mage	\N	1	Lawful Neutral	human	male	Rules  Dulwich.  He seeks to extend his influence to the nearby village of Longbridge, at the expense of his rivals.
15	f	Zado	\N	unknown	\N	11	Chaotic Neutral	human	male	Plies his trade in the marketplace as a street performer or, perhaps, street performers. However, this enigmatic performer's real trade is in secrets and information.
16	t	Celestria Loman	\N	barbarian	\N	\N	\N	half-orc	female	\N
17	t	Violet Challenger	\N	rogue	\N	\N	\N	halfling	male	\N
18	t	Durrakos	\N	necromancer	\N	\N	\N	dragonborn	male	\N
19	t	Harold Charger	\N	ranger	\N	\N	\N	human	male	\N
20	t	Orsik Ironfist	\N	fighter	\N	\N	\N	dwarf	male	\N
28	f	Jani Ahokas		Commoner		0	Lawful Good	Human	\N	Jani's father Taisto Ahokas was recently killed by an owlbear. The party discovered the remains of Taisto and returned his leg, boots, and dagger to Jani. Jani now seeks to make his way in the world by any means possible.
1	f	Almina Mastonen		spy		6	Lawful Good	halfling	female	Runs a crew of burglars calling themselves the Black Cats. She works at the East Gate inn.
40	t	Barco the Barbarian	Muscle Dude	Barbarian	no link	0	Chaotic Good	Human	Male	Barco crush stuff.
\.


--
-- Data for Name: characters_interactions; Type: TABLE DATA; Schema: public; Owner: wor101
--

COPY public.characters_interactions (id, character_id, interaction_id) FROM stdin;
3	10	2
4	14	2
5	8	3
6	14	3
7	13	4
8	8	4
9	14	4
104	18	14
105	19	14
106	20	14
107	28	14
55	10	1
56	12	1
57	1	1
\.


--
-- Data for Name: interactions; Type: TABLE DATA; Schema: public; Owner: wor101
--

COPY public.interactions (id, attitude, date, short_description, full_description) FROM stdin;
2	friendly	2021-07-08 18:38:21.882479	Loyal Servant	Tuula leads the town guard and is fiercly loyal to the ruler of Dulwhich Wido Gall.
3	hostile	2021-07-08 18:38:21.882479	Political Rivalry	Ossi seeks to instate a ruling council of merchants in Dulwhich and remove Wido Gall from power.
4	indifferent	2021-07-08 18:38:21.882479	Stuck Between Political Rivals	Both the merchants led by Ossi and the ruler Wido Gall seek Vuokko's endorsment as high priestess of Conn in order to consolidate power.
1	hostile	1900-01-01 12:00:00	Illicit Rivalry	Almina's gang the Black Cats is being pressured by the Shadow Spiders, led by Voitto Markku, to give them a portion of their ill gotten gains. She wishes to see the Shadowspiders undone. Almina has recently enlisted Tuula for assistance.
14	hostile	1900-01-01 12:00:00	Heartless Heroics	Party returned the foot of his dead father to Jani. Jani sad :-(
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: wor101
--

COPY public.users (id, username, password, email, status) FROM stdin;
8	admin	$2a$12$f5I1skvBkm19tPkeEOCiHuhJB7dVme7glAleORq5dFC5tGgxA4tZG	admin@email.com	admin
9	wor101	$2a$12$ggONKt/oqT4DLzR6PaA1De2b2wQuJxLbWarG9.PKzjDA27AB..pWS	fake_email@gmail.com	admin
10	pending_user	$2a$12$Z1/J7LW6Ej/chOmQxmBJAOlUj2Va.4RQOFzcYbtDIrCJ4P6AQeU/a	pending_user@email.com	pending
13	test-user	$2a$12$0.66yNCZfHKWqBZg1bVGZe6sfexNVJOlYLckhCsGX6Z/N1jnV/DNe	test_user@email.com	pending
12	regular_user	$2a$12$lEX8.7J/cfcqtDcNNgAejuPEgY6pCesGRPIAZYVk2SVTtjzrJZT1K	regular_user@email.com	user
\.


--
-- Name: characters_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wor101
--

SELECT pg_catalog.setval('public.characters_id_seq', 58, true);


--
-- Name: characters_interactions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wor101
--

SELECT pg_catalog.setval('public.characters_interactions_id_seq', 127, true);


--
-- Name: interactions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wor101
--

SELECT pg_catalog.setval('public.interactions_id_seq', 21, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wor101
--

SELECT pg_catalog.setval('public.users_id_seq', 15, true);


--
-- Name: characters_interactions characters_interactions_pkey; Type: CONSTRAINT; Schema: public; Owner: wor101
--

ALTER TABLE ONLY public.characters_interactions
    ADD CONSTRAINT characters_interactions_pkey PRIMARY KEY (id);


--
-- Name: characters characters_pkey; Type: CONSTRAINT; Schema: public; Owner: wor101
--

ALTER TABLE ONLY public.characters
    ADD CONSTRAINT characters_pkey PRIMARY KEY (id);


--
-- Name: interactions interactions_pkey; Type: CONSTRAINT; Schema: public; Owner: wor101
--

ALTER TABLE ONLY public.interactions
    ADD CONSTRAINT interactions_pkey PRIMARY KEY (id);


--
-- Name: users unique_username; Type: CONSTRAINT; Schema: public; Owner: wor101
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT unique_username UNIQUE (username);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: wor101
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: characters_interactions characters_interactions_interaction_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: wor101
--

ALTER TABLE ONLY public.characters_interactions
    ADD CONSTRAINT characters_interactions_interaction_id_fkey FOREIGN KEY (interaction_id) REFERENCES public.interactions(id) ON DELETE CASCADE;


--
-- Name: characters_interactions charcters_interactions_character_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: wor101
--

ALTER TABLE ONLY public.characters_interactions
    ADD CONSTRAINT charcters_interactions_character_id_fkey FOREIGN KEY (character_id) REFERENCES public.characters(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

