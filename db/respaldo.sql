--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
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
-- Name: cache; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cache (
    key character varying(255) NOT NULL,
    value text NOT NULL,
    expiration integer NOT NULL
);


ALTER TABLE public.cache OWNER TO postgres;

--
-- Name: cache_locks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cache_locks (
    key character varying(255) NOT NULL,
    owner character varying(255) NOT NULL,
    expiration integer NOT NULL
);


ALTER TABLE public.cache_locks OWNER TO postgres;

--
-- Name: categorias; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categorias (
    "idCategoria" bigint NOT NULL,
    "idUsuario" bigint NOT NULL,
    nombre character varying(255) NOT NULL,
    "fechaCreacion" timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.categorias OWNER TO postgres;

--
-- Name: categorias_idCategoria_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."categorias_idCategoria_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."categorias_idCategoria_seq" OWNER TO postgres;

--
-- Name: categorias_idCategoria_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."categorias_idCategoria_seq" OWNED BY public.categorias."idCategoria";


--
-- Name: failed_jobs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.failed_jobs (
    id bigint NOT NULL,
    uuid character varying(255) NOT NULL,
    connection text NOT NULL,
    queue text NOT NULL,
    payload text NOT NULL,
    exception text NOT NULL,
    failed_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.failed_jobs OWNER TO postgres;

--
-- Name: failed_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.failed_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.failed_jobs_id_seq OWNER TO postgres;

--
-- Name: failed_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.failed_jobs_id_seq OWNED BY public.failed_jobs.id;


--
-- Name: historial_tareas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.historial_tareas (
    "idHistorial" bigint NOT NULL,
    "idTareas" bigint NOT NULL,
    "idUsuario" bigint NOT NULL,
    accion character varying(255) NOT NULL,
    detalle_cambio text NOT NULL,
    "fechaCambio" timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.historial_tareas OWNER TO postgres;

--
-- Name: historial_tareas_idHistorial_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."historial_tareas_idHistorial_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."historial_tareas_idHistorial_seq" OWNER TO postgres;

--
-- Name: historial_tareas_idHistorial_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."historial_tareas_idHistorial_seq" OWNED BY public.historial_tareas."idHistorial";


--
-- Name: job_batches; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.job_batches (
    id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    total_jobs integer NOT NULL,
    pending_jobs integer NOT NULL,
    failed_jobs integer NOT NULL,
    failed_job_ids text NOT NULL,
    options text,
    cancelled_at integer,
    created_at integer NOT NULL,
    finished_at integer
);


ALTER TABLE public.job_batches OWNER TO postgres;

--
-- Name: jobs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.jobs (
    id bigint NOT NULL,
    queue character varying(255) NOT NULL,
    payload text NOT NULL,
    attempts smallint NOT NULL,
    reserved_at integer,
    available_at integer NOT NULL,
    created_at integer NOT NULL
);


ALTER TABLE public.jobs OWNER TO postgres;

--
-- Name: jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.jobs_id_seq OWNER TO postgres;

--
-- Name: jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.jobs_id_seq OWNED BY public.jobs.id;


--
-- Name: migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.migrations (
    id integer NOT NULL,
    migration character varying(255) NOT NULL,
    batch integer NOT NULL
);


ALTER TABLE public.migrations OWNER TO postgres;

--
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.migrations_id_seq OWNER TO postgres;

--
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;


--
-- Name: password_reset_tokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.password_reset_tokens (
    email character varying(255) NOT NULL,
    token character varying(255) NOT NULL,
    created_at timestamp(0) without time zone
);


ALTER TABLE public.password_reset_tokens OWNER TO postgres;

--
-- Name: personal_access_tokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.personal_access_tokens (
    id bigint NOT NULL,
    tokenable_type character varying(255) NOT NULL,
    tokenable_id bigint NOT NULL,
    name character varying(255) NOT NULL,
    token character varying(64) NOT NULL,
    abilities text,
    last_used_at timestamp(0) without time zone,
    expires_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.personal_access_tokens OWNER TO postgres;

--
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.personal_access_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.personal_access_tokens_id_seq OWNER TO postgres;

--
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.personal_access_tokens_id_seq OWNED BY public.personal_access_tokens.id;


--
-- Name: sessions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sessions (
    id character varying(255) NOT NULL,
    user_id bigint,
    ip_address character varying(45),
    user_agent text,
    payload text NOT NULL,
    last_activity integer NOT NULL
);


ALTER TABLE public.sessions OWNER TO postgres;

--
-- Name: tareas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tareas (
    "idTareas" bigint NOT NULL,
    "idUsuario" bigint NOT NULL,
    "idCategoria" bigint,
    titulo character varying(100) NOT NULL,
    descripcion text NOT NULL,
    estado character varying(255) NOT NULL,
    prioridad character varying(255) NOT NULL,
    "fechaLimite" date,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.tareas OWNER TO postgres;

--
-- Name: tareas_idTareas_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."tareas_idTareas_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."tareas_idTareas_seq" OWNER TO postgres;

--
-- Name: tareas_idTareas_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."tareas_idTareas_seq" OWNED BY public.tareas."idTareas";


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    email_verified_at timestamp(0) without time zone,
    password character varying(255) NOT NULL,
    remember_token character varying(100),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: usuarios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuarios (
    id bigint NOT NULL,
    "nombreCompleto" character varying(100) NOT NULL,
    email character varying(100) NOT NULL,
    password character varying(150) NOT NULL,
    email_verified_at timestamp(0) without time zone,
    remember_token character varying(100),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.usuarios OWNER TO postgres;

--
-- Name: usuarios_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.usuarios_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.usuarios_id_seq OWNER TO postgres;

--
-- Name: usuarios_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usuarios_id_seq OWNED BY public.usuarios.id;


--
-- Name: categorias idCategoria; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categorias ALTER COLUMN "idCategoria" SET DEFAULT nextval('public."categorias_idCategoria_seq"'::regclass);


--
-- Name: failed_jobs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.failed_jobs ALTER COLUMN id SET DEFAULT nextval('public.failed_jobs_id_seq'::regclass);


--
-- Name: historial_tareas idHistorial; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historial_tareas ALTER COLUMN "idHistorial" SET DEFAULT nextval('public."historial_tareas_idHistorial_seq"'::regclass);


--
-- Name: jobs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jobs ALTER COLUMN id SET DEFAULT nextval('public.jobs_id_seq'::regclass);


--
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- Name: personal_access_tokens id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personal_access_tokens ALTER COLUMN id SET DEFAULT nextval('public.personal_access_tokens_id_seq'::regclass);


--
-- Name: tareas idTareas; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tareas ALTER COLUMN "idTareas" SET DEFAULT nextval('public."tareas_idTareas_seq"'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: usuarios id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios ALTER COLUMN id SET DEFAULT nextval('public.usuarios_id_seq'::regclass);


--
-- Data for Name: cache; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cache (key, value, expiration) FROM stdin;
\.


--
-- Data for Name: cache_locks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cache_locks (key, owner, expiration) FROM stdin;
\.


--
-- Data for Name: categorias; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categorias ("idCategoria", "idUsuario", nombre, "fechaCreacion") FROM stdin;
1	4	Trabajo	2025-04-10 14:15:05
2	4	Universidad	2025-06-13 17:15:23
3	4	Casa	2025-06-13 17:18:30
4	4	Apto	2025-06-13 17:27:41
5	4	Carro	2025-06-13 17:32:09
6	4	Moto	2025-06-13 17:40:31
9	4	Julio	2025-07-01 11:55:04
10	4	Llanta	2025-07-01 13:22:10
11	4	Avion	2025-07-01 22:21:39
\.


--
-- Data for Name: failed_jobs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.failed_jobs (id, uuid, connection, queue, payload, exception, failed_at) FROM stdin;
\.


--
-- Data for Name: historial_tareas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.historial_tareas ("idHistorial", "idTareas", "idUsuario", accion, detalle_cambio, "fechaCambio") FROM stdin;
16	6	6	creación	Tarea 'Motores' fue creada	2025-05-08 18:22:36
17	6	6	actualización	titulo: 'Motores' -> 'Motores BD'	2025-05-08 18:23:41
18	7	4	creación	Tarea 'Analisis y diseño' fue creada	2025-05-14 21:19:55
20	8	4	creación	Tarea 'Diseño auditorio Blender' fue creada	2025-05-14 21:24:05
24	11	4	creación	Tarea 'barrer' fue creada	2025-05-14 22:51:26
25	11	4	actualización	descripcion: 'barrer la casa jajajajja' -> 'barrer la casa jajajajj'	2025-05-14 22:51:44
27	12	4	creación	Tarea 'hola mundo' fue creada	2025-05-14 23:40:23
30	15	11	creación	Tarea 'Abuela' fue creada	2025-05-15 01:04:19
32	11	4	actualización	descripcion: 'barrer la casa jajajajj' -> 'barrer la sala jajajajj'	2025-05-15 01:28:50
33	2	4	actualización	idCategoria: '1' -> '', descripcion: 'Repasar controladores y rutas protegidas' -> 'Repasar controladores y rutas protegidass'	2025-05-15 01:29:21
34	7	4	actualización	fechaLimite: '2025-05-31' -> '2025-05-16 00:00:00'	2025-05-16 16:07:49
35	16	4	creación	Tarea 'Juan Ignacio' fue creada	2025-05-16 16:12:27
37	8	4	actualización	descripcion: 'Hacer diseño del auditorio de la universidad FET, ya que sera la nota del parcial de Lenguaje de programación III.' -> 'Hacer diseño del auditorio de la universidad FET, ya que sera la nota del parcial de Lenguaje de programación IV.'	2025-05-23 13:42:37
39	19	4	creación	Tarea 'Juana' fue creada	2025-05-30 14:18:53
47	12	4	actualización	descripcion: 'hola mundo en Java' -> 'hola mundo en Java no sirve'	2025-06-05 04:07:52
48	12	4	actualización	Estado: 'en_progreso' -> 'completada'	2025-06-05 04:15:26
49	19	4	actualización	Estado: 'en_progreso' -> 'pendiente'	2025-06-05 04:15:55
50	19	4	actualización	Estado: 'pendiente' -> 'en_progreso'	2025-06-05 04:15:58
51	19	4	actualización	Estado: 'en_progreso' -> 'completada'	2025-06-05 04:16:02
57	11	4	actualización	Estado: 'pendiente' -> 'en_progreso'	2025-06-05 04:33:26
58	11	4	actualización	Estado: 'en_progreso' -> 'pendiente'	2025-06-05 04:33:34
59	2	4	actualización	Estado: 'pendiente' -> 'en_progreso'	2025-06-05 04:35:57
60	7	4	actualización	Estado: 'pendiente' -> 'en_progreso'	2025-06-05 04:37:55
61	7	4	actualización	Estado: 'en_progreso' -> 'pendiente'	2025-06-05 04:38:03
62	7	4	actualización	Estado: 'pendiente' -> 'en_progreso'	2025-06-05 04:38:11
63	7	4	actualización	Estado: 'en_progreso' -> 'pendiente'	2025-06-05 04:39:12
64	7	4	actualización	Estado: 'pendiente' -> 'en_progreso'	2025-06-05 04:40:59
65	7	4	actualización	Estado: 'en_progreso' -> 'pendiente'	2025-06-05 04:41:08
66	7	4	actualización	Estado: 'pendiente' -> 'en_progreso'	2025-06-05 04:41:20
67	16	4	actualización	Estado: 'pendiente' -> 'en_progreso'	2025-06-05 04:41:51
68	8	4	actualización	Estado: 'en_progreso' -> 'pendiente'	2025-06-05 04:43:05
69	8	4	actualización	Estado: 'pendiente' -> 'en_progreso'	2025-06-05 04:47:44
70	8	4	actualización	Estado: 'en_progreso' -> 'pendiente'	2025-06-05 04:47:57
155	50	4	creación	Tarea 'Trabajo 4' fue creada	2025-06-13 21:37:23
156	51	4	creación	Tarea 'Trabajo 5' fue creada	2025-06-13 22:15:32
157	52	4	creación	Tarea 'Trabajo 6' fue creada	2025-06-13 22:18:39
158	53	4	creación	Tarea 'Trabajo 7' fue creada	2025-06-13 22:32:23
159	54	4	creación	Tarea 'Trabajo 8' fue creada	2025-06-13 22:40:45
160	55	4	creación	Tarea 'Trabajo 9' fue creada	2025-06-13 23:32:02
161	56	4	creación	Tarea 'Julio 1' fue creada	2025-07-01 16:56:53
71	8	4	actualización	Estado: 'pendiente' -> 'en_progreso'	2025-06-05 04:48:03
72	8	4	actualización	Estado: 'en_progreso' -> 'pendiente'	2025-06-05 04:48:09
73	8	4	actualización	Estado: 'pendiente' -> 'en_progreso'	2025-06-05 04:50:40
74	8	4	actualización	Estado: 'en_progreso' -> 'pendiente'	2025-06-05 04:50:46
75	8	4	actualización	Estado: 'pendiente' -> 'en_progreso'	2025-06-05 04:51:02
76	8	4	actualización	Estado: 'en_progreso' -> 'pendiente'	2025-06-05 04:52:53
77	8	4	actualización	Estado: 'pendiente' -> 'en_progreso'	2025-06-05 04:55:27
78	8	4	actualización	Estado: 'en_progreso' -> 'pendiente'	2025-06-05 04:55:32
79	8	4	actualización	Estado: 'pendiente' -> 'en_progreso'	2025-06-05 04:56:24
80	8	4	actualización	Estado: 'en_progreso' -> 'pendiente'	2025-06-05 04:56:30
81	8	4	actualización	Estado: 'pendiente' -> 'en_progreso'	2025-06-05 05:00:14
82	8	4	actualización	Estado: 'en_progreso' -> 'pendiente'	2025-06-05 05:00:25
83	8	4	actualización	Estado: 'pendiente' -> 'en_progreso'	2025-06-05 05:00:36
84	8	4	actualización	Estado: 'en_progreso' -> 'pendiente'	2025-06-05 05:00:46
85	8	4	actualización	Estado: 'pendiente' -> 'en_progreso'	2025-06-05 05:01:15
86	8	4	actualización	Estado: 'en_progreso' -> 'pendiente'	2025-06-05 05:01:20
87	8	4	actualización	Estado: 'pendiente' -> 'en_progreso'	2025-06-05 05:04:21
88	8	4	actualización	Estado: 'en_progreso' -> 'pendiente'	2025-06-05 05:04:25
89	8	4	actualización	Estado: 'pendiente' -> 'en_progreso'	2025-06-05 05:05:57
90	8	4	actualización	Estado: 'en_progreso' -> 'pendiente'	2025-06-05 05:09:43
91	8	4	actualización	Estado: 'pendiente' -> 'en_progreso'	2025-06-05 05:09:52
95	11	4	actualización	Estado: 'pendiente' -> 'en_progreso'	2025-06-05 05:13:10
96	8	4	actualización	Estado: 'en_progreso' -> 'pendiente'	2025-06-05 05:13:23
97	8	4	actualización	Estado: 'pendiente' -> 'en_progreso'	2025-06-05 05:14:44
99	21	4	creación	Tarea 'vacaciones' fue creada	2025-06-05 05:24:23
100	21	4	actualización	Estado: 'Pendiente' -> 'pendiente'	2025-06-05 05:27:27
101	22	4	creación	Tarea 'Mañana barrer' fue creada	2025-06-05 05:27:54
106	25	4	creación	Tarea 'cumple años santi' fue creada	2025-06-05 05:39:54
107	26	4	creación	Tarea 'mama' fue creada	2025-06-05 05:42:11
110	28	4	creación	Tarea 'miguel' fue creada	2025-06-05 05:46:53
111	29	4	creación	Tarea 'chela' fue creada	2025-06-05 05:47:47
112	30	4	creación	Tarea 'olga' fue creada	2025-06-05 05:48:26
113	31	4	creación	Tarea 'rgbrevfred' fue creada	2025-06-05 05:49:54
114	32	4	creación	Tarea 'Prueba 2' fue creada	2025-06-05 16:10:27
116	34	4	creación	Tarea 'Prueba 4' fue creada	2025-06-05 16:20:14
117	35	4	creación	Tarea 'Prueba 5' fue creada	2025-06-05 16:23:39
118	36	4	creación	Tarea 'Prueba 6' fue creada	2025-06-05 16:24:08
119	37	4	creación	Tarea 'Prueba 7' fue creada	2025-06-05 16:26:25
120	38	4	creación	Tarea 'Prueba 8' fue creada	2025-06-05 16:33:57
121	39	4	creación	Tarea 'Prueba 9' fue creada	2025-06-05 16:36:15
122	40	4	creación	Tarea 'Prueba 10' fue creada	2025-06-05 16:39:53
123	41	4	creación	Tarea 'Prueba 11' fue creada	2025-06-05 16:48:02
124	42	4	creación	Tarea 'Prueba 12' fue creada	2025-06-05 16:54:09
125	43	4	creación	Tarea 'Prueba 13' fue creada	2025-06-05 16:54:36
126	43	4	actualización	descripcion: 'wqertyjnbvcdtyuiolñ' -> 'Verificar la prueba 13', estado: 'Pendiente' -> 'pendiente'	2025-06-05 16:58:17
127	43	4	actualización	descripcion: 'Verificar la prueba 13' -> 'Verificar x 2da vez la prueba 13'	2025-06-05 16:59:13
128	43	4	actualización	descripcion: 'Verificar x 2da vez la prueba 13' -> 'Verificar x 3ra vez la prueba 13'	2025-06-05 17:25:59
129	44	4	creación	Tarea 'Prueba 14' fue creada	2025-06-05 17:26:27
130	11	4	actualización	Estado: 'en_progreso' -> 'completada'	2025-06-05 17:27:37
131	8	4	actualización	Estado: 'en_progreso' -> 'completada'	2025-06-05 17:40:06
132	21	4	actualización	Estado: 'pendiente' -> 'en_progreso'	2025-06-05 18:09:23
133	22	4	actualización	Estado: 'Pendiente' -> 'completada'	2025-06-05 18:17:19
134	25	4	actualización	Estado: 'Pendiente' -> 'completada'	2025-06-05 18:23:59
135	26	4	actualización	Estado: 'Pendiente' -> 'completada'	2025-06-05 18:26:11
136	2	4	actualización	Estado: 'en_progreso' -> 'pendiente'	2025-06-05 18:26:29
138	28	4	actualización	descripcion: 'hoñaaaa' -> 'holaaaa', estado: 'Pendiente' -> 'pendiente'	2025-06-05 18:40:51
139	29	4	actualización	Estado: 'Pendiente' -> 'completada'	2025-06-05 18:41:05
140	30	4	actualización	Estado: 'Pendiente' -> 'en_progreso'	2025-06-05 18:41:09
141	30	4	actualización	Estado: 'en_progreso' -> 'pendiente'	2025-06-05 18:41:12
142	31	4	actualización	Estado: 'Pendiente' -> 'completada'	2025-06-05 18:43:48
143	32	4	actualización	Estado: 'Pendiente' -> 'en_progreso'	2025-06-05 18:43:53
144	32	4	actualización	Estado: 'en_progreso' -> 'pendiente'	2025-06-05 18:43:55
147	46	4	creación	Tarea 'miercoles' fue creada	2025-06-11 05:08:20
150	46	4	actualización	Estado: 'Pendiente' -> 'completada'	2025-06-11 05:09:29
152	47	4	creación	Tarea 'Trabajo' fue creada	2025-06-13 17:28:26
153	48	4	creación	Tarea 'Trabajo dos' fue creada	2025-06-13 18:43:01
154	49	4	creación	Tarea 'Trabajo 3' fue creada	2025-06-13 21:09:14
162	56	4	actualización	estado: 'Pendiente' -> 'pendiente'	2025-07-01 16:58:06
163	57	4	creación	Tarea 'julio 2' fue creada	2025-07-01 17:15:44
164	58	4	creación	Tarea 'Julio 3' fue creada	2025-07-01 17:34:47
165	59	4	creación	Tarea 'julio 4' fue creada	2025-07-01 17:43:18
166	60	4	creación	Tarea 'Julio 5' fue creada	2025-07-01 12:52:44
167	61	4	creación	Tarea 'Julio 6' fue creada	2025-07-01 12:55:20
168	62	4	creación	Tarea 'Julio 7' fue creada	2025-07-01 12:59:30
169	63	4	creación	Tarea 'Julio 8' fue creada	2025-07-01 13:22:25
170	64	4	creación	Tarea 'Julio 9' fue creada	2025-07-01 16:10:05
171	65	4	creación	Tarea 'Julio 10' fue creada	2025-07-01 22:21:52
\.


--
-- Data for Name: job_batches; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.job_batches (id, name, total_jobs, pending_jobs, failed_jobs, failed_job_ids, options, cancelled_at, created_at, finished_at) FROM stdin;
\.


--
-- Data for Name: jobs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.jobs (id, queue, payload, attempts, reserved_at, available_at, created_at) FROM stdin;
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.migrations (id, migration, batch) FROM stdin;
1	0001_01_01_000000_create_users_table	1
2	0001_01_01_000001_create_cache_table	1
3	0001_01_01_000002_create_jobs_table	1
4	2025_03_30_034454_crear_tabla_usuarios	1
5	2025_04_03_215125_crear_tabla_categorias	1
6	2025_04_03_221145_crear_tabla_tareas	1
7	2025_04_03_222034_crear_tabla_historial_tareas	1
8	2025_04_08_174321_create_personal_access_tokens_table	1
\.


--
-- Data for Name: password_reset_tokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.password_reset_tokens (email, token, created_at) FROM stdin;
\.


--
-- Data for Name: personal_access_tokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.personal_access_tokens (id, tokenable_type, tokenable_id, name, token, abilities, last_used_at, expires_at, created_at, updated_at) FROM stdin;
1	App\\Models\\User	4	token	ba76ff7cfa377bd795254edbcf39c6713188f5b9ec75adfe107aba05ecdcd871	["*"]	\N	\N	2025-04-10 18:02:06	2025-04-10 18:02:06
2	App\\Models\\User	4	token	dd7cd378238a072e7d3f7e9e120f1eb31667e1dcc3f10d3e75be514447d18b68	["*"]	\N	\N	2025-04-10 18:27:25	2025-04-10 18:27:25
3	App\\Models\\User	4	token	08c1629c199acc2759a2ad4090dfbf15761c9964114f626c0db6e7b19f03fac8	["*"]	\N	\N	2025-04-10 18:34:50	2025-04-10 18:34:50
14	App\\Models\\User	4	token	5f864fd8b77e239ad77248f68bf4c5774a0f2f9a9a722cce57330e2f6895e8df	["*"]	2025-05-08 15:39:42	\N	2025-05-08 15:33:44	2025-05-08 15:39:42
5	App\\Models\\User	4	token	f4498346dd09ffd8f6f500e2f10e4dc2430ddd1fe438dddfe6c5b3f60cb0b083	["*"]	2025-04-23 03:27:09	\N	2025-04-10 19:01:17	2025-04-23 03:27:09
7	App\\Models\\User	4	token	85c9dd8eb8a3733007f35631b53c4c3efae7ea8ad4ed589c818226105619fce4	["*"]	2025-05-06 00:46:54	\N	2025-05-05 22:56:07	2025-05-06 00:46:54
8	App\\Models\\User	4	token	7cc9e9d521cdf8ec8ee6589edacc6854e95312f94c8abc008023906109676c5b	["*"]	\N	\N	2025-05-06 16:07:29	2025-05-06 16:07:29
9	App\\Models\\User	4	token	38b9cb3436f9c3bb47b608342b3f0819e8c4610b327177afdb3c102afd27e977	["*"]	\N	\N	2025-05-06 16:08:05	2025-05-06 16:08:05
10	App\\Models\\User	4	token	66ef493e4d66be0c50d5e231dc8e8e67cebccf3333abd1d84313360e00e1eb03	["*"]	\N	\N	2025-05-07 01:28:22	2025-05-07 01:28:22
11	App\\Models\\User	5	token	b0c5158ebfc6671cbc3e9eb4b6bb5f6da0b0e66586f8c3950f1cac7e5cef9128	["*"]	\N	\N	2025-05-08 15:00:22	2025-05-08 15:00:22
12	App\\Models\\User	5	token	bb09ef8117be636d0caa60cdc2936fea6cc0929cfb47af35e45860d07712faed	["*"]	2025-05-08 15:13:21	\N	2025-05-08 15:02:55	2025-05-08 15:13:21
15	App\\Models\\User	6	token	697c0c5d531dcd07347e6c5e7d8866baab81681e736876756b2954587f1b6aed	["*"]	2025-05-08 18:23:53	\N	2025-05-08 16:01:50	2025-05-08 18:23:53
16	App\\Models\\User	7	token	ad779ef7d49ac396a4bf19d626f623778d0ede4dbd5b830cef37c1391dafac6b	["*"]	\N	\N	2025-05-09 22:15:43	2025-05-09 22:15:43
13	App\\Models\\User	5	token	96440b1e0c7206758de30aed8025c286f12d7c074b02eeb1a2357da452b78b5f	["*"]	2025-05-08 15:30:57	\N	2025-05-08 15:16:27	2025-05-08 15:30:57
17	App\\Models\\User	9	token	8df6c49e6d7193b2a7a176cc4354a1e8797b04367b6fcf47baf879db6ecf8e79	["*"]	\N	\N	2025-05-09 22:27:59	2025-05-09 22:27:59
18	App\\Models\\User	7	token	228fb9117df45deddae622e3065b38c59e9674c7e28a4faa0585abd674d31ce0	["*"]	\N	\N	2025-05-11 23:04:28	2025-05-11 23:04:28
19	App\\Models\\User	7	token	78528e550c3d610e690350c8634661a2505c442a97be75cb5eed37b298ddb7dd	["*"]	\N	\N	2025-05-12 00:02:19	2025-05-12 00:02:19
20	App\\Models\\User	7	token	733deb5ccd3dfae8759fd87e7545415af82a2c3f81463aa919e863e955a23ed6	["*"]	\N	\N	2025-05-12 00:06:24	2025-05-12 00:06:24
21	App\\Models\\User	7	token	fb5b4f86ff9b094af055abe2e18dfbe14df4811dca2f69492393c1c226737e6c	["*"]	\N	\N	2025-05-12 00:29:17	2025-05-12 00:29:17
22	App\\Models\\User	7	token	bbf4051344aa1234e2851934f391966c3c9d64abd4cfca61d0f274048a8d5fee	["*"]	\N	\N	2025-05-12 00:30:45	2025-05-12 00:30:45
23	App\\Models\\User	7	token	a9e61607dfea8c175ab450ee209bc5dd1b8709e2aa97eddf7f2d68872d59f314	["*"]	\N	\N	2025-05-12 00:33:13	2025-05-12 00:33:13
24	App\\Models\\User	7	token	d9713666b4f8b20efa93d8572ed36e07f30a7210b9c4a2f0539b930dcea1d159	["*"]	\N	\N	2025-05-12 00:33:14	2025-05-12 00:33:14
25	App\\Models\\User	7	token	d6440fd3af4adb56dfbc42219f75dd903ea38e8601d2b14e1afa16bcac4cfa4e	["*"]	\N	\N	2025-05-12 00:43:01	2025-05-12 00:43:01
26	App\\Models\\User	7	token	47cf1080fc754cac0dbd8df14a514a4129214506b53d75b75cd5c2a5989f2ef6	["*"]	\N	\N	2025-05-12 01:00:23	2025-05-12 01:00:23
27	App\\Models\\User	10	token	044e7972d1580084d6d2869ce197c4dd94a486da83f083effbd3978b055544f1	["*"]	\N	\N	2025-05-12 01:02:15	2025-05-12 01:02:15
28	App\\Models\\User	7	token	43ea6bde31f79d3e9bcc6fd87b8e7fe22fb4733a95146e9aea5f970d4395a6e6	["*"]	\N	\N	2025-05-12 01:10:07	2025-05-12 01:10:07
29	App\\Models\\User	7	token	7b7f0e1d5c1089d5d70d2de0b676567c9d14538c705618f2ee6e8fdae859114a	["*"]	\N	\N	2025-05-12 01:10:27	2025-05-12 01:10:27
30	App\\Models\\User	7	token	d923b6cc49e97a2e3c42f1b056f844140e488841fe31a9f6f1742d264604bd52	["*"]	\N	\N	2025-05-12 01:13:12	2025-05-12 01:13:12
31	App\\Models\\User	7	token	d20a7cad42310566fc9d4824d2fdfd5e33b6c23c1d53eab8fd4b83b56f4a6675	["*"]	\N	\N	2025-05-12 01:17:35	2025-05-12 01:17:35
32	App\\Models\\User	7	token	d5b3427a64b7d868253dd8cb5dc08cd6628400e7018c530225a2830f09c47a12	["*"]	\N	\N	2025-05-12 01:37:28	2025-05-12 01:37:28
33	App\\Models\\User	7	token	bb6a3db89cbba87880375f72158457d31c3fb3b34e91e3ab0fd7b9f923f4da3d	["*"]	\N	\N	2025-05-14 19:43:29	2025-05-14 19:43:29
34	App\\Models\\User	11	token	33122a650e06dfc9b64621168eb29f52935c67c8776a3e8e057077704a47be7b	["*"]	\N	\N	2025-05-14 20:46:54	2025-05-14 20:46:54
35	App\\Models\\User	11	token	5370f83c57f9bdbe20f026602e45df5e36451fc046b34a37c1a11191a26042d6	["*"]	\N	\N	2025-05-14 20:54:35	2025-05-14 20:54:35
54	App\\Models\\User	4	token	8ea4150d14b7b106c833aeb97a1b5b7473a7b301c5f111d4f64df0e178b6492a	["*"]	2025-05-16 13:16:16	\N	2025-05-16 13:16:04	2025-05-16 13:16:16
38	App\\Models\\User	4	token	ac64183ed12570d04bb64d3b71c6ffafd58e86451ea95d9bca8105c005d545b2	["*"]	2025-05-15 01:01:45	\N	2025-05-14 21:16:23	2025-05-15 01:01:45
39	App\\Models\\User	4	token	117d28ed39f24444b34727474a5e5017d64016effd61a58f0fc08566071e00d0	["*"]	\N	\N	2025-05-15 01:02:10	2025-05-15 01:02:10
50	App\\Models\\User	4	token	c627c75627d433b34dbc28a57bd5abe83a4c36c6729b83539811d725e4c372ce	["*"]	2025-05-15 13:57:04	\N	2025-05-15 13:57:02	2025-05-15 13:57:04
36	App\\Models\\User	11	token	912e0e83247615e23de847eb746d8d541558928bd9ecec4515c7e65904448c06	["*"]	2025-05-14 21:09:02	\N	2025-05-14 20:59:09	2025-05-14 21:09:02
40	App\\Models\\User	4	token	f15a266eb3d9ff6f028f869948bab82a5c4b475886df5538d9a9daaffa572082	["*"]	2025-05-15 01:02:13	\N	2025-05-15 01:02:10	2025-05-15 01:02:13
37	App\\Models\\User	11	token	1a99012d54bdb3a891d83602a90d7b6c38497cf65e0874a81dcf5f82b796b2d5	["*"]	2025-05-14 21:15:33	\N	2025-05-14 21:15:31	2025-05-14 21:15:33
41	App\\Models\\User	4	token	0f62b5908218d97138d2f21b7522d70daf6991b5eab191a938c0b47f15dd4d03	["*"]	2025-05-15 01:02:50	\N	2025-05-15 01:02:48	2025-05-15 01:02:50
42	App\\Models\\User	4	token	1be79feaa26c61bde417fa6491d91b78832d01b1567c655d450cfceca2d0a6b9	["*"]	2025-05-15 01:02:51	\N	2025-05-15 01:02:50	2025-05-15 01:02:51
46	App\\Models\\User	4	token	af20e902765d5b00b280d72e71e1fe32df2a44938bd2034762974ffd49be1cb1	["*"]	2025-05-15 01:29:21	\N	2025-05-15 01:27:57	2025-05-15 01:29:21
60	App\\Models\\User	4	token	31eafcd14b5ccc370d779640c149e1018de2fdd2c9f11e4b10f54fb45ad26341	["*"]	\N	\N	2025-05-16 13:16:23	2025-05-16 13:16:23
43	App\\Models\\User	11	token	2f82b97e7f1381a37d0a1336a3abee3309b3181a1018d7dcd2293cfdd2e698a4	["*"]	2025-05-15 01:04:20	\N	2025-05-15 01:03:29	2025-05-15 01:04:20
47	App\\Models\\User	4	token	03510b8d5e269c085b4486a0bc3761a683b1e80100362af802f15eb7c7e01621	["*"]	2025-05-15 01:32:37	\N	2025-05-15 01:32:35	2025-05-15 01:32:37
44	App\\Models\\User	4	token	415d623acce27a0ea81d0b4e2cafd20bd0f2223a427dfa80cd33cd713b3000e9	["*"]	2025-05-15 01:07:39	\N	2025-05-15 01:07:37	2025-05-15 01:07:39
51	App\\Models\\User	4	token	3aa3d21b69f11bce2c1f595c92d8053230f5641220a10aea1775a981ef7db3d1	["*"]	2025-05-15 18:19:04	\N	2025-05-15 18:18:59	2025-05-15 18:19:04
45	App\\Models\\User	4	token	b3a55cb452521e1c02f3b3d454fbd13d40431b458b5571e63756fa3e5a9d0ff6	["*"]	2025-05-15 01:25:04	\N	2025-05-15 01:23:49	2025-05-15 01:25:04
48	App\\Models\\User	7	token	c8d68ea993ba5312940b608effa510a34f1ed8f6778ab263291bf21207b79e96	["*"]	2025-05-15 13:10:28	\N	2025-05-15 13:10:24	2025-05-15 13:10:28
59	App\\Models\\User	4	token	c34cf49eac42f98722c6adeec29808eb683d86eea09b5ba4d4ff39bb7b4dd370	["*"]	2025-05-16 13:16:25	\N	2025-05-16 13:16:17	2025-05-16 13:16:25
52	App\\Models\\User	4	token	1c77063d53ae1ae3e5967631089f6ff0b0d9044ba7cf2914fa8801468474891d	["*"]	2025-05-16 13:14:45	\N	2025-05-16 13:14:41	2025-05-16 13:14:45
53	App\\Models\\User	4	token	7fb280f95aaa3163d85e51b42fcf77ffbf44a5528183e276b73f3f29170fa07f	["*"]	\N	\N	2025-05-16 13:16:02	2025-05-16 13:16:02
49	App\\Models\\User	4	token	6d774a9d8c58d30e41082dca968c144ef3848ef5926b36eb162a67b54f7b8cdd	["*"]	2025-05-15 13:53:45	\N	2025-05-15 13:10:50	2025-05-15 13:53:45
55	App\\Models\\User	4	token	7bf89568d21220850ed850543c78ea0ab2a393c7e1924222e2482b704a53c405	["*"]	\N	\N	2025-05-16 13:16:09	2025-05-16 13:16:09
56	App\\Models\\User	4	token	81c7cf0ca150dcb4a650d63c68f08a61262c4c9a75d9580f6b0c8a9e06c46d96	["*"]	\N	\N	2025-05-16 13:16:11	2025-05-16 13:16:11
57	App\\Models\\User	4	token	da92633fe54cbc84c0ce3a975ac06bdccdc427c407182830c6c79a4e6b0a7d4d	["*"]	\N	\N	2025-05-16 13:16:13	2025-05-16 13:16:13
58	App\\Models\\User	4	token	84edb80893bc77e91181b7c2ebf403f8da4407b03c614c5849061a3b776d5fa8	["*"]	\N	\N	2025-05-16 13:16:15	2025-05-16 13:16:15
62	App\\Models\\User	4	token	df776417ea4d1aa5928813d003aa7d867adb90ac1352d74977a84c69e2ae95ca	["*"]	\N	\N	2025-05-16 13:16:31	2025-05-16 13:16:31
61	App\\Models\\User	4	token	4c7c942f9de33805f27f7fdb85867aac1e6facc2970e9dd5e8b318cc3919ba5d	["*"]	2025-05-16 13:16:32	\N	2025-05-16 13:16:24	2025-05-16 13:16:32
63	App\\Models\\User	4	token	21df29234f01c911ae64363e74e68054b28d9fe1f3728479812b11e172f05875	["*"]	\N	\N	2025-05-16 13:16:34	2025-05-16 13:16:34
64	App\\Models\\User	4	token	3d0453b2d4fe86d6a39683b52a280b09dc7aab7b24de1a672a14cfdbe3df39b8	["*"]	\N	\N	2025-05-16 13:16:35	2025-05-16 13:16:35
65	App\\Models\\User	4	token	a0f0c5d801abd455b8e745f246bee57b3d45c473b566815e04f5ffaaaf361161	["*"]	\N	\N	2025-05-16 13:16:37	2025-05-16 13:16:37
66	App\\Models\\User	4	token	bc1fd1218efb9ab7a24e1d09e0b44bc2b3cc1e959521b6128b51704eb7175f12	["*"]	\N	\N	2025-05-16 13:16:39	2025-05-16 13:16:39
67	App\\Models\\User	4	token	071eb46b3a04dbe9218180f3c377dc601767fd67730b07fc29d43a0fd6bc7b52	["*"]	\N	\N	2025-05-16 13:16:41	2025-05-16 13:16:41
77	App\\Models\\User	4	token	7420fe503fb447fb8e57f018ac253136ed50b3a5e9514f9c0d538b978399cd5f	["*"]	2025-05-23 13:42:18	\N	2025-05-23 13:42:16	2025-05-23 13:42:18
68	App\\Models\\User	4	token	5c1581117390d2bd7be033b56afe02a2232180a08f1e793a1da3d0da0629f142	["*"]	2025-05-16 13:16:55	\N	2025-05-16 13:16:51	2025-05-16 13:16:55
99	App\\Models\\User	12	token	a1e71c9b1a06b3eaf2bde2ae6baa5c3659c70389acb81ef83f354088e46849cb	["*"]	2025-06-11 04:18:15	\N	2025-06-11 04:18:13	2025-06-11 04:18:15
83	App\\Models\\User	4	token	0d756eab82dd1366b0401d160770f0ce0880fcc7ae46381f247335fb9b3789dd	["*"]	2025-05-30 15:27:49	\N	2025-05-30 14:34:08	2025-05-30 15:27:49
78	App\\Models\\User	4	token	509aae2bbabca192548e38a97fe7ec346f3c330f228f8415a134a169241c40ef	["*"]	2025-05-23 13:43:05	\N	2025-05-23 13:42:18	2025-05-23 13:43:05
84	App\\Models\\User	4	token	009ffdf34e13f68b5511352b665eeae4b777f954a3e399a847bb4c38b8e05a99	["*"]	\N	\N	2025-05-30 15:48:23	2025-05-30 15:48:23
69	App\\Models\\User	4	token	00e8de19b0b031e1438e8c452430d668b69fdf4e46e547768abec43870a95822	["*"]	2025-05-16 15:58:54	\N	2025-05-16 15:57:02	2025-05-16 15:58:54
79	App\\Models\\User	4	token	16bbe59dfca027eea6b8bbda56e70d30bc81d072ee1931e19a0a1ea2300e3737	["*"]	2025-05-29 16:11:00	\N	2025-05-29 16:10:55	2025-05-29 16:11:00
70	App\\Models\\User	4	token	a90f7622b7f0be2a1e5c2e113578270056ee7f270b438ad91daf0e59e5aa2ba0	["*"]	2025-05-16 16:01:10	\N	2025-05-16 16:01:09	2025-05-16 16:01:10
80	App\\Models\\User	4	token	9dc852749a5fe10d660992c07ce2a62ba35054ea13072c145f9131db45f9febf	["*"]	2025-05-29 16:11:02	\N	2025-05-29 16:10:59	2025-05-29 16:11:02
97	App\\Models\\User	4	token	43b0b2461e1fae2cd6a4669ed9500fe49a93f97d10d2d81529da86d781d3c27d	["*"]	2025-06-05 17:51:44	\N	2025-06-05 16:09:38	2025-06-05 17:51:44
71	App\\Models\\User	4	token	eaf07302f15918fd675e48c4665438086788221b998148910b047fcdefe894e7	["*"]	2025-05-16 16:07:50	\N	2025-05-16 16:06:43	2025-05-16 16:07:50
81	App\\Models\\User	4	token	24602306b404b4b40779de4cd465311ac24ab9deb7e8db859f6b119d837743a5	["*"]	2025-05-30 14:18:53	\N	2025-05-30 14:18:04	2025-05-30 14:18:53
82	App\\Models\\User	4	token	ac7305bc0dab212d89a56e0e4d1402573f56e95ea2977dbedeb2ef2bb20d183b	["*"]	\N	\N	2025-05-30 14:34:07	2025-05-30 14:34:07
72	App\\Models\\User	4	token	43ab33bc273ac495fcef7c6653279be25b30c850f22e7b1f55ab2051ac3bdc0f	["*"]	2025-05-16 16:12:28	\N	2025-05-16 16:11:03	2025-05-16 16:12:28
92	App\\Models\\User	4	token	225c163305ce6e3dab978a2e0141b25f3e1567fa5d80681d77c91e83fa4249c3	["*"]	2025-06-05 04:46:25	\N	2025-06-05 04:37:48	2025-06-05 04:46:25
96	App\\Models\\User	4	token	ed8f3055244ab1cc461d5b1341e599dd58320dc91a948ec72ac229b337b1c1b1	["*"]	2025-06-05 05:52:59	\N	2025-06-05 05:49:38	2025-06-05 05:52:59
73	App\\Models\\User	4	token	6bb19c8e206a3e09eb03e233c54a0f1ae15e89917fe46545989277fbfd14ade7	["*"]	2025-05-16 16:49:00	\N	2025-05-16 16:47:59	2025-05-16 16:49:00
85	App\\Models\\User	4	token	457254d7d937da1c8a07cac6f1bd3d5f039381209be6f7d7585a26d682690e8f	["*"]	2025-05-30 15:52:11	\N	2025-05-30 15:48:26	2025-05-30 15:52:11
74	App\\Models\\User	4	token	773290264fdb41bd501e73f79b4fdf2edde81c5e891684446ac83840c9930dcf	["*"]	2025-05-17 06:22:27	\N	2025-05-17 06:22:25	2025-05-17 06:22:27
75	App\\Models\\User	4	token	2376b4a68fedc4fd2ad5e28b8d3f130a8f724c9f0868ebcf55ab6341101e1165	["*"]	2025-05-17 06:22:27	\N	2025-05-17 06:22:26	2025-05-17 06:22:27
86	App\\Models\\User	4	token	4c452fdc1447fc454a15ad1908dc86948566274023fb5b451dd016fabcdfb938	["*"]	\N	\N	2025-06-04 18:42:51	2025-06-04 18:42:51
76	App\\Models\\User	4	token	62f2a1190039ead56ba921388831a194b6659b5515b5db4956b316f207d67a81	["*"]	2025-05-17 20:56:03	\N	2025-05-17 20:55:59	2025-05-17 20:56:03
87	App\\Models\\User	4	token	25fa8ab61c110624e03bfd518689b59da0327d38586ab672307fbcebbf3cf89e	["*"]	2025-06-04 18:42:55	\N	2025-06-04 18:42:52	2025-06-04 18:42:55
88	App\\Models\\User	4	token	5532c73d64431f49a125335a7c185b9ea4f203692a6fbaeda2b1e65a42e3ba7a	["*"]	\N	\N	2025-06-04 20:06:47	2025-06-04 20:06:47
93	App\\Models\\User	4	token	debac7afb94436987d39c2fdc762a4dd8cab2ed241d612fa21d1bbc9576c9252	["*"]	2025-06-05 04:51:54	\N	2025-06-05 04:47:38	2025-06-05 04:51:54
91	App\\Models\\User	4	token	33cf42e938c4722e1f769a2a7955aeaf771ea2a418f623c21264a9b8a934750f	["*"]	2025-06-05 04:35:57	\N	2025-06-05 03:53:45	2025-06-05 04:35:57
90	App\\Models\\User	4	token	abe043b9fd1cd0f78224a23f4608c95187186b9dec6d4d76e193695ad337357d	["*"]	2025-06-05 03:52:31	\N	2025-06-05 03:43:35	2025-06-05 03:52:31
89	App\\Models\\User	4	token	29876c4036e80083715e4bc33044311cc7581dbd2b2e209b59e5605b3a468098	["*"]	2025-06-04 20:25:49	\N	2025-06-04 20:06:47	2025-06-04 20:25:49
101	App\\Models\\User	4	token	f86929119c29ad256be232984a194adb5df1511b6dc89d1c89340e7e3d9d9eda	["*"]	2025-06-13 16:48:19	\N	2025-06-13 16:48:14	2025-06-13 16:48:19
94	App\\Models\\User	4	token	4befe64537cbef2d4a1491cb76ab0e8687952c04f96fe8265715b1a783e352fd	["*"]	2025-06-05 05:04:25	\N	2025-06-05 04:52:16	2025-06-05 05:04:25
106	App\\Models\\User	13	token	799dde297cf8827e58c3180b656c135299a1a9b1a89867d966ce72de2dcdff6f	["*"]	2025-07-01 22:48:30	\N	2025-07-01 22:48:28	2025-07-01 22:48:30
103	App\\Models\\User	11	token	de2fb858bc591afb6921f4ab0df1e3853ddc1ed668adebab217985a5955c9734	["*"]	2025-06-13 22:33:33	\N	2025-06-13 22:33:31	2025-06-13 22:33:33
95	App\\Models\\User	4	token	bcf97f42be24a5fe50e5cbbd65f21600e14fe283de6809bd3ec7ebee9cc4f071	["*"]	2025-06-05 05:49:12	\N	2025-06-05 05:05:46	2025-06-05 05:49:12
98	App\\Models\\User	4	token	63799a14ae1f8e7d63ca8daa22f6561db5c5e791ecfd51e0133eee7910eb2a96	["*"]	2025-06-05 18:43:55	\N	2025-06-05 17:53:52	2025-06-05 18:43:55
100	App\\Models\\User	4	token	85e97b66faba42888277478dc3139aa60443f162e6df7ced6c6b9eaa63fde406	["*"]	2025-06-11 06:06:21	\N	2025-06-11 04:25:11	2025-06-11 06:06:21
102	App\\Models\\User	4	token	d7f961db1adf213cc1a2eb103fc535665825822195cc7abd13f6bba74d4a34a3	["*"]	2025-06-13 22:32:23	\N	2025-06-13 16:48:18	2025-06-13 22:32:23
105	App\\Models\\User	4	token	92c1d96a04a56006a10b7f7210e99e3706fbdb06128b8224b48edf2d9343f4e6	["*"]	2025-07-01 22:31:31	\N	2025-07-01 16:51:07	2025-07-01 22:31:31
104	App\\Models\\User	4	token	9f02abdddca5e6c5eeaf5716354f3a8ab07e849e041a297635390d2e5a28805e	["*"]	2025-06-17 01:13:42	\N	2025-06-13 22:34:03	2025-06-17 01:13:42
107	App\\Models\\User	4	token	b8c10c3f91d814cfd18e1322f66565dcb8d62f1928130203f062286c1b535c87	["*"]	2025-07-09 23:30:16	\N	2025-07-09 23:30:10	2025-07-09 23:30:16
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sessions (id, user_id, ip_address, user_agent, payload, last_activity) FROM stdin;
AGDITHHHjDFTO7m0429b6Yo8PthbY6LJ71oM7G0p	13	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	YTozOntzOjY6Il90b2tlbiI7czo0MDoiVFljS1JoaGdwZjM4VkJNcjZvMm8yWWthVnM5eWxDV0FGMzVycWxwYSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvdGFyZWFzIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==	1751428110
jWBezZ364cXwUBGv2WmbeT5nVrPoZsW4eQeaRyRp	\N	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	YTozOntzOjY6Il90b2tlbiI7czo0MDoieGVPTlRSd3VycFRNWDlJYlNSWjhTRHpmN1hFMGVrYTJvQ044eDZnYiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=	1752121742
It6FKaOQv5Rstxj60urEpuOx1wETBypEJw7AOyzI	4	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	YTozOntzOjY6Il90b2tlbiI7czo0MDoiZWgycjBudlVLUUpuSDhQSk1NUDBNWEF4VGhvdVVGVE52aG8yakhMRiI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvdGFyZWFzIjt9fQ==	1752121817
\.


--
-- Data for Name: tareas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tareas ("idTareas", "idUsuario", "idCategoria", titulo, descripcion, estado, prioridad, "fechaLimite", created_at, updated_at) FROM stdin;
46	4	\N	miercoles	frfrgefg	completada	alta	\N	2025-06-11 05:08:20	2025-06-11 05:09:29
47	4	\N	Trabajo	rgrneiofe	Pendiente	alta	2025-06-25	2025-06-13 17:28:26	2025-06-13 17:28:26
6	6	\N	Motores BD	Hacer proyecto motores bd	pendiente	alta	2025-05-31	2025-05-08 18:22:36	2025-05-08 18:23:41
15	11	\N	Abuela	Ir mañana donde la abuela	pendiente	alta	2025-05-15	2025-05-15 01:04:19	2025-05-15 01:04:19
48	4	\N	Trabajo dos	rgfgegege	Pendiente	alta	2025-06-25	2025-06-13 18:43:01	2025-06-13 18:43:01
12	4	\N	hola mundo	hola mundo en Java no sirve	completada	media	\N	2025-05-14 23:40:23	2025-06-05 04:15:26
34	4	\N	Prueba 4	jrnrnen	Pendiente	alta	2025-06-20	2025-06-05 16:20:14	2025-06-05 16:20:14
35	4	\N	Prueba 5	tjrgfghg	Pendiente	media	2025-06-19	2025-06-05 16:23:39	2025-06-05 16:23:39
19	4	\N	Juana	Hola	completada	alta	2025-05-31	2025-05-30 14:18:53	2025-06-05 04:16:02
36	4	\N	Prueba 6	fghngfvb	Pendiente	alta	2025-06-18	2025-06-05 16:24:08	2025-06-05 16:24:08
37	4	\N	Prueba 7	ferghjhgf	Pendiente	media	2025-06-25	2025-06-05 16:26:25	2025-06-05 16:26:25
38	4	\N	Prueba 8	frgthyuiuytrehuj	Pendiente	alta	2025-06-18	2025-06-05 16:33:57	2025-06-05 16:33:57
39	4	\N	Prueba 9	sdrtyjnbfdertjkjhgf	Pendiente	media	2025-06-17	2025-06-05 16:36:15	2025-06-05 16:36:15
49	4	\N	Trabajo 3	fgrtgrf	Pendiente	media	2025-06-17	2025-06-13 21:09:14	2025-06-13 21:09:14
50	4	1	Trabajo 4	vrifedoefd	Pendiente	baja	2025-06-18	2025-06-13 21:37:23	2025-06-13 21:37:23
51	4	2	Trabajo 5	wdefrgthgf	Pendiente	media	2025-06-18	2025-06-13 22:15:32	2025-06-13 22:15:32
40	4	\N	Prueba 10	sdfghjmnbvds	Pendiente	media	2025-06-17	2025-06-05 16:39:53	2025-06-05 16:39:53
52	4	3	Trabajo 6	edfrghjhnbgvf	Pendiente	alta	2025-06-17	2025-06-13 22:18:39	2025-06-13 22:18:39
41	4	\N	Prueba 11	dfghnbvdhjmnb	Pendiente	alta	2025-06-10	2025-06-05 16:48:02	2025-06-05 16:48:02
42	4	\N	Prueba 12	erthcvbhjyv	Pendiente	alta	2025-06-16	2025-06-05 16:54:09	2025-06-05 16:54:09
53	4	5	Trabajo 7	wertghyjgf	Pendiente	media	2025-06-21	2025-06-13 22:32:23	2025-06-13 22:32:23
7	4	\N	Analisis y diseño	Hacer video	en_progreso	alta	2025-05-16	2025-05-14 21:19:55	2025-06-05 04:41:20
16	4	\N	Juan Ignacio	Hola Juan	en_progreso	media	2025-05-27	2025-05-16 16:12:27	2025-06-05 04:41:51
54	4	6	Trabajo 8	wergthgf	Pendiente	alta	2025-06-23	2025-06-13 22:40:45	2025-06-13 22:40:45
43	4	\N	Prueba 13	Verificar x 3ra vez la prueba 13	pendiente	media	2025-06-21	2025-06-05 16:54:36	2025-06-05 17:25:59
44	4	\N	Prueba 14	werthjnbvcdrtyujhg	Pendiente	media	2025-06-08	2025-06-05 17:26:27	2025-06-05 17:26:27
11	4	\N	barrer	barrer la sala jajajajj	completada	alta	2025-05-22	2025-05-14 22:51:26	2025-06-05 17:27:37
8	4	\N	Diseño auditorio Blender	Hacer diseño del auditorio de la universidad FET, ya que sera la nota del parcial de Lenguaje de programación IV.	completada	alta	2025-05-30	2025-05-14 21:24:05	2025-06-05 17:40:06
21	4	\N	vacaciones	hacer py de app	en_progreso	alta	2025-08-13	2025-06-05 05:24:23	2025-06-05 18:09:23
22	4	\N	Mañana barrer	toca barrer la casa	completada	alta	2025-08-15	2025-06-05 05:27:54	2025-06-05 18:17:19
25	4	\N	cumple años santi	el 13 de agosto	completada	alta	2025-08-13	2025-06-05 05:39:54	2025-06-05 18:23:59
26	4	\N	mama	mamaammaa	completada	alta	2025-06-19	2025-06-05 05:42:11	2025-06-05 18:26:10
2	4	\N	Estudiar Laravel	Repasar controladores y rutas protegidass	pendiente	alta	\N	2025-04-10 19:15:38	2025-06-05 18:26:29
28	4	\N	miguel	holaaaa	pendiente	media	2025-06-13	2025-06-05 05:46:53	2025-06-05 18:40:51
29	4	\N	chela	jelooouuu	completada	baja	2025-06-14	2025-06-05 05:47:47	2025-06-05 18:41:05
30	4	\N	olga	eejjvnnwd	pendiente	alta	\N	2025-06-05 05:48:26	2025-06-05 18:41:12
31	4	\N	rgbrevfred	vrevfgfcv	completada	alta	2025-06-19	2025-06-05 05:49:54	2025-06-05 18:43:48
32	4	\N	Prueba 2	jvnrefetg	pendiente	media	2025-06-26	2025-06-05 16:10:27	2025-06-05 18:43:55
56	4	9	Julio 1	Empieza el mes de julio de 2025	pendiente	media	2025-07-18	2025-07-01 16:56:53	2025-07-01 16:58:00
57	4	1	julio 2	Empieza el dia 2 de Julio de 2025	Pendiente	media	2025-07-15	2025-07-01 17:15:44	2025-07-01 17:15:44
58	4	1	Julio 3	Empieza el dia 3 de Julio de 2025	Pendiente	alta	2025-07-11	2025-07-01 17:34:47	2025-07-01 17:34:47
59	4	2	julio 4	Empieza el dia 4 de Julio de 2025	Pendiente	alta	2025-07-13	2025-07-01 17:43:18	2025-07-01 17:43:18
60	4	1	Julio 5	Empieza el dia 5 de Julio de 2025	Pendiente	baja	2025-07-25	2025-07-01 12:52:44	2025-07-01 12:52:44
61	4	4	Julio 6	Empieza el dia 6 de julio de 2025	Pendiente	alta	2025-07-13	2025-07-01 12:55:20	2025-07-01 12:55:20
62	4	2	Julio 7	Empieza el dia 7 de julio de 025	Pendiente	media	2025-07-21	2025-07-01 12:59:30	2025-07-01 12:59:30
55	4	\N	Trabajo 9	efrgbfed	Pendiente	baja	\N	2025-06-13 23:32:02	2025-06-13 23:32:02
63	4	10	Julio 8	Empieza el dia 8 de julio de 2025	Pendiente	media	2025-07-24	2025-07-01 13:22:25	2025-07-01 13:22:25
64	4	2	Julio 9	Empieza el dia 9 de Julio de 2025	Pendiente	media	2025-07-22	2025-07-01 16:10:05	2025-07-01 16:10:05
65	4	11	Julio 10	Empieza el dia 10 de Julio de 2025	Pendiente	baja	2025-07-20	2025-07-01 22:21:52	2025-07-01 22:21:52
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, name, email, email_verified_at, password, remember_token, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: usuarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuarios (id, "nombreCompleto", email, password, email_verified_at, remember_token, created_at, updated_at) FROM stdin;
1	Test User	test@example.com	$2y$12$4b2G5YyJcmY382ogaMonseMCFxfh2CTKbpAcXmJfwrsSVffn4JPfu	2025-04-10 17:37:38	imnwKW45vs	2025-04-10 17:37:38	2025-04-10 17:37:38
4	Santiago Tovar	santiago@example.com	$2y$12$IoVwrVjE.AxgL.rltPcsKekksrFWCijDY69KuEtT8qOpsUbDu5.x2	\N	\N	2025-04-10 17:56:31	2025-04-10 17:56:31
5	Juan Cuellar	cuellar@gmail.com	$2y$12$um6uqaxoCAsIxaGGcJgvreqrGJEKDxTF.u1yJ7Gpq3bVldAyy8NlW	\N	\N	2025-05-08 14:59:07	2025-05-08 14:59:07
6	Juan Pérez	juan@example.com	$2y$12$xp64Rp.OewhrMnPNH0vjfO1lajkIIPOwsJN8lhDkgNKrkwGOzW.Au	\N	\N	2025-05-08 15:58:19	2025-05-08 15:58:19
7	santiago	santiago_tovarva@fet.edu.co	$2y$12$qXxSP8mrgeLiTRUULMc6U.k0YHKMWhk.xuEKsafc8phlvZXfgo5uS	\N	\N	2025-05-09 16:32:54	2025-05-09 16:32:54
8	edgar tovar	edgar75@gmail.com	$2y$12$xb4U1smOkimdXmmCbN2WIeHuE/JEsYJX9aIBmp1f.DeLcUd8v6JQe	\N	\N	2025-05-09 22:25:56	2025-05-09 22:25:56
9	Erika	erika@example.com	$2y$12$aLWk5.swMG7d/NvHJHSM/eKUvIesbUBoiKsA3T/SYggvsWmAuLtVe	\N	\N	2025-05-09 22:26:54	2025-05-09 22:26:54
10	Miguel Andres Tovar Vargas	miguel@example.com	$2y$12$fmD0ZXncE5Fgl3N3HmZtmuxbqzB7vDqBd5FmYB8vcA6YFI7h5sST2	\N	\N	2025-05-12 01:01:36	2025-05-12 01:01:36
11	olga	olga@example.com	$2y$12$05rMn0xMg/K./DsXiD62VuPWKHzLQui0gOWs.Ykl/4qtnoGj65g6K	\N	\N	2025-05-14 20:45:51	2025-05-14 20:45:51
12	Nicol	nicol@example.com	$2y$12$8p3CLhB9M4tVFBkzY0RgKuWQERURBY1hqVM/fFxu/vkSkolDCWFJC	\N	\N	2025-06-11 04:17:31	2025-06-11 04:17:31
13	Maria Victoria	victoriatovar@example.com	$2y$12$6wptx5KpnLabtt2YTxhGDOED2GCfyUuOkryy338fQxOUqEK9KgyjC	\N	\N	2025-07-01 22:47:58	2025-07-01 22:47:58
\.


--
-- Name: categorias_idCategoria_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."categorias_idCategoria_seq"', 11, true);


--
-- Name: failed_jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.failed_jobs_id_seq', 1, false);


--
-- Name: historial_tareas_idHistorial_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."historial_tareas_idHistorial_seq"', 171, true);


--
-- Name: jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.jobs_id_seq', 1, false);


--
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.migrations_id_seq', 8, true);


--
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.personal_access_tokens_id_seq', 107, true);


--
-- Name: tareas_idTareas_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."tareas_idTareas_seq"', 65, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 1, false);


--
-- Name: usuarios_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usuarios_id_seq', 13, true);


--
-- Name: cache_locks cache_locks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cache_locks
    ADD CONSTRAINT cache_locks_pkey PRIMARY KEY (key);


--
-- Name: cache cache_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cache
    ADD CONSTRAINT cache_pkey PRIMARY KEY (key);


--
-- Name: categorias categorias_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categorias
    ADD CONSTRAINT categorias_pkey PRIMARY KEY ("idCategoria");


--
-- Name: failed_jobs failed_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_pkey PRIMARY KEY (id);


--
-- Name: failed_jobs failed_jobs_uuid_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_uuid_unique UNIQUE (uuid);


--
-- Name: historial_tareas historial_tareas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historial_tareas
    ADD CONSTRAINT historial_tareas_pkey PRIMARY KEY ("idHistorial");


--
-- Name: job_batches job_batches_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_batches
    ADD CONSTRAINT job_batches_pkey PRIMARY KEY (id);


--
-- Name: jobs jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT jobs_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: password_reset_tokens password_reset_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.password_reset_tokens
    ADD CONSTRAINT password_reset_tokens_pkey PRIMARY KEY (email);


--
-- Name: personal_access_tokens personal_access_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personal_access_tokens
    ADD CONSTRAINT personal_access_tokens_pkey PRIMARY KEY (id);


--
-- Name: personal_access_tokens personal_access_tokens_token_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personal_access_tokens
    ADD CONSTRAINT personal_access_tokens_token_unique UNIQUE (token);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: tareas tareas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tareas
    ADD CONSTRAINT tareas_pkey PRIMARY KEY ("idTareas");


--
-- Name: users users_email_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_unique UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: usuarios usuarios_email_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_unique UNIQUE (email);


--
-- Name: usuarios usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (id);


--
-- Name: jobs_queue_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX jobs_queue_index ON public.jobs USING btree (queue);


--
-- Name: personal_access_tokens_tokenable_type_tokenable_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX personal_access_tokens_tokenable_type_tokenable_id_index ON public.personal_access_tokens USING btree (tokenable_type, tokenable_id);


--
-- Name: sessions_last_activity_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX sessions_last_activity_index ON public.sessions USING btree (last_activity);


--
-- Name: sessions_user_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX sessions_user_id_index ON public.sessions USING btree (user_id);


--
-- Name: categorias categorias_idusuario_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categorias
    ADD CONSTRAINT categorias_idusuario_foreign FOREIGN KEY ("idUsuario") REFERENCES public.usuarios(id) ON DELETE CASCADE;


--
-- Name: historial_tareas historial_tareas_idtareas_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historial_tareas
    ADD CONSTRAINT historial_tareas_idtareas_foreign FOREIGN KEY ("idTareas") REFERENCES public.tareas("idTareas") ON DELETE CASCADE;


--
-- Name: historial_tareas historial_tareas_idusuario_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historial_tareas
    ADD CONSTRAINT historial_tareas_idusuario_foreign FOREIGN KEY ("idUsuario") REFERENCES public.usuarios(id) ON DELETE CASCADE;


--
-- Name: tareas tareas_idcategoria_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tareas
    ADD CONSTRAINT tareas_idcategoria_foreign FOREIGN KEY ("idCategoria") REFERENCES public.categorias("idCategoria") ON DELETE SET NULL;


--
-- Name: tareas tareas_idusuario_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tareas
    ADD CONSTRAINT tareas_idusuario_foreign FOREIGN KEY ("idUsuario") REFERENCES public.usuarios(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

