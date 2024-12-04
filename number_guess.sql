--
-- PostgreSQL database dump
--

-- Dumped from database version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)
-- Dumped by pg_dump version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)

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

DROP DATABASE number_guess;
--
-- Name: number_guess; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE number_guess WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE number_guess OWNER TO freecodecamp;

\connect number_guess

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
-- Name: gamelog; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.gamelog (
    game_id integer NOT NULL,
    user_id integer NOT NULL,
    games_played integer NOT NULL,
    number_of_guesses integer NOT NULL
);


ALTER TABLE public.gamelog OWNER TO freecodecamp;

--
-- Name: gamelog_game_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.gamelog_game_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.gamelog_game_id_seq OWNER TO freecodecamp;

--
-- Name: gamelog_game_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.gamelog_game_id_seq OWNED BY public.gamelog.game_id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    username character varying(22) NOT NULL
);


ALTER TABLE public.users OWNER TO freecodecamp;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_user_id_seq OWNER TO freecodecamp;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- Name: gamelog game_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.gamelog ALTER COLUMN game_id SET DEFAULT nextval('public.gamelog_game_id_seq'::regclass);


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- Data for Name: gamelog; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.gamelog VALUES (1, 1, 1, 451);
INSERT INTO public.gamelog VALUES (2, 1, 2, 150);
INSERT INTO public.gamelog VALUES (3, 2, 1, 957);
INSERT INTO public.gamelog VALUES (4, 2, 2, 402);
INSERT INTO public.gamelog VALUES (5, 1, 3, 813);
INSERT INTO public.gamelog VALUES (6, 1, 4, 773);
INSERT INTO public.gamelog VALUES (7, 1, 5, 124);
INSERT INTO public.gamelog VALUES (8, 3, 1, 935);
INSERT INTO public.gamelog VALUES (9, 3, 2, 638);
INSERT INTO public.gamelog VALUES (10, 4, 1, 227);
INSERT INTO public.gamelog VALUES (11, 4, 2, 977);
INSERT INTO public.gamelog VALUES (12, 3, 3, 109);
INSERT INTO public.gamelog VALUES (13, 3, 4, 78);
INSERT INTO public.gamelog VALUES (14, 3, 5, 866);
INSERT INTO public.gamelog VALUES (15, 5, 1, 999);
INSERT INTO public.gamelog VALUES (16, 5, 2, 618);
INSERT INTO public.gamelog VALUES (17, 6, 1, 643);
INSERT INTO public.gamelog VALUES (18, 6, 2, 925);
INSERT INTO public.gamelog VALUES (19, 5, 3, 398);
INSERT INTO public.gamelog VALUES (20, 5, 4, 364);
INSERT INTO public.gamelog VALUES (21, 5, 5, 958);
INSERT INTO public.gamelog VALUES (22, 7, 1, 519);
INSERT INTO public.gamelog VALUES (23, 7, 2, 922);
INSERT INTO public.gamelog VALUES (24, 8, 1, 808);
INSERT INTO public.gamelog VALUES (25, 8, 2, 370);
INSERT INTO public.gamelog VALUES (26, 7, 3, 272);
INSERT INTO public.gamelog VALUES (27, 7, 4, 813);
INSERT INTO public.gamelog VALUES (28, 7, 5, 225);
INSERT INTO public.gamelog VALUES (29, 9, 1, 46);
INSERT INTO public.gamelog VALUES (30, 9, 2, 309);
INSERT INTO public.gamelog VALUES (31, 10, 1, 832);
INSERT INTO public.gamelog VALUES (32, 10, 2, 246);
INSERT INTO public.gamelog VALUES (33, 9, 3, 670);
INSERT INTO public.gamelog VALUES (34, 9, 4, 265);
INSERT INTO public.gamelog VALUES (35, 9, 5, 62);
INSERT INTO public.gamelog VALUES (36, 1, 6, 8);
INSERT INTO public.gamelog VALUES (37, 1, 7, 14);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.users VALUES (1, 'user_1733253460488');
INSERT INTO public.users VALUES (2, 'user_1733253460487');
INSERT INTO public.users VALUES (3, 'user_1733253517511');
INSERT INTO public.users VALUES (4, 'user_1733253517510');
INSERT INTO public.users VALUES (5, 'user_1733253863023');
INSERT INTO public.users VALUES (6, 'user_1733253863022');
INSERT INTO public.users VALUES (7, 'user_1733254216974');
INSERT INTO public.users VALUES (8, 'user_1733254216973');
INSERT INTO public.users VALUES (9, 'user_1733254664328');
INSERT INTO public.users VALUES (10, 'user_1733254664327');
INSERT INTO public.users VALUES (11, 'user_1733255126267');
INSERT INTO public.users VALUES (12, 'user_1733255126266');
INSERT INTO public.users VALUES (13, 'user_1733255126266');
INSERT INTO public.users VALUES (14, 'user_1733255138527');
INSERT INTO public.users VALUES (15, 'user_1733255138526');
INSERT INTO public.users VALUES (16, 'user_1733255138526');
INSERT INTO public.users VALUES (17, 'user_1733255160489');
INSERT INTO public.users VALUES (18, 'user_1733255160488');
INSERT INTO public.users VALUES (19, 'user_1733255160488');
INSERT INTO public.users VALUES (20, 'user_1733255219616');
INSERT INTO public.users VALUES (21, 'user_1733255219615');
INSERT INTO public.users VALUES (22, 'user_1733255219615');
INSERT INTO public.users VALUES (23, 'user_1733316744535');
INSERT INTO public.users VALUES (24, 'user_1733316744534');
INSERT INTO public.users VALUES (25, 'user_1733316744534');
INSERT INTO public.users VALUES (26, 'user_1733316904202');
INSERT INTO public.users VALUES (27, 'user_1733316904202');
INSERT INTO public.users VALUES (28, 'user_1733316904203');
INSERT INTO public.users VALUES (29, 'user_1733316904203');


--
-- Name: gamelog_game_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.gamelog_game_id_seq', 37, true);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.users_user_id_seq', 29, true);


--
-- Name: gamelog gamelog_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.gamelog
    ADD CONSTRAINT gamelog_pkey PRIMARY KEY (game_id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: gamelog gamelog_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.gamelog
    ADD CONSTRAINT gamelog_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- PostgreSQL database dump complete
--

