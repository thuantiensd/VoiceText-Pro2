--
-- PostgreSQL database dump
--

-- Dumped from database version 16.9 (Homebrew)
-- Dumped by pg_dump version 16.9 (Homebrew)

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
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: activity_logs; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.activity_logs (
    id integer NOT NULL,
    user_id integer,
    action character varying(100) NOT NULL,
    details jsonb,
    ip_address character varying(45),
    user_agent text,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.activity_logs OWNER TO neondb_owner;

--
-- Name: activity_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.activity_logs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.activity_logs_id_seq OWNER TO neondb_owner;

--
-- Name: activity_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.activity_logs_id_seq OWNED BY public.activity_logs.id;


--
-- Name: admin_notifications; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.admin_notifications (
    id integer NOT NULL,
    type character varying(50) NOT NULL,
    title character varying(200) NOT NULL,
    message text NOT NULL,
    data jsonb,
    is_read boolean DEFAULT false,
    priority character varying(20) DEFAULT 'normal'::character varying,
    created_at timestamp without time zone DEFAULT now(),
    read_at timestamp without time zone
);


ALTER TABLE public.admin_notifications OWNER TO neondb_owner;

--
-- Name: admin_notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.admin_notifications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.admin_notifications_id_seq OWNER TO neondb_owner;

--
-- Name: admin_notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.admin_notifications_id_seq OWNED BY public.admin_notifications.id;


--
-- Name: app_settings; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.app_settings (
    id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now(),
    free_max_files integer DEFAULT 5,
    free_max_characters integer DEFAULT 500,
    free_voices text[] DEFAULT '{vi-VN-HoaiMyNeural,vi-VN-NamMinhNeural}'::text[],
    pro_max_files integer DEFAULT 100,
    pro_max_characters integer DEFAULT 10000,
    pro_voices text[] DEFAULT '{all}'::text[],
    premium_max_files integer DEFAULT 1000,
    premium_max_characters integer DEFAULT 50000,
    premium_voices text[] DEFAULT '{all}'::text[],
    enable_guest_access boolean DEFAULT true,
    guest_max_characters integer DEFAULT 100,
    guest_voices text[] DEFAULT '{vi-VN-HoaiMyNeural}'::text[],
    enable_upgrade_banner boolean DEFAULT true,
    banner_title text DEFAULT 'Nâng cấp VoiceText Pro'::text,
    banner_description text DEFAULT 'Tận hưởng không giới hạn ký tự và giọng đọc chất lượng cao'::text,
    banner_button_text text DEFAULT 'Nâng cấp ngay'::text
);


ALTER TABLE public.app_settings OWNER TO neondb_owner;

--
-- Name: app_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.app_settings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.app_settings_id_seq OWNER TO neondb_owner;

--
-- Name: app_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.app_settings_id_seq OWNED BY public.app_settings.id;


--
-- Name: audio_files; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.audio_files (
    id integer NOT NULL,
    title text NOT NULL,
    content text NOT NULL,
    voice text NOT NULL,
    speed real DEFAULT 1 NOT NULL,
    pitch real DEFAULT 1 NOT NULL,
    volume real DEFAULT 1 NOT NULL,
    format text DEFAULT 'mp3'::text NOT NULL,
    duration integer DEFAULT 0 NOT NULL,
    file_size integer DEFAULT 0 NOT NULL,
    file_path text,
    share_id text,
    is_public boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    user_id integer,
    is_temporary boolean DEFAULT false NOT NULL,
    ssml_content text,
    quality text DEFAULT 'standard'::text,
    play_count integer DEFAULT 0,
    tags text
);


ALTER TABLE public.audio_files OWNER TO neondb_owner;

--
-- Name: audio_files_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.audio_files_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.audio_files_id_seq OWNER TO neondb_owner;

--
-- Name: audio_files_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.audio_files_id_seq OWNED BY public.audio_files.id;


--
-- Name: batch_jobs; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.batch_jobs (
    id integer NOT NULL,
    user_id integer NOT NULL,
    name text NOT NULL,
    status text DEFAULT 'pending'::text NOT NULL,
    total_files integer NOT NULL,
    completed_files integer DEFAULT 0,
    failed_files integer DEFAULT 0,
    settings text,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    completed_at timestamp without time zone
);


ALTER TABLE public.batch_jobs OWNER TO neondb_owner;

--
-- Name: batch_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.batch_jobs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.batch_jobs_id_seq OWNER TO neondb_owner;

--
-- Name: batch_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.batch_jobs_id_seq OWNED BY public.batch_jobs.id;


--
-- Name: notifications; Type: TABLE; Schema: public; Owner: tienthuan
--

CREATE TABLE public.notifications (
    id integer NOT NULL,
    title character varying NOT NULL,
    message text NOT NULL,
    type character varying DEFAULT 'info'::character varying,
    is_read boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.notifications OWNER TO tienthuan;

--
-- Name: notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: tienthuan
--

CREATE SEQUENCE public.notifications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.notifications_id_seq OWNER TO tienthuan;

--
-- Name: notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tienthuan
--

ALTER SEQUENCE public.notifications_id_seq OWNED BY public.notifications.id;


--
-- Name: payment_settings; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.payment_settings (
    id integer NOT NULL,
    bank_name text DEFAULT 'Ngân hàng TMCP Công Thương Việt Nam'::text NOT NULL,
    account_number text DEFAULT '1234567890123456'::text NOT NULL,
    account_name text DEFAULT 'NGUYEN VAN A'::text NOT NULL,
    qr_code_url text,
    bank_code text DEFAULT 'ICB'::text NOT NULL,
    support_email text DEFAULT 'support@voicetextpro.com'::text,
    support_phone text DEFAULT '0123456789'::text,
    pro_monthly_price integer DEFAULT 99000 NOT NULL,
    pro_yearly_price integer DEFAULT 990000 NOT NULL,
    premium_monthly_price integer DEFAULT 199000 NOT NULL,
    premium_yearly_price integer DEFAULT 1990000 NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.payment_settings OWNER TO neondb_owner;

--
-- Name: payment_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.payment_settings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.payment_settings_id_seq OWNER TO neondb_owner;

--
-- Name: payment_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.payment_settings_id_seq OWNED BY public.payment_settings.id;


--
-- Name: payments; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.payments (
    id integer NOT NULL,
    user_id integer,
    order_id text NOT NULL,
    plan_type text NOT NULL,
    billing_cycle text NOT NULL,
    amount integer NOT NULL,
    status text DEFAULT 'pending'::text NOT NULL,
    payment_method text DEFAULT 'bank_transfer'::text NOT NULL,
    bank_account text DEFAULT '1234567890123456'::text,
    customer_email text,
    customer_name text,
    notes text,
    receipt_image_url text,
    confirmed_by integer,
    confirmed_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.payments OWNER TO neondb_owner;

--
-- Name: payments_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.payments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.payments_id_seq OWNER TO neondb_owner;

--
-- Name: payments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.payments_id_seq OWNED BY public.payments.id;


--
-- Name: playlist_items; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.playlist_items (
    id integer NOT NULL,
    playlist_id integer NOT NULL,
    audio_file_id integer NOT NULL,
    "order" integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.playlist_items OWNER TO neondb_owner;

--
-- Name: playlist_items_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.playlist_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.playlist_items_id_seq OWNER TO neondb_owner;

--
-- Name: playlist_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.playlist_items_id_seq OWNED BY public.playlist_items.id;


--
-- Name: playlists; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.playlists (
    id integer NOT NULL,
    user_id integer NOT NULL,
    name text NOT NULL,
    description text,
    is_public boolean DEFAULT false,
    share_id text,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.playlists OWNER TO neondb_owner;

--
-- Name: playlists_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.playlists_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.playlists_id_seq OWNER TO neondb_owner;

--
-- Name: playlists_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.playlists_id_seq OWNED BY public.playlists.id;


--
-- Name: sessions; Type: TABLE; Schema: public; Owner: tienthuan
--

CREATE TABLE public.sessions (
    sid character varying NOT NULL,
    sess json NOT NULL,
    expire timestamp without time zone NOT NULL
);


ALTER TABLE public.sessions OWNER TO tienthuan;

--
-- Name: social_accounts; Type: TABLE; Schema: public; Owner: tienthuan
--

CREATE TABLE public.social_accounts (
    id integer NOT NULL,
    user_id integer NOT NULL,
    provider character varying(50) NOT NULL,
    provider_id character varying(255) NOT NULL,
    email character varying(255),
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.social_accounts OWNER TO tienthuan;

--
-- Name: social_accounts_id_seq; Type: SEQUENCE; Schema: public; Owner: tienthuan
--

CREATE SEQUENCE public.social_accounts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.social_accounts_id_seq OWNER TO tienthuan;

--
-- Name: social_accounts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tienthuan
--

ALTER SEQUENCE public.social_accounts_id_seq OWNED BY public.social_accounts.id;


--
-- Name: support_tickets; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.support_tickets (
    id integer NOT NULL,
    user_id integer,
    title character varying(200) NOT NULL,
    description text NOT NULL,
    category character varying(50) NOT NULL,
    priority character varying(20) DEFAULT 'medium'::character varying,
    status character varying(20) DEFAULT 'open'::character varying,
    assigned_to integer,
    resolved_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.support_tickets OWNER TO neondb_owner;

--
-- Name: support_tickets_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.support_tickets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.support_tickets_id_seq OWNER TO neondb_owner;

--
-- Name: support_tickets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.support_tickets_id_seq OWNED BY public.support_tickets.id;


--
-- Name: system_metrics; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.system_metrics (
    id integer NOT NULL,
    date date NOT NULL,
    total_users integer DEFAULT 0,
    active_users integer DEFAULT 0,
    new_signups integer DEFAULT 0,
    total_audio_files integer DEFAULT 0,
    audio_minutes_generated numeric(10,2) DEFAULT '0'::numeric,
    characters_processed bigint DEFAULT 0,
    revenue numeric(10,2) DEFAULT '0'::numeric,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.system_metrics OWNER TO neondb_owner;

--
-- Name: system_metrics_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.system_metrics_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.system_metrics_id_seq OWNER TO neondb_owner;

--
-- Name: system_metrics_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.system_metrics_id_seq OWNED BY public.system_metrics.id;


--
-- Name: templates; Type: TABLE; Schema: public; Owner: tienthuan
--

CREATE TABLE public.templates (
    id integer NOT NULL,
    title character varying NOT NULL,
    content text NOT NULL,
    category character varying DEFAULT 'general'::character varying,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.templates OWNER TO tienthuan;

--
-- Name: templates_id_seq; Type: SEQUENCE; Schema: public; Owner: tienthuan
--

CREATE SEQUENCE public.templates_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.templates_id_seq OWNER TO tienthuan;

--
-- Name: templates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tienthuan
--

ALTER SEQUENCE public.templates_id_seq OWNED BY public.templates.id;


--
-- Name: text_templates; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.text_templates (
    id integer NOT NULL,
    user_id integer,
    name text NOT NULL,
    content text NOT NULL,
    category text NOT NULL,
    is_public boolean DEFAULT false,
    usage_count integer DEFAULT 0,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.text_templates OWNER TO neondb_owner;

--
-- Name: text_templates_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.text_templates_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.text_templates_id_seq OWNER TO neondb_owner;

--
-- Name: text_templates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.text_templates_id_seq OWNED BY public.text_templates.id;


--
-- Name: ticket_messages; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.ticket_messages (
    id integer NOT NULL,
    ticket_id integer,
    user_id integer,
    message text NOT NULL,
    is_internal boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.ticket_messages OWNER TO neondb_owner;

--
-- Name: ticket_messages_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.ticket_messages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ticket_messages_id_seq OWNER TO neondb_owner;

--
-- Name: ticket_messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.ticket_messages_id_seq OWNED BY public.ticket_messages.id;


--
-- Name: user_notifications; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.user_notifications (
    id integer NOT NULL,
    user_id integer NOT NULL,
    type text NOT NULL,
    title text NOT NULL,
    content text NOT NULL,
    is_read boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.user_notifications OWNER TO neondb_owner;

--
-- Name: user_notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.user_notifications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_notifications_id_seq OWNER TO neondb_owner;

--
-- Name: user_notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.user_notifications_id_seq OWNED BY public.user_notifications.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.users (
    id integer NOT NULL,
    username text NOT NULL,
    password text NOT NULL,
    email text NOT NULL,
    full_name text,
    is_active boolean DEFAULT true NOT NULL,
    role text DEFAULT 'user'::text NOT NULL,
    subscription_type text DEFAULT 'free'::text NOT NULL,
    subscription_expiry timestamp without time zone,
    total_audio_files integer DEFAULT 0 NOT NULL,
    total_usage_minutes integer DEFAULT 0 NOT NULL,
    preferred_voice text DEFAULT 'alloy'::text,
    preferred_speed real DEFAULT 1,
    preferred_pitch real DEFAULT 1,
    preferred_volume real DEFAULT 1,
    preferred_format text DEFAULT 'mp3'::text,
    total_characters_used integer DEFAULT 0,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    lock_reason text,
    locked_at timestamp without time zone,
    locked_by integer,
    avatar_url text,
    is_email_verified boolean DEFAULT false
);


ALTER TABLE public.users OWNER TO neondb_owner;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO neondb_owner;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: voice_usage_stats; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.voice_usage_stats (
    id integer NOT NULL,
    voice_id character varying(50) NOT NULL,
    usage_count integer DEFAULT 0,
    date date NOT NULL,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.voice_usage_stats OWNER TO neondb_owner;

--
-- Name: voice_usage_stats_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.voice_usage_stats_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.voice_usage_stats_id_seq OWNER TO neondb_owner;

--
-- Name: voice_usage_stats_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.voice_usage_stats_id_seq OWNED BY public.voice_usage_stats.id;


--
-- Name: activity_logs id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.activity_logs ALTER COLUMN id SET DEFAULT nextval('public.activity_logs_id_seq'::regclass);


--
-- Name: admin_notifications id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.admin_notifications ALTER COLUMN id SET DEFAULT nextval('public.admin_notifications_id_seq'::regclass);


--
-- Name: app_settings id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.app_settings ALTER COLUMN id SET DEFAULT nextval('public.app_settings_id_seq'::regclass);


--
-- Name: audio_files id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.audio_files ALTER COLUMN id SET DEFAULT nextval('public.audio_files_id_seq'::regclass);


--
-- Name: batch_jobs id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.batch_jobs ALTER COLUMN id SET DEFAULT nextval('public.batch_jobs_id_seq'::regclass);


--
-- Name: notifications id; Type: DEFAULT; Schema: public; Owner: tienthuan
--

ALTER TABLE ONLY public.notifications ALTER COLUMN id SET DEFAULT nextval('public.notifications_id_seq'::regclass);


--
-- Name: payment_settings id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.payment_settings ALTER COLUMN id SET DEFAULT nextval('public.payment_settings_id_seq'::regclass);


--
-- Name: payments id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.payments ALTER COLUMN id SET DEFAULT nextval('public.payments_id_seq'::regclass);


--
-- Name: playlist_items id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.playlist_items ALTER COLUMN id SET DEFAULT nextval('public.playlist_items_id_seq'::regclass);


--
-- Name: playlists id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.playlists ALTER COLUMN id SET DEFAULT nextval('public.playlists_id_seq'::regclass);


--
-- Name: social_accounts id; Type: DEFAULT; Schema: public; Owner: tienthuan
--

ALTER TABLE ONLY public.social_accounts ALTER COLUMN id SET DEFAULT nextval('public.social_accounts_id_seq'::regclass);


--
-- Name: support_tickets id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.support_tickets ALTER COLUMN id SET DEFAULT nextval('public.support_tickets_id_seq'::regclass);


--
-- Name: system_metrics id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.system_metrics ALTER COLUMN id SET DEFAULT nextval('public.system_metrics_id_seq'::regclass);


--
-- Name: templates id; Type: DEFAULT; Schema: public; Owner: tienthuan
--

ALTER TABLE ONLY public.templates ALTER COLUMN id SET DEFAULT nextval('public.templates_id_seq'::regclass);


--
-- Name: text_templates id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.text_templates ALTER COLUMN id SET DEFAULT nextval('public.text_templates_id_seq'::regclass);


--
-- Name: ticket_messages id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.ticket_messages ALTER COLUMN id SET DEFAULT nextval('public.ticket_messages_id_seq'::regclass);


--
-- Name: user_notifications id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.user_notifications ALTER COLUMN id SET DEFAULT nextval('public.user_notifications_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: voice_usage_stats id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.voice_usage_stats ALTER COLUMN id SET DEFAULT nextval('public.voice_usage_stats_id_seq'::regclass);


--
-- Data for Name: activity_logs; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.activity_logs (id, user_id, action, details, ip_address, user_agent, created_at) FROM stdin;
\.


--
-- Data for Name: admin_notifications; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.admin_notifications (id, type, title, message, data, is_read, priority, created_at, read_at) FROM stdin;
42	user	Người dùng mới đăng ký	Người dùng Tiến Thuận (thuantiensd1999@gmail.com) đã đăng ký tài khoản qua Google OAuth	{"userId": 29, "actionUrl": "/admin?tab=users&userId=29", "userEmail": "thuantiensd1999@gmail.com", "registrationMethod": "google_oauth"}	t	normal	2025-06-08 06:03:08.273	2025-06-08 06:03:32.747
44	payment	Biên lai thanh toán mới	Khách hàng đã tải lên biên lai cho đơn hàng VTP1749362783217. Vui lòng kiểm tra và xử lý thanh toán.	{"action": "receipt_uploaded", "orderId": "VTP1749362783217", "actionUrl": "/admin?tab=payments&paymentId=10", "paymentId": 10}	t	high	2025-06-08 06:06:29.702	2025-06-08 06:06:56.898
45	payment	Kích hoạt gói PREMIUM thành công	Tài khoản đã được nâng cấp lên gói PREMIUM (hàng tháng). Hết hạn: 8/7/2025	\N	t	high	2025-06-08 06:06:59.686	2025-06-08 09:46:29.833
43	payment	Đơn thanh toán mới	Khách hàng Tiến Thuận (thuantiensd1999@gmail.com) đã tạo đơn thanh toán VTP1749362783217 cho gói PREMIUM - 199.000 ₫	{"action": "payment_created", "amount": 199000, "orderId": "VTP1749362783217", "planType": "premium", "actionUrl": "/admin?tab=payments&paymentId=10", "paymentId": 10, "customerEmail": "thuantiensd1999@gmail.com"}	t	high	2025-06-08 06:06:24.901	2025-06-08 09:47:16.986
\.


--
-- Data for Name: app_settings; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.app_settings (id, created_at, updated_at, free_max_files, free_max_characters, free_voices, pro_max_files, pro_max_characters, pro_voices, premium_max_files, premium_max_characters, premium_voices, enable_guest_access, guest_max_characters, guest_voices, enable_upgrade_banner, banner_title, banner_description, banner_button_text) FROM stdin;
1	2025-06-02 13:05:30.019543	2025-06-02 13:05:30.019543	5	500	{vi-VN-HoaiMy,vi-VN-NamMinh}	100	2000	{vi-VN-HoaiMy,vi-VN-NamMinh,vi-VN-ThuMinh}	999999	999999	{vi-VN-HoaiMy,vi-VN-NamMinh,vi-VN-ThuMinh,vi-VN-TrungTinh}	t	100	{vi-VN-HoaiMy}	t	Nâng cấp VoiceText Pro	Tận hưởng không giới hạn ký tự và giọng đọc chất lượng cao	Nâng cấp ngay
999	2025-06-03 13:54:42.619055	2025-06-03 13:54:42.619055	123	456	{vi-VN-HoaiMyNeural,vi-VN-NamMinhNeural}	100	10000	{all}	1000	50000	{all}	t	100	{vi-VN-HoaiMyNeural}	t	Nâng cấp VoiceText Pro	Tận hưởng không giới hạn ký tự và giọng đọc chất lượng cao	Nâng cấp ngay
2	2025-06-07 00:42:45.767637	2025-06-07 00:42:45.767637	5	10000	{vi-VN-HoaiMyNeural,vi-VN-NamMinhNeural}	100	10000	{all}	100	100000	{all}	t	100	{vi-VN-HoaiMyNeural}	t	Nâng cấp VoiceText Pro	Tận hưởng không giới hạn ký tự và giọng đọc chất lượng cao	Nâng cấp ngay
\.


--
-- Data for Name: audio_files; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.audio_files (id, title, content, voice, speed, pitch, volume, format, duration, file_size, file_path, share_id, is_public, created_at, user_id, is_temporary, ssml_content, quality, play_count, tags) FROM stdin;
3	Khám phá sản phẩm mới của chúng tôi! Với chất lượn...	Khám phá sản phẩm mới của chúng tôi! Với chất lượng vượt trội và giá cả hợp lý, đây chính là lựa chọn hoàn hảo cho bạn. Đặt hàng ngay hôm nay để nhận ưu đãi đặc biệt!	giahuy	1	1	1	mp3	16	0	\N	\N	f	2025-06-08 19:00:14.977347	29	f	\N	standard	0	\N
4	Chào mừng các bạn đến với podcast của chúng tôi. H...	Chào mừng các bạn đến với podcast của chúng tôi. Hôm nay chúng ta sẽ cùng thảo luận về những xu hướng công nghệ mới nhất và tác động của chúng đến cuộc sống hàng ngày.	onyx	1	1	0.5	mp3	15	0	\N	\N	f	2025-06-08 19:04:33.219583	29	f	\N	standard	0	\N
5	VoiceText Pro là nền tảng chuyển văn bản thành giọ...	VoiceText Pro là nền tảng chuyển văn bản thành giọng nói chuyên nghiệp, giúp người dùng tạo ra các bản thu âm tự nhiên, sắc nét chỉ trong vài giây. Với giao diện hiện đại, dễ sử dụng cùng kho giọng đọc đa dạng bằng nhiều ngôn ngữ, VoiceText Pro đáp ứng mọi nhu cầu: từ thuyết minh video, đọc sách, đến tạo nội dung học tập. Trang web hỗ trợ tùy chỉnh tốc độ, tông giọng, định dạng xuất file, và đặc biệt phù hợp cho cả người dùng cá nhân lẫn doanh nghiệp cần giải pháp TTS hiệu quả, nhanh chóng và chất lượng cao.	fable	1	1	1	mp3	43	0	\N	\N	f	2025-06-08 19:08:45.660389	29	f	\N	standard	0	\N
6	Trong bài học hôm nay, chúng ta sẽ tìm hiểu về ngu...	Trong bài học hôm nay, chúng ta sẽ tìm hiểu về nguyên lý cơ bản của lập trình. Hãy chuẩn bị sẵn máy tính và theo dõi cẩn thận những ví dụ thực hành.	alloy	1	1	1	mp3	14	0	\N	\N	f	2025-06-08 20:27:21.972158	1	f	\N	standard	0	\N
7	Chào mừng các bạn đến với podcast của chúng tôi. H...	Chào mừng các bạn đến với podcast của chúng tôi. Hôm nay chúng ta sẽ cùng thảo luận về những xu hướng công nghệ mới nhất và tác động của chúng đến cuộc sống hàng ngày.	alloy	1	1	1	mp3	15	0	\N	\N	f	2025-06-08 20:58:11.276561	29	f	\N	standard	0	\N
8	Khám phá sản phẩm mới của chúng tôi! Với chất lượn...	Khám phá sản phẩm mới của chúng tôi! Với chất lượng vượt trội và giá cả hợp lý, đây chính là lựa chọn hoàn hảo cho bạn. Đặt hàng ngay hôm nay để nhận ưu đãi đặc biệt!	alloy	1	1	1	mp3	16	0	\N	\N	f	2025-06-08 21:04:13.641538	29	f	\N	standard	0	\N
\.


--
-- Data for Name: batch_jobs; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.batch_jobs (id, user_id, name, status, total_files, completed_files, failed_files, settings, created_at, completed_at) FROM stdin;
\.


--
-- Data for Name: notifications; Type: TABLE DATA; Schema: public; Owner: tienthuan
--

COPY public.notifications (id, title, message, type, is_read, created_at) FROM stdin;
1	Chào mừng!	Chào mừng bạn đến với VoiceText Pro	info	f	2025-06-07 00:42:45.769375
2	Tính năng mới	Chúng tôi đã thêm giọng nói mới	update	f	2025-06-07 00:42:45.769375
\.


--
-- Data for Name: payment_settings; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.payment_settings (id, bank_name, account_number, account_name, qr_code_url, bank_code, support_email, support_phone, pro_monthly_price, pro_yearly_price, premium_monthly_price, premium_yearly_price, created_at, updated_at) FROM stdin;
1	Ngân hàng TMCP Công Thương Việt Nam (VietinBank)	108004320485	NGUYEN VAN A	https://img.vietqr.io/image/970415-108004320485-compact.jpg	ICB	support@voicetextpro.com	0123456789	99000	990000	199000	1990000	2025-06-01 12:42:35.03792	2025-06-01 12:42:35.03792
\.


--
-- Data for Name: payments; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.payments (id, user_id, order_id, plan_type, billing_cycle, amount, status, payment_method, bank_account, customer_email, customer_name, notes, receipt_image_url, confirmed_by, confirmed_at, created_at) FROM stdin;
1	\N	VTP1748921391046	pro	monthly	99000	completed	bank_transfer	108004320485	thuantiensd1999@gmail.com	Duy thuận		/uploads/receipts/receipt_1_1748921482215.png	1	2025-06-03 03:46:10.547	2025-06-03 03:30:36.757646
10	29	VTP1749362783217	premium	monthly	199000	completed	bank_transfer	108004320485	thuantiensd1999@gmail.com	Tiến Thuận		/uploads/receipts/receipt_10_1749362789695.png	1	2025-06-08 06:06:59.677	2025-06-08 15:06:24.88913
\.


--
-- Data for Name: playlist_items; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.playlist_items (id, playlist_id, audio_file_id, "order", created_at) FROM stdin;
\.


--
-- Data for Name: playlists; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.playlists (id, user_id, name, description, is_public, share_id, created_at) FROM stdin;
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: tienthuan
--

COPY public.sessions (sid, sess, expire) FROM stdin;
\.


--
-- Data for Name: social_accounts; Type: TABLE DATA; Schema: public; Owner: tienthuan
--

COPY public.social_accounts (id, user_id, provider, provider_id, email, created_at) FROM stdin;
19	28	google	104536903631331575869	voicetextpro@gmail.com	2025-06-08 14:45:34.65737
20	29	google	107908970882465104914	thuantiensd1999@gmail.com	2025-06-08 15:03:08.266145
\.


--
-- Data for Name: support_tickets; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.support_tickets (id, user_id, title, description, category, priority, status, assigned_to, resolved_at, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: system_metrics; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.system_metrics (id, date, total_users, active_users, new_signups, total_audio_files, audio_minutes_generated, characters_processed, revenue, created_at) FROM stdin;
\.


--
-- Data for Name: templates; Type: TABLE DATA; Schema: public; Owner: tienthuan
--

COPY public.templates (id, title, content, category, created_at) FROM stdin;
1	Giới thiệu sản phẩm	Xin chào! Tôi muốn giới thiệu về sản phẩm mới của chúng tôi...	business	2025-06-07 00:42:45.768874
2	Thông báo sự kiện	Chúng tôi vui mừng thông báo về sự kiện đặc biệt sắp tới...	announcement	2025-06-07 00:42:45.768874
3	Hướng dẫn sử dụng	Để sử dụng tính năng này, bạn cần làm theo các bước sau...	tutorial	2025-06-07 00:42:45.768874
\.


--
-- Data for Name: text_templates; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.text_templates (id, user_id, name, content, category, is_public, usage_count, created_at) FROM stdin;
\.


--
-- Data for Name: ticket_messages; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.ticket_messages (id, ticket_id, user_id, message, is_internal, created_at) FROM stdin;
\.


--
-- Data for Name: user_notifications; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.user_notifications (id, user_id, type, title, content, is_read, created_at) FROM stdin;
3	1	system	Đăng nhập thành công	Chào mừng trở lại Administrator! Bạn đã đăng nhập vào lúc 12:11:25 8/6/2025	t	2025-06-08 12:11:25.481403
4	1	user	Người dùng mới đăng ký	Người dùng VoiceText Pro (voicetextpro@gmail.com) đã đăng ký tài khoản qua Google OAuth	t	2025-06-08 12:12:43.516948
7	1	user	Người dùng mới đăng ký	Người dùng Tiến Thuận (thuantiensd1999@gmail.com) đã đăng ký tài khoản qua Google OAuth	t	2025-06-08 12:22:04.863588
10	1	user	Người dùng mới đăng ký	Người dùng Test User 2025 (testuser2025@example.com) đã đăng ký tài khoản mới	t	2025-06-08 12:33:27.953971
16	1	system	Đăng nhập thành công	Chào mừng trở lại Administrator! Bạn đã đăng nhập vào lúc 12:35:39 8/6/2025	t	2025-06-08 12:35:39.431468
17	1	system	Test notification	Đây là thông báo test cho admin	t	2025-06-08 12:35:46.965007
21	1	test	Admin test notification	Test notification cho admin	t	2025-06-08 12:39:53.587101
24	1	user	Người dùng mới đăng ký	Người dùng NGUYEN DUY THUAN (duythuandn114@gmail.com) đã đăng ký tài khoản mới	t	2025-06-08 12:41:13.977443
28	1	user	Người dùng mới đăng ký	Người dùng VoiceText Pro (voicetextpro@gmail.com) đã đăng ký tài khoản qua Google OAuth	t	2025-06-08 12:42:35.762488
30	1	payment	Đơn thanh toán mới	Khách hàng VoiceText Pro (voicetextpro@gmail.com) đã tạo đơn thanh toán VTP1749354217959 cho gói PRO - 99.000 ₫	t	2025-06-08 12:43:43.879505
32	1	payment	Đơn thanh toán mới	Khách hàng VoiceText Pro (voicetextpro@gmail.com) đã tạo đơn thanh toán VTP1749354238470 cho gói PRO - 99.000 ₫	t	2025-06-08 12:43:59.623882
34	1	payment	Biên lai thanh toán mới	Khách hàng đã tải lên biên lai cho đơn hàng VTP1749354238470. Vui lòng kiểm tra và xử lý thanh toán.	t	2025-06-08 12:44:09.488256
37	1	user	Người dùng mới đăng ký	Người dùng Test Admin User (testadmin@test.com) đã đăng ký tài khoản mới	t	2025-06-08 13:20:05.884905
38	1	system	Đăng nhập thành công	Chào mừng trở lại Administrator! Bạn đã đăng nhập vào lúc 13:22:56 8/6/2025	t	2025-06-08 13:22:56.064996
39	1	system	Test notification 1	This is a test notification for header bell icon	t	2025-06-08 13:30:08.585558
40	1	upgrade	Test notification 2	Another test notification	t	2025-06-08 13:25:08.585558
43	1	system	Test bell icon admin	Testing bell icon for admin user	t	2025-06-08 13:36:32.310535
66	1	system	Đăng nhập thành công	Chào mừng trở lại Administrator! Bạn đã đăng nhập vào lúc 14:31:24 8/6/2025	f	2025-06-08 14:31:24.959088
67	1	system	Đăng nhập thành công	Chào mừng trở lại Administrator! Bạn đã đăng nhập vào lúc 14:43:57 8/6/2025	f	2025-06-08 14:43:57.518015
68	28	welcome	Chào mừng bạn đến với VoiceText Pro!	Xin chào VoiceText Pro, cảm ơn bạn đã đăng ký tài khoản qua Google. Hãy khám phá các tính năng tạo giọng đọc AI chất lượng cao của chúng tôi. Tài khoản Free của bạn có thể tạo audio từ 500 ký tự mỗi lần.	f	2025-06-08 14:45:34.659088
52	1	welcome	Chào mừng bạn đến VoiceTextPro	Cảm ơn bạn đã đăng ký tài khoản. Hãy khám phá dashboard ngay!	t	2025-06-08 14:04:45.536244
61	1	system	Test User Notification NEW	Đây là thông báo user mới cho admin	t	2025-06-08 14:16:58.099246
69	28	upgrade	Nâng cấp để mở khóa tính năng Pro	Nâng cấp lên gói Pro để tận hưởng 2000 ký tự mỗi lần, nhiều giọng đọc hơn và ưu tiên xử lý. Gói Premium cho phép 5000 ký tự và không giới hạn số file.	f	2025-06-08 14:45:34.66208
70	1	system	Đăng nhập thành công	Chào mừng trở lại Administrator! Bạn đã đăng nhập vào lúc 14:47:53 8/6/2025	f	2025-06-08 14:47:53.325563
71	1	system	Đăng nhập thành công	Chào mừng trở lại Administrator! Bạn đã đăng nhập vào lúc 14:57:40 8/6/2025	f	2025-06-08 14:57:40.237137
78	1	first_audio	Chúc mừng! Audio đầu tiên của bạn	Bạn đã tạo thành công audio file đầu tiên "Cha mẹ là những con người vĩ đại nhất trong cuộc đ...". Hãy khám phá thêm các giọng đọc và tính năng khác của VoiceText Pro!	f	2025-06-08 18:50:06.342991
75	29	payment	Biên lai thanh toán đã được tải lên	Biên lai cho đơn hàng VTP1749362783217 đã được tải lên thành công. Chúng tôi sẽ xử lý và kích hoạt gói của bạn trong vòng 24 giờ.	t	2025-06-08 15:06:29.701362
74	29	payment	Đơn thanh toán đã được tạo	Đơn thanh toán VTP1749362783217 cho gói PREMIUM (Hàng tháng) đã được tạo. Vui lòng hoàn tất thanh toán để kích hoạt gói.	t	2025-06-08 15:06:24.894496
73	29	upgrade	Nâng cấp để mở khóa tính năng Pro	Nâng cấp lên gói Pro để tận hưởng 2000 ký tự mỗi lần, nhiều giọng đọc hơn và ưu tiên xử lý. Gói Premium cho phép 5000 ký tự và không giới hạn số file.	t	2025-06-08 15:03:08.272802
72	29	welcome	Chào mừng bạn đến với VoiceText Pro!	Xin chào Tiến Thuận, cảm ơn bạn đã đăng ký tài khoản qua Google. Hãy khám phá các tính năng tạo giọng đọc AI chất lượng cao của chúng tôi. Tài khoản Free của bạn có thể tạo audio từ 500 ký tự mỗi lần.	t	2025-06-08 15:03:08.268036
76	29	payment_success	Thanh toán thành công - Gói PREMIUM	Chúc mừng! Thanh toán của bạn đã được xác nhận. Tài khoản đã được nâng cấp lên gói PREMIUM (hàng tháng). Gói sẽ hết hạn vào 8/7/2025. Bạn có thể sử dụng đầy đủ tính năng ngay bây giờ.	t	2025-06-08 15:06:59.688571
77	29	first_audio	Chúc mừng! Audio đầu tiên của bạn	Bạn đã tạo thành công audio file đầu tiên "Khám phá sản phẩm mới của chúng tôi! Với chất lượn...". Hãy khám phá thêm các giọng đọc và tính năng khác của VoiceText Pro!	t	2025-06-08 15:08:14.913862
79	29	first_audio	Chúc mừng! Audio đầu tiên của bạn	Bạn đã tạo thành công audio file đầu tiên "Khám phá sản phẩm mới của chúng tôi! Với chất lượn...". Hãy khám phá thêm các giọng đọc và tính năng khác của VoiceText Pro!	t	2025-06-08 19:00:14.982003
80	29	first_audio	Chúc mừng! Audio đầu tiên của bạn	Bạn đã tạo thành công audio file đầu tiên "Chào mừng các bạn đến với podcast của chúng tôi. H...". Hãy khám phá thêm các giọng đọc và tính năng khác của VoiceText Pro!	t	2025-06-08 19:04:33.224981
81	29	first_audio	Chúc mừng! Audio đầu tiên của bạn	Bạn đã tạo thành công audio file đầu tiên "VoiceText Pro là nền tảng chuyển văn bản thành giọ...". Hãy khám phá thêm các giọng đọc và tính năng khác của VoiceText Pro!	t	2025-06-08 19:08:45.66563
82	1	system	Đăng nhập thành công	Chào mừng trở lại Administrator! Bạn đã đăng nhập vào lúc 20:26:24 8/6/2025	f	2025-06-08 20:26:24.438101
83	1	first_audio	Chúc mừng! Audio đầu tiên của bạn	Bạn đã tạo thành công audio file đầu tiên "Trong bài học hôm nay, chúng ta sẽ tìm hiểu về ngu...". Hãy khám phá thêm các giọng đọc và tính năng khác của VoiceText Pro!	f	2025-06-08 20:27:21.977689
84	29	first_audio	Chúc mừng! Audio đầu tiên của bạn	Bạn đã tạo thành công audio file đầu tiên "Chào mừng các bạn đến với podcast của chúng tôi. H...". Hãy khám phá thêm các giọng đọc và tính năng khác của VoiceText Pro!	f	2025-06-08 20:58:11.281258
85	29	first_audio	Chúc mừng! Audio đầu tiên của bạn	Bạn đã tạo thành công audio file đầu tiên "Khám phá sản phẩm mới của chúng tôi! Với chất lượn...". Hãy khám phá thêm các giọng đọc và tính năng khác của VoiceText Pro!	f	2025-06-08 21:04:13.645491
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.users (id, username, password, email, full_name, is_active, role, subscription_type, subscription_expiry, total_audio_files, total_usage_minutes, preferred_voice, preferred_speed, preferred_pitch, preferred_volume, preferred_format, total_characters_used, created_at, updated_at, lock_reason, locked_at, locked_by, avatar_url, is_email_verified) FROM stdin;
28	voicetextpro	$2b$10$PQ5pwEAwyjdFlP1AAKmhV.yM3xiRb/69gvF/VTyogI9nwCZ9UmF0.	voicetextpro@gmail.com	VoiceText Pro	t	user	free	\N	0	0	vi-VN-HoaiMyNeural	1	1	1	mp3	0	2025-06-08 14:45:34.653037	2025-06-08 14:45:34.653037	\N	\N	\N	https://lh3.googleusercontent.com/a/ACg8ocKPVRYjHX1xrgxorT7_1m3t3voI2Cnzbqwqa9tQ1Uh29S9Rxg=s96-c	t
1	admin	$2b$10$oZxig/tbwgTq62SbcrgVCuriUIwJfoNQDySr9IqdoNOQoWGiQ1X1.	admin@voicetext.pro	Administrator	t	admin	premium	\N	0	0	vi-VN-HoaiMyNeural	1	1	1	mp3	0	2025-06-01 12:42:34.895157	2025-06-01 12:42:34.895157	\N	\N	\N	\N	f
29	tiếnthuận	$2b$10$ArLBeAO0k.KD24MWIfNsDeNFs37jHkUENIx5tCyuXewIxHY6.eDyi	thuantiensd1999@gmail.com	Tiến Thuận	t	user	premium	2025-07-08 06:06:59.681	0	0	vi-VN-HoaiMyNeural	1	1	1	mp3	0	2025-06-08 15:03:08.261041	2025-06-08 06:06:59.681	\N	\N	\N	https://lh3.googleusercontent.com/a/ACg8ocIT1e4_q8WKqbhwQVjALGrFXzMjNM4vJsm-hsXWwrV5g8vdevpQ1g=s96-c	t
\.


--
-- Data for Name: voice_usage_stats; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.voice_usage_stats (id, voice_id, usage_count, date, created_at) FROM stdin;
\.


--
-- Name: activity_logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.activity_logs_id_seq', 1, false);


--
-- Name: admin_notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.admin_notifications_id_seq', 45, true);


--
-- Name: app_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.app_settings_id_seq', 2, true);


--
-- Name: audio_files_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.audio_files_id_seq', 8, true);


--
-- Name: batch_jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.batch_jobs_id_seq', 1, false);


--
-- Name: notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tienthuan
--

SELECT pg_catalog.setval('public.notifications_id_seq', 2, true);


--
-- Name: payment_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.payment_settings_id_seq', 1, false);


--
-- Name: payments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.payments_id_seq', 10, true);


--
-- Name: playlist_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.playlist_items_id_seq', 1, false);


--
-- Name: playlists_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.playlists_id_seq', 1, false);


--
-- Name: social_accounts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tienthuan
--

SELECT pg_catalog.setval('public.social_accounts_id_seq', 20, true);


--
-- Name: support_tickets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.support_tickets_id_seq', 1, false);


--
-- Name: system_metrics_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.system_metrics_id_seq', 1, false);


--
-- Name: templates_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tienthuan
--

SELECT pg_catalog.setval('public.templates_id_seq', 3, true);


--
-- Name: text_templates_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.text_templates_id_seq', 1, false);


--
-- Name: ticket_messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.ticket_messages_id_seq', 1, false);


--
-- Name: user_notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.user_notifications_id_seq', 85, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.users_id_seq', 29, true);


--
-- Name: voice_usage_stats_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.voice_usage_stats_id_seq', 1, false);


--
-- Name: activity_logs activity_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.activity_logs
    ADD CONSTRAINT activity_logs_pkey PRIMARY KEY (id);


--
-- Name: admin_notifications admin_notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.admin_notifications
    ADD CONSTRAINT admin_notifications_pkey PRIMARY KEY (id);


--
-- Name: app_settings app_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.app_settings
    ADD CONSTRAINT app_settings_pkey PRIMARY KEY (id);


--
-- Name: audio_files audio_files_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.audio_files
    ADD CONSTRAINT audio_files_pkey PRIMARY KEY (id);


--
-- Name: audio_files audio_files_share_id_unique; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.audio_files
    ADD CONSTRAINT audio_files_share_id_unique UNIQUE (share_id);


--
-- Name: batch_jobs batch_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.batch_jobs
    ADD CONSTRAINT batch_jobs_pkey PRIMARY KEY (id);


--
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: tienthuan
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (id);


--
-- Name: payment_settings payment_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.payment_settings
    ADD CONSTRAINT payment_settings_pkey PRIMARY KEY (id);


--
-- Name: payments payments_order_id_unique; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_order_id_unique UNIQUE (order_id);


--
-- Name: payments payments_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (id);


--
-- Name: playlist_items playlist_items_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.playlist_items
    ADD CONSTRAINT playlist_items_pkey PRIMARY KEY (id);


--
-- Name: playlists playlists_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.playlists
    ADD CONSTRAINT playlists_pkey PRIMARY KEY (id);


--
-- Name: playlists playlists_share_id_unique; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.playlists
    ADD CONSTRAINT playlists_share_id_unique UNIQUE (share_id);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: tienthuan
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (sid);


--
-- Name: social_accounts social_accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: tienthuan
--

ALTER TABLE ONLY public.social_accounts
    ADD CONSTRAINT social_accounts_pkey PRIMARY KEY (id);


--
-- Name: support_tickets support_tickets_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.support_tickets
    ADD CONSTRAINT support_tickets_pkey PRIMARY KEY (id);


--
-- Name: system_metrics system_metrics_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.system_metrics
    ADD CONSTRAINT system_metrics_pkey PRIMARY KEY (id);


--
-- Name: templates templates_pkey; Type: CONSTRAINT; Schema: public; Owner: tienthuan
--

ALTER TABLE ONLY public.templates
    ADD CONSTRAINT templates_pkey PRIMARY KEY (id);


--
-- Name: text_templates text_templates_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.text_templates
    ADD CONSTRAINT text_templates_pkey PRIMARY KEY (id);


--
-- Name: ticket_messages ticket_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.ticket_messages
    ADD CONSTRAINT ticket_messages_pkey PRIMARY KEY (id);


--
-- Name: user_notifications user_notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.user_notifications
    ADD CONSTRAINT user_notifications_pkey PRIMARY KEY (id);


--
-- Name: users users_email_unique; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_unique UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_username_unique; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_unique UNIQUE (username);


--
-- Name: voice_usage_stats voice_usage_stats_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.voice_usage_stats
    ADD CONSTRAINT voice_usage_stats_pkey PRIMARY KEY (id);


--
-- Name: IDX_session_expire; Type: INDEX; Schema: public; Owner: tienthuan
--

CREATE INDEX "IDX_session_expire" ON public.sessions USING btree (expire);


--
-- Name: activity_logs activity_logs_user_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.activity_logs
    ADD CONSTRAINT activity_logs_user_id_users_id_fk FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: audio_files audio_files_user_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.audio_files
    ADD CONSTRAINT audio_files_user_id_users_id_fk FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: batch_jobs batch_jobs_user_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.batch_jobs
    ADD CONSTRAINT batch_jobs_user_id_users_id_fk FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: payments payments_confirmed_by_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_confirmed_by_users_id_fk FOREIGN KEY (confirmed_by) REFERENCES public.users(id);


--
-- Name: payments payments_user_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_user_id_users_id_fk FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: playlist_items playlist_items_audio_file_id_audio_files_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.playlist_items
    ADD CONSTRAINT playlist_items_audio_file_id_audio_files_id_fk FOREIGN KEY (audio_file_id) REFERENCES public.audio_files(id);


--
-- Name: playlist_items playlist_items_playlist_id_playlists_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.playlist_items
    ADD CONSTRAINT playlist_items_playlist_id_playlists_id_fk FOREIGN KEY (playlist_id) REFERENCES public.playlists(id);


--
-- Name: playlists playlists_user_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.playlists
    ADD CONSTRAINT playlists_user_id_users_id_fk FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: social_accounts social_accounts_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tienthuan
--

ALTER TABLE ONLY public.social_accounts
    ADD CONSTRAINT social_accounts_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: support_tickets support_tickets_assigned_to_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.support_tickets
    ADD CONSTRAINT support_tickets_assigned_to_users_id_fk FOREIGN KEY (assigned_to) REFERENCES public.users(id);


--
-- Name: support_tickets support_tickets_user_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.support_tickets
    ADD CONSTRAINT support_tickets_user_id_users_id_fk FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: text_templates text_templates_user_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.text_templates
    ADD CONSTRAINT text_templates_user_id_users_id_fk FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: ticket_messages ticket_messages_ticket_id_support_tickets_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.ticket_messages
    ADD CONSTRAINT ticket_messages_ticket_id_support_tickets_id_fk FOREIGN KEY (ticket_id) REFERENCES public.support_tickets(id) ON DELETE CASCADE;


--
-- Name: ticket_messages ticket_messages_user_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.ticket_messages
    ADD CONSTRAINT ticket_messages_user_id_users_id_fk FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: user_notifications user_notifications_user_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.user_notifications
    ADD CONSTRAINT user_notifications_user_id_users_id_fk FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: cloud_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE cloud_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO neon_superuser WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: cloud_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE cloud_admin IN SCHEMA public GRANT ALL ON TABLES TO neon_superuser WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

