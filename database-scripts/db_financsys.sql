--
-- PostgreSQL database dump
--

-- Dumped from database version 11.4 (Ubuntu 11.4-0ubuntu0.19.04.1)
-- Dumped by pg_dump version 11.4 (Ubuntu 11.4-0ubuntu0.19.04.1)

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
-- Name: test_dev; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA test_dev;


ALTER SCHEMA test_dev OWNER TO postgres;

--
-- Name: ltree; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS ltree WITH SCHEMA public;


--
-- Name: EXTENSION ltree; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION ltree IS 'data type for hierarchical tree-like structures';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: acc_bank; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.acc_bank (
    id_bank integer NOT NULL,
    namebank character varying(150) NOT NULL,
    state boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone
);


ALTER TABLE public.acc_bank OWNER TO postgres;

--
-- Name: TABLE acc_bank; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.acc_bank IS 'Banco';


--
-- Name: acc_bank_id_bank_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.acc_bank_id_bank_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.acc_bank_id_bank_seq OWNER TO postgres;

--
-- Name: acc_bank_id_bank_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.acc_bank_id_bank_seq OWNED BY public.acc_bank.id_bank;


--
-- Name: acc_banktypeaccount; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.acc_banktypeaccount (
    id_banktypeaccount integer NOT NULL,
    namebanktypeaccount character varying(100) NOT NULL,
    state boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone
);


ALTER TABLE public.acc_banktypeaccount OWNER TO postgres;

--
-- Name: TABLE acc_banktypeaccount; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.acc_banktypeaccount IS 'Tipo Cuenta Bancaria';


--
-- Name: acc_banktypeaccount_id_banktypeaccount_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.acc_banktypeaccount_id_banktypeaccount_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.acc_banktypeaccount_id_banktypeaccount_seq OWNER TO postgres;

--
-- Name: acc_banktypeaccount_id_banktypeaccount_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.acc_banktypeaccount_id_banktypeaccount_seq OWNED BY public.acc_banktypeaccount.id_banktypeaccount;


--
-- Name: acc_categoryitem; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.acc_categoryitem (
    id_categoryitem integer NOT NULL,
    namecategoryitem character varying(100) NOT NULL,
    state boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone
);


ALTER TABLE public.acc_categoryitem OWNER TO postgres;

--
-- Name: TABLE acc_categoryitem; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.acc_categoryitem IS 'Categoria Item';


--
-- Name: acc_categoryitem_id_categoryitem_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.acc_categoryitem_id_categoryitem_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.acc_categoryitem_id_categoryitem_seq OWNER TO postgres;

--
-- Name: acc_categoryitem_id_categoryitem_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.acc_categoryitem_id_categoryitem_seq OWNED BY public.acc_categoryitem.id_categoryitem;


--
-- Name: acc_paymentform; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.acc_paymentform (
    id_paymentform integer NOT NULL,
    namepaymentform character varying(250) NOT NULL,
    code character varying(10),
    state boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone
);


ALTER TABLE public.acc_paymentform OWNER TO postgres;

--
-- Name: TABLE acc_paymentform; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.acc_paymentform IS 'Forma Pago';


--
-- Name: acc_paymentform_id_paymentform_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.acc_paymentform_id_paymentform_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.acc_paymentform_id_paymentform_seq OWNER TO postgres;

--
-- Name: acc_paymentform_id_paymentform_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.acc_paymentform_id_paymentform_seq OWNED BY public.acc_paymentform.id_paymentform;


--
-- Name: acc_typeaccount; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.acc_typeaccount (
    id_typeaccount integer NOT NULL,
    nametypeaccount character varying(250) NOT NULL,
    state boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone
);


ALTER TABLE public.acc_typeaccount OWNER TO postgres;

--
-- Name: TABLE acc_typeaccount; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.acc_typeaccount IS 'Tipo de Cuenta';


--
-- Name: acc_typeaccount_id_typeaccount_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.acc_typeaccount_id_typeaccount_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.acc_typeaccount_id_typeaccount_seq OWNER TO postgres;

--
-- Name: acc_typeaccount_id_typeaccount_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.acc_typeaccount_id_typeaccount_seq OWNED BY public.acc_typeaccount.id_typeaccount;


--
-- Name: acc_typeincomeegress; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.acc_typeincomeegress (
    id_typeincomeegress integer NOT NULL,
    nametypeincomeegress character varying(100) NOT NULL,
    state boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone
);


ALTER TABLE public.acc_typeincomeegress OWNER TO postgres;

--
-- Name: TABLE acc_typeincomeegress; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.acc_typeincomeegress IS 'Tipo Ingreso Egreso';


--
-- Name: acc_typeincomeegress_id_typeincomeegress_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.acc_typeincomeegress_id_typeincomeegress_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.acc_typeincomeegress_id_typeincomeegress_seq OWNER TO postgres;

--
-- Name: acc_typeincomeegress_id_typeincomeegress_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.acc_typeincomeegress_id_typeincomeegress_seq OWNED BY public.acc_typeincomeegress.id_typeincomeegress;


--
-- Name: acc_typetransaction; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.acc_typetransaction (
    id_typetransaction integer NOT NULL,
    nametypetransaction character varying(150) NOT NULL,
    acronym character varying(10) NOT NULL,
    state boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone
);


ALTER TABLE public.acc_typetransaction OWNER TO postgres;

--
-- Name: TABLE acc_typetransaction; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.acc_typetransaction IS 'Tipo Transaccion';


--
-- Name: acc_typetransaction_id_typetransaction_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.acc_typetransaction_id_typetransaction_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.acc_typetransaction_id_typetransaction_seq OWNER TO postgres;

--
-- Name: acc_typetransaction_id_typetransaction_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.acc_typetransaction_id_typetransaction_seq OWNED BY public.acc_typetransaction.id_typetransaction;


--
-- Name: hrr_paymentcategory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hrr_paymentcategory (
    id_paymentcategory integer NOT NULL,
    namepaymentcategory character varying(100) NOT NULL,
    state boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone
);


ALTER TABLE public.hrr_paymentcategory OWNER TO postgres;

--
-- Name: TABLE hrr_paymentcategory; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.hrr_paymentcategory IS 'Categoria Pago';


--
-- Name: hrr_paymentcategory_id_paymentcategory_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.hrr_paymentcategory_id_paymentcategory_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hrr_paymentcategory_id_paymentcategory_seq OWNER TO postgres;

--
-- Name: hrr_paymentcategory_id_paymentcategory_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.hrr_paymentcategory_id_paymentcategory_seq OWNED BY public.hrr_paymentcategory.id_paymentcategory;


--
-- Name: hrr_paymentconcept; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hrr_paymentconcept (
    id_paymentconcept integer NOT NULL,
    id_paymentcategory integer NOT NULL,
    namepaymentconcept character varying(250) NOT NULL,
    unit character(1) NOT NULL,
    "group" character(1),
    contributesiess boolean DEFAULT true NOT NULL,
    action character(1) NOT NULL,
    formulavalue character varying(50),
    formulatotal character varying(50),
    tax_value numeric(10,2),
    state boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone
);


ALTER TABLE public.hrr_paymentconcept OWNER TO postgres;

--
-- Name: TABLE hrr_paymentconcept; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.hrr_paymentconcept IS 'Conceto de Pago RRHH';


--
-- Name: hrr_paymentconcept_id_paymentconcept_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.hrr_paymentconcept_id_paymentconcept_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hrr_paymentconcept_id_paymentconcept_seq OWNER TO postgres;

--
-- Name: hrr_paymentconcept_id_paymentconcept_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.hrr_paymentconcept_id_paymentconcept_seq OWNED BY public.hrr_paymentconcept.id_paymentconcept;


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


ALTER TABLE public.migrations_id_seq OWNER TO postgres;

--
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;


--
-- Name: oauth_access_tokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oauth_access_tokens (
    id character varying(100) NOT NULL,
    user_id integer,
    client_id integer NOT NULL,
    name character varying(255),
    scopes text,
    revoked boolean NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    expires_at timestamp(0) without time zone
);


ALTER TABLE public.oauth_access_tokens OWNER TO postgres;

--
-- Name: oauth_auth_codes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oauth_auth_codes (
    id character varying(100) NOT NULL,
    user_id integer NOT NULL,
    client_id integer NOT NULL,
    scopes text,
    revoked boolean NOT NULL,
    expires_at timestamp(0) without time zone
);


ALTER TABLE public.oauth_auth_codes OWNER TO postgres;

--
-- Name: oauth_clients; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oauth_clients (
    id integer NOT NULL,
    user_id integer,
    name character varying(255) NOT NULL,
    secret character varying(100) NOT NULL,
    redirect text NOT NULL,
    personal_access_client boolean NOT NULL,
    password_client boolean NOT NULL,
    revoked boolean NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.oauth_clients OWNER TO postgres;

--
-- Name: oauth_clients_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oauth_clients_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.oauth_clients_id_seq OWNER TO postgres;

--
-- Name: oauth_clients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oauth_clients_id_seq OWNED BY public.oauth_clients.id;


--
-- Name: oauth_personal_access_clients; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oauth_personal_access_clients (
    id integer NOT NULL,
    client_id integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.oauth_personal_access_clients OWNER TO postgres;

--
-- Name: oauth_personal_access_clients_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oauth_personal_access_clients_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.oauth_personal_access_clients_id_seq OWNER TO postgres;

--
-- Name: oauth_personal_access_clients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oauth_personal_access_clients_id_seq OWNED BY public.oauth_personal_access_clients.id;


--
-- Name: oauth_refresh_tokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oauth_refresh_tokens (
    id character varying(100) NOT NULL,
    access_token_id character varying(100) NOT NULL,
    revoked boolean NOT NULL,
    expires_at timestamp(0) without time zone
);


ALTER TABLE public.oauth_refresh_tokens OWNER TO postgres;

--
-- Name: password_resets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.password_resets (
    email character varying(255) NOT NULL,
    token character varying(255) NOT NULL,
    created_at timestamp(0) without time zone
);


ALTER TABLE public.password_resets OWNER TO postgres;

--
-- Name: sys_city; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sys_city (
    id_city integer NOT NULL,
    id_province integer NOT NULL,
    namecity character varying(250) NOT NULL,
    state boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone
);


ALTER TABLE public.sys_city OWNER TO postgres;

--
-- Name: TABLE sys_city; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sys_city IS 'Ciudad';


--
-- Name: sys_city_id_city_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sys_city_id_city_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sys_city_id_city_seq OWNER TO postgres;

--
-- Name: sys_city_id_city_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sys_city_id_city_seq OWNED BY public.sys_city.id_city;


--
-- Name: sys_permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sys_permission (
    id_permission integer NOT NULL,
    namepermission character varying(250) NOT NULL,
    state boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone
);


ALTER TABLE public.sys_permission OWNER TO postgres;

--
-- Name: TABLE sys_permission; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sys_permission IS 'Permisos';


--
-- Name: sys_permission_id_permission_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sys_permission_id_permission_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sys_permission_id_permission_seq OWNER TO postgres;

--
-- Name: sys_permission_id_permission_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sys_permission_id_permission_seq OWNED BY public.sys_permission.id_permission;


--
-- Name: sys_province; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sys_province (
    id_province integer NOT NULL,
    id_country integer NOT NULL,
    nameprovince character varying(150) NOT NULL,
    state boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone
);


ALTER TABLE public.sys_province OWNER TO postgres;

--
-- Name: TABLE sys_province; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sys_province IS 'Provincia';


--
-- Name: sys_province_id_province_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sys_province_id_province_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sys_province_id_province_seq OWNER TO postgres;

--
-- Name: sys_province_id_province_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sys_province_id_province_seq OWNED BY public.sys_province.id_province;


--
-- Name: sys_registrationschema; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sys_registrationschema (
    id_registrationschema integer NOT NULL,
    nameschema character varying(10) NOT NULL,
    state boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone
);


ALTER TABLE public.sys_registrationschema OWNER TO postgres;

--
-- Name: TABLE sys_registrationschema; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sys_registrationschema IS 'Registro Esquemas';


--
-- Name: sys_registrationschema_id_registrationschema_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sys_registrationschema_id_registrationschema_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sys_registrationschema_id_registrationschema_seq OWNER TO postgres;

--
-- Name: sys_registrationschema_id_registrationschema_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sys_registrationschema_id_registrationschema_seq OWNED BY public.sys_registrationschema.id_registrationschema;


--
-- Name: sys_registrationschema_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sys_registrationschema_user (
    id_registrationschema integer NOT NULL,
    id_user integer NOT NULL,
    state boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.sys_registrationschema_user OWNER TO postgres;

--
-- Name: sys_webconnectsri; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sys_webconnectsri (
    id_webconnectsri integer NOT NULL,
    id_typeenvironment integer NOT NULL,
    urlreception text NOT NULL,
    urlauthorization text NOT NULL,
    state boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone
);


ALTER TABLE public.sys_webconnectsri OWNER TO postgres;

--
-- Name: TABLE sys_webconnectsri; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sys_webconnectsri IS 'Conexion SRI';


--
-- Name: sys_webconnectsri_id_webconnectsri_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sys_webconnectsri_id_webconnectsri_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sys_webconnectsri_id_webconnectsri_seq OWNER TO postgres;

--
-- Name: sys_webconnectsri_id_webconnectsri_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sys_webconnectsri_id_webconnectsri_seq OWNED BY public.sys_webconnectsri.id_webconnectsri;


--
-- Name: tax_country; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tax_country (
    id_country integer NOT NULL,
    namecountry character varying(100) NOT NULL,
    code character varying(10),
    state boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone
);


ALTER TABLE public.tax_country OWNER TO postgres;

--
-- Name: TABLE tax_country; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.tax_country IS 'Pago Pais';


--
-- Name: tax_country_id_country_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tax_country_id_country_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tax_country_id_country_seq OWNER TO postgres;

--
-- Name: tax_country_id_country_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tax_country_id_country_seq OWNED BY public.tax_country.id_country;


--
-- Name: tax_part; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tax_part (
    id_part integer NOT NULL,
    namepart character varying(50) NOT NULL,
    code character varying(10),
    state boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone
);


ALTER TABLE public.tax_part OWNER TO postgres;

--
-- Name: TABLE tax_part; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.tax_part IS 'SRI Parte';


--
-- Name: tax_part_id_part_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tax_part_id_part_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tax_part_id_part_seq OWNER TO postgres;

--
-- Name: tax_part_id_part_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tax_part_id_part_seq OWNED BY public.tax_part.id_part;


--
-- Name: tax_paymentresident; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tax_paymentresident (
    id_paymentresident integer NOT NULL,
    namepaymentresident character varying(150) NOT NULL,
    code character varying(10),
    state boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone
);


ALTER TABLE public.tax_paymentresident OWNER TO postgres;

--
-- Name: TABLE tax_paymentresident; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.tax_paymentresident IS 'Tipo Pago a Residente';


--
-- Name: tax_paymentresident_id_paymentresident_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tax_paymentresident_id_paymentresident_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tax_paymentresident_id_paymentresident_seq OWNER TO postgres;

--
-- Name: tax_paymentresident_id_paymentresident_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tax_paymentresident_id_paymentresident_seq OWNED BY public.tax_paymentresident.id_paymentresident;


--
-- Name: tax_tax; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tax_tax (
    id_tax integer NOT NULL,
    id_typetax integer NOT NULL,
    nametax character varying(150) NOT NULL,
    code character varying(10),
    percentage numeric(10,2) DEFAULT 0.00 NOT NULL,
    rate numeric(10,2),
    state boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone
);


ALTER TABLE public.tax_tax OWNER TO postgres;

--
-- Name: TABLE tax_tax; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.tax_tax IS 'Impuestos';


--
-- Name: tax_tax_id_tax_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tax_tax_id_tax_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tax_tax_id_tax_seq OWNER TO postgres;

--
-- Name: tax_tax_id_tax_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tax_tax_id_tax_seq OWNED BY public.tax_tax.id_tax;


--
-- Name: tax_taxretention; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tax_taxretention (
    id_taxretention integer NOT NULL,
    id_typetaxretention integer NOT NULL,
    nametaxretention character varying(150) NOT NULL,
    code character varying(10),
    percentage numeric(10,2) DEFAULT 0.00 NOT NULL,
    state boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone
);


ALTER TABLE public.tax_taxretention OWNER TO postgres;

--
-- Name: TABLE tax_taxretention; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.tax_taxretention IS 'Impuestos Retencion';


--
-- Name: tax_taxretention_id_taxretention_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tax_taxretention_id_taxretention_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tax_taxretention_id_taxretention_seq OWNER TO postgres;

--
-- Name: tax_taxretention_id_taxretention_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tax_taxretention_id_taxretention_seq OWNED BY public.tax_taxretention.id_taxretention;


--
-- Name: tax_taxsupport; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tax_taxsupport (
    id_taxsupport integer NOT NULL,
    nametaxsupport character varying(250) NOT NULL,
    code character varying(10),
    state boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone
);


ALTER TABLE public.tax_taxsupport OWNER TO postgres;

--
-- Name: TABLE tax_taxsupport; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.tax_taxsupport IS 'Sustento Tributario';


--
-- Name: tax_taxsupport_id_taxsupport_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tax_taxsupport_id_taxsupport_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tax_taxsupport_id_taxsupport_seq OWNER TO postgres;

--
-- Name: tax_taxsupport_id_taxsupport_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tax_taxsupport_id_taxsupport_seq OWNED BY public.tax_taxsupport.id_taxsupport;


--
-- Name: tax_typecompany; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tax_typecompany (
    id_typecompany integer NOT NULL,
    nametypecompany character varying(250) NOT NULL,
    code character varying(10),
    state boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone
);


ALTER TABLE public.tax_typecompany OWNER TO postgres;

--
-- Name: TABLE tax_typecompany; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.tax_typecompany IS 'Tipo Empresa';


--
-- Name: tax_typecompany_id_typecompany_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tax_typecompany_id_typecompany_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tax_typecompany_id_typecompany_seq OWNER TO postgres;

--
-- Name: tax_typecompany_id_typecompany_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tax_typecompany_id_typecompany_seq OWNED BY public.tax_typecompany.id_typecompany;


--
-- Name: tax_typedocument; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tax_typedocument (
    id_typedocument integer NOT NULL,
    nametypedocument character varying(50) NOT NULL,
    code character varying(10),
    state boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone
);


ALTER TABLE public.tax_typedocument OWNER TO postgres;

--
-- Name: TABLE tax_typedocument; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.tax_typedocument IS 'Tipo Documento';


--
-- Name: tax_typedocument_id_typedocument_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tax_typedocument_id_typedocument_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tax_typedocument_id_typedocument_seq OWNER TO postgres;

--
-- Name: tax_typedocument_id_typedocument_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tax_typedocument_id_typedocument_seq OWNED BY public.tax_typedocument.id_typedocument;


--
-- Name: tax_typeemission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tax_typeemission (
    id_typeemission integer NOT NULL,
    nametypeemission character varying(150) NOT NULL,
    code character varying(10) NOT NULL,
    state boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone
);


ALTER TABLE public.tax_typeemission OWNER TO postgres;

--
-- Name: TABLE tax_typeemission; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.tax_typeemission IS 'Tipo Emision';


--
-- Name: tax_typeemission_id_typeemission_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tax_typeemission_id_typeemission_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tax_typeemission_id_typeemission_seq OWNER TO postgres;

--
-- Name: tax_typeemission_id_typeemission_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tax_typeemission_id_typeemission_seq OWNED BY public.tax_typeemission.id_typeemission;


--
-- Name: tax_typeenvironment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tax_typeenvironment (
    id_typeenvironment integer NOT NULL,
    nametypeenvironment character varying(150) NOT NULL,
    code character varying(10),
    state boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone
);


ALTER TABLE public.tax_typeenvironment OWNER TO postgres;

--
-- Name: TABLE tax_typeenvironment; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.tax_typeenvironment IS 'Tipo de Ambiente';


--
-- Name: tax_typeenvironment_id_typeenvironment_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tax_typeenvironment_id_typeenvironment_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tax_typeenvironment_id_typeenvironment_seq OWNER TO postgres;

--
-- Name: tax_typeenvironment_id_typeenvironment_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tax_typeenvironment_id_typeenvironment_seq OWNED BY public.tax_typeenvironment.id_typeenvironment;


--
-- Name: tax_typeidentification; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tax_typeidentification (
    id_typeidentification integer NOT NULL,
    nametypeidentification character varying(150) NOT NULL,
    code character varying(10),
    state boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone
);


ALTER TABLE public.tax_typeidentification OWNER TO postgres;

--
-- Name: TABLE tax_typeidentification; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.tax_typeidentification IS 'Tipo Identificacion';


--
-- Name: tax_typeidentification_id_typeidentification_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tax_typeidentification_id_typeidentification_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tax_typeidentification_id_typeidentification_seq OWNER TO postgres;

--
-- Name: tax_typeidentification_id_typeidentification_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tax_typeidentification_id_typeidentification_seq OWNED BY public.tax_typeidentification.id_typeidentification;


--
-- Name: tax_typetax; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tax_typetax (
    id_typetax integer NOT NULL,
    nametypetax character varying(150) NOT NULL,
    code character varying(10),
    state boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone
);


ALTER TABLE public.tax_typetax OWNER TO postgres;

--
-- Name: TABLE tax_typetax; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.tax_typetax IS 'Tipo Impuesto';


--
-- Name: tax_typetax_id_typetax_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tax_typetax_id_typetax_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tax_typetax_id_typetax_seq OWNER TO postgres;

--
-- Name: tax_typetax_id_typetax_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tax_typetax_id_typetax_seq OWNED BY public.tax_typetax.id_typetax;


--
-- Name: tax_typetaxretention; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tax_typetaxretention (
    id_typetaxretention integer NOT NULL,
    nametypetaxretention character varying(250) NOT NULL,
    code character varying(10),
    state boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone
);


ALTER TABLE public.tax_typetaxretention OWNER TO postgres;

--
-- Name: TABLE tax_typetaxretention; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.tax_typetaxretention IS 'Tipo Impuesto Retencion';


--
-- Name: tax_typetaxretention_id_typetaxretention_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tax_typetaxretention_id_typetaxretention_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tax_typetaxretention_id_typetaxretention_seq OWNER TO postgres;

--
-- Name: tax_typetaxretention_id_typetaxretention_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tax_typetaxretention_id_typetaxretention_seq OWNED BY public.tax_typetaxretention.id_typetaxretention;


--
-- Name: tax_typevoucher; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tax_typevoucher (
    id_typevoucher integer NOT NULL,
    nametypevoucher character varying(250) NOT NULL,
    code character varying(10),
    state boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone
);


ALTER TABLE public.tax_typevoucher OWNER TO postgres;

--
-- Name: TABLE tax_typevoucher; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.tax_typevoucher IS 'Tipo Comprobante';


--
-- Name: tax_typevoucher_id_typevoucher_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tax_typevoucher_id_typevoucher_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tax_typevoucher_id_typevoucher_seq OWNER TO postgres;

--
-- Name: tax_typevoucher_id_typevoucher_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tax_typevoucher_id_typevoucher_seq OWNED BY public.tax_typevoucher.id_typevoucher;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
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
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: acc_ accountingrecord; Type: TABLE; Schema: test_dev; Owner: postgres
--

CREATE TABLE test_dev."acc_ accountingrecord" (
    id_accountingrecord integer NOT NULL,
    id_accountplan integer NOT NULL,
    id_transaction integer NOT NULL,
    id_conciliation integer,
    registrationdate date NOT NULL,
    description text NOT NULL,
    should numeric(10,4) DEFAULT 0.0000 NOT NULL,
    tohave numeric(10,4) DEFAULT 0.0000 NOT NULL,
    should_c numeric(10,4) DEFAULT 0.0000 NOT NULL,
    tohave_c numeric(10,4) DEFAULT 0.0000 NOT NULL,
    state boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone
);


ALTER TABLE test_dev."acc_ accountingrecord" OWNER TO postgres;

--
-- Name: TABLE "acc_ accountingrecord"; Type: COMMENT; Schema: test_dev; Owner: postgres
--

COMMENT ON TABLE test_dev."acc_ accountingrecord" IS 'Registro Contable';


--
-- Name: acc_ accountingrecord_id_accountingrecord_seq; Type: SEQUENCE; Schema: test_dev; Owner: postgres
--

CREATE SEQUENCE test_dev."acc_ accountingrecord_id_accountingrecord_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE test_dev."acc_ accountingrecord_id_accountingrecord_seq" OWNER TO postgres;

--
-- Name: acc_ accountingrecord_id_accountingrecord_seq; Type: SEQUENCE OWNED BY; Schema: test_dev; Owner: postgres
--

ALTER SEQUENCE test_dev."acc_ accountingrecord_id_accountingrecord_seq" OWNED BY test_dev."acc_ accountingrecord".id_accountingrecord;


--
-- Name: acc_accountplan; Type: TABLE; Schema: test_dev; Owner: postgres
--

CREATE TABLE test_dev.acc_accountplan (
    id_accountplan integer NOT NULL,
    id_typeaccount integer,
    hierarchy public.ltree NOT NULL,
    concept text NOT NULL,
    codeniff character varying(10),
    code character varying(10),
    typefinancialstate character(1) NOT NULL,
    controlhaving character(1) NOT NULL,
    accounttype character varying(5) NOT NULL,
    state boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone
);


ALTER TABLE test_dev.acc_accountplan OWNER TO postgres;

--
-- Name: TABLE acc_accountplan; Type: COMMENT; Schema: test_dev; Owner: postgres
--

COMMENT ON TABLE test_dev.acc_accountplan IS 'Plan de Cuenta';


--
-- Name: acc_accountplan_id_accountplan_seq; Type: SEQUENCE; Schema: test_dev; Owner: postgres
--

CREATE SEQUENCE test_dev.acc_accountplan_id_accountplan_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE test_dev.acc_accountplan_id_accountplan_seq OWNER TO postgres;

--
-- Name: acc_accountplan_id_accountplan_seq; Type: SEQUENCE OWNED BY; Schema: test_dev; Owner: postgres
--

ALTER SEQUENCE test_dev.acc_accountplan_id_accountplan_seq OWNED BY test_dev.acc_accountplan.id_accountplan;


--
-- Name: acc_client; Type: TABLE; Schema: test_dev; Owner: postgres
--

CREATE TABLE test_dev.acc_client (
    id_client integer NOT NULL,
    id_accountplan integer NOT NULL,
    id_tax integer NOT NULL,
    id_typecompany integer NOT NULL,
    id_part integer NOT NULL,
    id_paymentterm integer NOT NULL,
    id_typeidentification integer NOT NULL,
    businessid character varying(13) NOT NULL,
    businessname character varying(250) NOT NULL,
    tradename character varying(250) NOT NULL,
    admissiondate date,
    address text,
    telephone character varying(20),
    email text NOT NULL,
    state boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone
);


ALTER TABLE test_dev.acc_client OWNER TO postgres;

--
-- Name: TABLE acc_client; Type: COMMENT; Schema: test_dev; Owner: postgres
--

COMMENT ON TABLE test_dev.acc_client IS 'Clientes';


--
-- Name: acc_client_id_client_seq; Type: SEQUENCE; Schema: test_dev; Owner: postgres
--

CREATE SEQUENCE test_dev.acc_client_id_client_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE test_dev.acc_client_id_client_seq OWNER TO postgres;

--
-- Name: acc_client_id_client_seq; Type: SEQUENCE OWNED BY; Schema: test_dev; Owner: postgres
--

ALTER SEQUENCE test_dev.acc_client_id_client_seq OWNED BY test_dev.acc_client.id_client;


--
-- Name: acc_conciliation; Type: TABLE; Schema: test_dev; Owner: postgres
--

CREATE TABLE test_dev.acc_conciliation (
    id_conciliation integer NOT NULL,
    id_accountplan integer NOT NULL,
    conciliationdate date NOT NULL,
    initialbalance numeric(10,4) DEFAULT 0.0000 NOT NULL,
    finalbalance numeric(10,4) DEFAULT 0.0000 NOT NULL,
    stateconciliation character(1) NOT NULL,
    state boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone
);


ALTER TABLE test_dev.acc_conciliation OWNER TO postgres;

--
-- Name: TABLE acc_conciliation; Type: COMMENT; Schema: test_dev; Owner: postgres
--

COMMENT ON TABLE test_dev.acc_conciliation IS 'Conciliacion';


--
-- Name: acc_conciliation_id_conciliation_seq; Type: SEQUENCE; Schema: test_dev; Owner: postgres
--

CREATE SEQUENCE test_dev.acc_conciliation_id_conciliation_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE test_dev.acc_conciliation_id_conciliation_seq OWNER TO postgres;

--
-- Name: acc_conciliation_id_conciliation_seq; Type: SEQUENCE OWNED BY; Schema: test_dev; Owner: postgres
--

ALTER SEQUENCE test_dev.acc_conciliation_id_conciliation_seq OWNED BY test_dev.acc_conciliation.id_conciliation;


--
-- Name: acc_item; Type: TABLE; Schema: test_dev; Owner: postgres
--

CREATE TABLE test_dev.acc_item (
    id_item integer NOT NULL,
    id_accountplanentry integer,
    id_accountplancost integer,
    id_taxiva integer NOT NULL,
    id_taxice integer,
    id_categoryitem integer NOT NULL,
    id_typeunit integer,
    code character varying(25) NOT NULL,
    description text NOT NULL,
    referenceprice numeric(10,4) DEFAULT 0.0000 NOT NULL,
    state boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone
);


ALTER TABLE test_dev.acc_item OWNER TO postgres;

--
-- Name: TABLE acc_item; Type: COMMENT; Schema: test_dev; Owner: postgres
--

COMMENT ON TABLE test_dev.acc_item IS 'Items';


--
-- Name: COLUMN acc_item.id_accountplanentry; Type: COMMENT; Schema: test_dev; Owner: postgres
--

COMMENT ON COLUMN test_dev.acc_item.id_accountplanentry IS 'id plancuenta ingreso';


--
-- Name: COLUMN acc_item.id_accountplancost; Type: COMMENT; Schema: test_dev; Owner: postgres
--

COMMENT ON COLUMN test_dev.acc_item.id_accountplancost IS 'id plancuenta costo';


--
-- Name: acc_item_id_item_seq; Type: SEQUENCE; Schema: test_dev; Owner: postgres
--

CREATE SEQUENCE test_dev.acc_item_id_item_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE test_dev.acc_item_id_item_seq OWNER TO postgres;

--
-- Name: acc_item_id_item_seq; Type: SEQUENCE OWNED BY; Schema: test_dev; Owner: postgres
--

ALTER SEQUENCE test_dev.acc_item_id_item_seq OWNED BY test_dev.acc_item.id_item;


--
-- Name: acc_item_warehouse; Type: TABLE; Schema: test_dev; Owner: postgres
--

CREATE TABLE test_dev.acc_item_warehouse (
    id_item_warehouse integer NOT NULL,
    id_item integer NOT NULL,
    id_warehouse integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE test_dev.acc_item_warehouse OWNER TO postgres;

--
-- Name: TABLE acc_item_warehouse; Type: COMMENT; Schema: test_dev; Owner: postgres
--

COMMENT ON TABLE test_dev.acc_item_warehouse IS 'Item - Bodega';


--
-- Name: acc_item_warehouse_id_item_warehouse_seq; Type: SEQUENCE; Schema: test_dev; Owner: postgres
--

CREATE SEQUENCE test_dev.acc_item_warehouse_id_item_warehouse_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE test_dev.acc_item_warehouse_id_item_warehouse_seq OWNER TO postgres;

--
-- Name: acc_item_warehouse_id_item_warehouse_seq; Type: SEQUENCE OWNED BY; Schema: test_dev; Owner: postgres
--

ALTER SEQUENCE test_dev.acc_item_warehouse_id_item_warehouse_seq OWNED BY test_dev.acc_item_warehouse.id_item_warehouse;


--
-- Name: acc_itemphoto; Type: TABLE; Schema: test_dev; Owner: postgres
--

CREATE TABLE test_dev.acc_itemphoto (
    id_itemphoto integer NOT NULL,
    id_item integer NOT NULL,
    urlphoto text NOT NULL,
    mainphoto boolean NOT NULL,
    state boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE test_dev.acc_itemphoto OWNER TO postgres;

--
-- Name: TABLE acc_itemphoto; Type: COMMENT; Schema: test_dev; Owner: postgres
--

COMMENT ON TABLE test_dev.acc_itemphoto IS 'Foto de Items';


--
-- Name: acc_itemphoto_id_itemphoto_seq; Type: SEQUENCE; Schema: test_dev; Owner: postgres
--

CREATE SEQUENCE test_dev.acc_itemphoto_id_itemphoto_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE test_dev.acc_itemphoto_id_itemphoto_seq OWNER TO postgres;

--
-- Name: acc_itemphoto_id_itemphoto_seq; Type: SEQUENCE OWNED BY; Schema: test_dev; Owner: postgres
--

ALTER SEQUENCE test_dev.acc_itemphoto_id_itemphoto_seq OWNED BY test_dev.acc_itemphoto.id_itemphoto;


--
-- Name: acc_kardex; Type: TABLE; Schema: test_dev; Owner: postgres
--

CREATE TABLE test_dev.acc_kardex (
    id_kardex integer NOT NULL,
    id_transaction integer NOT NULL,
    id_item_warehouse integer NOT NULL,
    registrationdate date NOT NULL,
    quantity numeric(10,4) DEFAULT 0.0000 NOT NULL,
    unitcost numeric(10,4) DEFAULT 0.0000 NOT NULL,
    totalcost numeric(10,4) DEFAULT 0.0000 NOT NULL,
    typeinputoutput integer NOT NULL,
    description text,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone
);


ALTER TABLE test_dev.acc_kardex OWNER TO postgres;

--
-- Name: TABLE acc_kardex; Type: COMMENT; Schema: test_dev; Owner: postgres
--

COMMENT ON TABLE test_dev.acc_kardex IS 'Kardex Inventario';


--
-- Name: acc_kardex_id_kardex_seq; Type: SEQUENCE; Schema: test_dev; Owner: postgres
--

CREATE SEQUENCE test_dev.acc_kardex_id_kardex_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE test_dev.acc_kardex_id_kardex_seq OWNER TO postgres;

--
-- Name: acc_kardex_id_kardex_seq; Type: SEQUENCE OWNED BY; Schema: test_dev; Owner: postgres
--

ALTER SEQUENCE test_dev.acc_kardex_id_kardex_seq OWNED BY test_dev.acc_kardex.id_kardex;


--
-- Name: acc_paymentterm; Type: TABLE; Schema: test_dev; Owner: postgres
--

CREATE TABLE test_dev.acc_paymentterm (
    id_paymentterm integer NOT NULL,
    namepaymentterm character varying(150) NOT NULL,
    daysterm integer DEFAULT 0 NOT NULL,
    frequency integer DEFAULT 1 NOT NULL,
    state boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone
);


ALTER TABLE test_dev.acc_paymentterm OWNER TO postgres;

--
-- Name: TABLE acc_paymentterm; Type: COMMENT; Schema: test_dev; Owner: postgres
--

COMMENT ON TABLE test_dev.acc_paymentterm IS 'Termino de Pago';


--
-- Name: acc_paymentterm_id_paymentterm_seq; Type: SEQUENCE; Schema: test_dev; Owner: postgres
--

CREATE SEQUENCE test_dev.acc_paymentterm_id_paymentterm_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE test_dev.acc_paymentterm_id_paymentterm_seq OWNER TO postgres;

--
-- Name: acc_paymentterm_id_paymentterm_seq; Type: SEQUENCE OWNED BY; Schema: test_dev; Owner: postgres
--

ALTER SEQUENCE test_dev.acc_paymentterm_id_paymentterm_seq OWNED BY test_dev.acc_paymentterm.id_paymentterm;


--
-- Name: acc_provider; Type: TABLE; Schema: test_dev; Owner: postgres
--

CREATE TABLE test_dev.acc_provider (
    id_provider integer NOT NULL,
    id_accountplan integer NOT NULL,
    id_tax integer NOT NULL,
    id_typecompany integer NOT NULL,
    id_part integer NOT NULL,
    id_paymentterm integer NOT NULL,
    id_typeidentification integer NOT NULL,
    businessid character varying(13) NOT NULL,
    businessname character varying(250) NOT NULL,
    tradename character varying(250) NOT NULL,
    admissiondate date NOT NULL,
    email text NOT NULL,
    address text,
    telephone character varying(20),
    state boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone
);


ALTER TABLE test_dev.acc_provider OWNER TO postgres;

--
-- Name: TABLE acc_provider; Type: COMMENT; Schema: test_dev; Owner: postgres
--

COMMENT ON TABLE test_dev.acc_provider IS 'Proveedor';


--
-- Name: acc_provider_id_provider_seq; Type: SEQUENCE; Schema: test_dev; Owner: postgres
--

CREATE SEQUENCE test_dev.acc_provider_id_provider_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE test_dev.acc_provider_id_provider_seq OWNER TO postgres;

--
-- Name: acc_provider_id_provider_seq; Type: SEQUENCE OWNED BY; Schema: test_dev; Owner: postgres
--

ALTER SEQUENCE test_dev.acc_provider_id_provider_seq OWNED BY test_dev.acc_provider.id_provider;


--
-- Name: acc_registrationclient; Type: TABLE; Schema: test_dev; Owner: postgres
--

CREATE TABLE test_dev.acc_registrationclient (
    id_registrationclient integer NOT NULL,
    id_transaction integer NOT NULL,
    id_client integer NOT NULL,
    registrationdate date NOT NULL,
    should numeric(10,4) DEFAULT 0.0000 NOT NULL,
    tohave numeric(10,4) DEFAULT 0.0000 NOT NULL,
    documentnumber character varying(250) NOT NULL,
    state boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone
);


ALTER TABLE test_dev.acc_registrationclient OWNER TO postgres;

--
-- Name: TABLE acc_registrationclient; Type: COMMENT; Schema: test_dev; Owner: postgres
--

COMMENT ON TABLE test_dev.acc_registrationclient IS 'Registro Cliente';


--
-- Name: acc_registrationclient_id_registrationclient_seq; Type: SEQUENCE; Schema: test_dev; Owner: postgres
--

CREATE SEQUENCE test_dev.acc_registrationclient_id_registrationclient_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE test_dev.acc_registrationclient_id_registrationclient_seq OWNER TO postgres;

--
-- Name: acc_registrationclient_id_registrationclient_seq; Type: SEQUENCE OWNED BY; Schema: test_dev; Owner: postgres
--

ALTER SEQUENCE test_dev.acc_registrationclient_id_registrationclient_seq OWNED BY test_dev.acc_registrationclient.id_registrationclient;


--
-- Name: acc_registrationprovider; Type: TABLE; Schema: test_dev; Owner: postgres
--

CREATE TABLE test_dev.acc_registrationprovider (
    id_registrationprovider integer NOT NULL,
    id_transaction integer NOT NULL,
    id_provider integer NOT NULL,
    registrationdate date NOT NULL,
    should numeric(10,4) DEFAULT 0.0000 NOT NULL,
    tohave numeric(10,4) DEFAULT 0.0000 NOT NULL,
    documentnumber character varying(250) NOT NULL,
    state boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone
);


ALTER TABLE test_dev.acc_registrationprovider OWNER TO postgres;

--
-- Name: TABLE acc_registrationprovider; Type: COMMENT; Schema: test_dev; Owner: postgres
--

COMMENT ON TABLE test_dev.acc_registrationprovider IS 'Registro Proveedores';


--
-- Name: acc_registrationprovider_id_registrationprovider_seq; Type: SEQUENCE; Schema: test_dev; Owner: postgres
--

CREATE SEQUENCE test_dev.acc_registrationprovider_id_registrationprovider_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE test_dev.acc_registrationprovider_id_registrationprovider_seq OWNER TO postgres;

--
-- Name: acc_registrationprovider_id_registrationprovider_seq; Type: SEQUENCE OWNED BY; Schema: test_dev; Owner: postgres
--

ALTER SEQUENCE test_dev.acc_registrationprovider_id_registrationprovider_seq OWNED BY test_dev.acc_registrationprovider.id_registrationprovider;


--
-- Name: acc_transaction; Type: TABLE; Schema: test_dev; Owner: postgres
--

CREATE TABLE test_dev.acc_transaction (
    id_transaction integer NOT NULL,
    id_typetransaction integer NOT NULL,
    datetransaction date NOT NULL,
    vouchernumber integer NOT NULL,
    accountingnumber integer NOT NULL,
    description text NOT NULL,
    state boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone
);


ALTER TABLE test_dev.acc_transaction OWNER TO postgres;

--
-- Name: TABLE acc_transaction; Type: COMMENT; Schema: test_dev; Owner: postgres
--

COMMENT ON TABLE test_dev.acc_transaction IS 'Transaccion';


--
-- Name: acc_transaction_id_transaction_seq; Type: SEQUENCE; Schema: test_dev; Owner: postgres
--

CREATE SEQUENCE test_dev.acc_transaction_id_transaction_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE test_dev.acc_transaction_id_transaction_seq OWNER TO postgres;

--
-- Name: acc_transaction_id_transaction_seq; Type: SEQUENCE OWNED BY; Schema: test_dev; Owner: postgres
--

ALTER SEQUENCE test_dev.acc_transaction_id_transaction_seq OWNED BY test_dev.acc_transaction.id_transaction;


--
-- Name: acc_typeunit; Type: TABLE; Schema: test_dev; Owner: postgres
--

CREATE TABLE test_dev.acc_typeunit (
    id_typeunit integer NOT NULL,
    nametypeunit character varying(100) NOT NULL,
    acronym character varying(10) NOT NULL,
    state boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone
);


ALTER TABLE test_dev.acc_typeunit OWNER TO postgres;

--
-- Name: TABLE acc_typeunit; Type: COMMENT; Schema: test_dev; Owner: postgres
--

COMMENT ON TABLE test_dev.acc_typeunit IS 'Tipo Unidad';


--
-- Name: acc_typeunit_id_typeunit_seq; Type: SEQUENCE; Schema: test_dev; Owner: postgres
--

CREATE SEQUENCE test_dev.acc_typeunit_id_typeunit_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE test_dev.acc_typeunit_id_typeunit_seq OWNER TO postgres;

--
-- Name: acc_typeunit_id_typeunit_seq; Type: SEQUENCE OWNED BY; Schema: test_dev; Owner: postgres
--

ALTER SEQUENCE test_dev.acc_typeunit_id_typeunit_seq OWNED BY test_dev.acc_typeunit.id_typeunit;


--
-- Name: acc_warehouse; Type: TABLE; Schema: test_dev; Owner: postgres
--

CREATE TABLE test_dev.acc_warehouse (
    id_warehouse integer NOT NULL,
    id_accountplan integer NOT NULL,
    code character varying(10) NOT NULL,
    namewarehouse character varying(150) NOT NULL,
    address text,
    description text,
    state boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone
);


ALTER TABLE test_dev.acc_warehouse OWNER TO postgres;

--
-- Name: TABLE acc_warehouse; Type: COMMENT; Schema: test_dev; Owner: postgres
--

COMMENT ON TABLE test_dev.acc_warehouse IS 'Bodega';


--
-- Name: acc_warehouse_id_warehouse_seq; Type: SEQUENCE; Schema: test_dev; Owner: postgres
--

CREATE SEQUENCE test_dev.acc_warehouse_id_warehouse_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE test_dev.acc_warehouse_id_warehouse_seq OWNER TO postgres;

--
-- Name: acc_warehouse_id_warehouse_seq; Type: SEQUENCE OWNED BY; Schema: test_dev; Owner: postgres
--

ALTER SEQUENCE test_dev.acc_warehouse_id_warehouse_seq OWNED BY test_dev.acc_warehouse.id_warehouse;


--
-- Name: hrr_paymentconcept_accountplan; Type: TABLE; Schema: test_dev; Owner: postgres
--

CREATE TABLE test_dev.hrr_paymentconcept_accountplan (
    id_paymentconcept integer NOT NULL,
    id_accountplan integer NOT NULL,
    id_accountplan_extra integer,
    tax_value numeric(10,2),
    state boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE test_dev.hrr_paymentconcept_accountplan OWNER TO postgres;

--
-- Name: TABLE hrr_paymentconcept_accountplan; Type: COMMENT; Schema: test_dev; Owner: postgres
--

COMMENT ON TABLE test_dev.hrr_paymentconcept_accountplan IS 'Conceptos Rol de Pago - Plan Cuenta';


--
-- Name: sys_permission_role; Type: TABLE; Schema: test_dev; Owner: postgres
--

CREATE TABLE test_dev.sys_permission_role (
    id_permission integer NOT NULL,
    id_role integer NOT NULL,
    state boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE test_dev.sys_permission_role OWNER TO postgres;

--
-- Name: TABLE sys_permission_role; Type: COMMENT; Schema: test_dev; Owner: postgres
--

COMMENT ON TABLE test_dev.sys_permission_role IS 'Relacion Permiso Rol';


--
-- Name: sys_role; Type: TABLE; Schema: test_dev; Owner: postgres
--

CREATE TABLE test_dev.sys_role (
    id_role integer NOT NULL,
    namerole character varying(100) NOT NULL,
    state boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone
);


ALTER TABLE test_dev.sys_role OWNER TO postgres;

--
-- Name: TABLE sys_role; Type: COMMENT; Schema: test_dev; Owner: postgres
--

COMMENT ON TABLE test_dev.sys_role IS 'Rol';


--
-- Name: sys_role_id_role_seq; Type: SEQUENCE; Schema: test_dev; Owner: postgres
--

CREATE SEQUENCE test_dev.sys_role_id_role_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE test_dev.sys_role_id_role_seq OWNER TO postgres;

--
-- Name: sys_role_id_role_seq; Type: SEQUENCE OWNED BY; Schema: test_dev; Owner: postgres
--

ALTER SEQUENCE test_dev.sys_role_id_role_seq OWNED BY test_dev.sys_role.id_role;


--
-- Name: sys_user_role; Type: TABLE; Schema: test_dev; Owner: postgres
--

CREATE TABLE test_dev.sys_user_role (
    id_user integer NOT NULL,
    id_role integer NOT NULL,
    state boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE test_dev.sys_user_role OWNER TO postgres;

--
-- Name: TABLE sys_user_role; Type: COMMENT; Schema: test_dev; Owner: postgres
--

COMMENT ON TABLE test_dev.sys_user_role IS 'Usuario - Rol';


--
-- Name: tax_establishment; Type: TABLE; Schema: test_dev; Owner: postgres
--

CREATE TABLE test_dev.tax_establishment (
    id_establishment integer NOT NULL,
    id_typecompany integer NOT NULL,
    businessid character varying(13) NOT NULL,
    businessname character varying(250) NOT NULL,
    tradename character varying(250) NOT NULL,
    specialtaxpayer character varying(10),
    forcedaccounting boolean NOT NULL,
    address text NOT NULL,
    telephone character varying(15),
    email character varying(250),
    urllogo text,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE test_dev.tax_establishment OWNER TO postgres;

--
-- Name: TABLE tax_establishment; Type: COMMENT; Schema: test_dev; Owner: postgres
--

COMMENT ON TABLE test_dev.tax_establishment IS 'Establecimiento Matriz';


--
-- Name: tax_establishment_id_establishment_seq; Type: SEQUENCE; Schema: test_dev; Owner: postgres
--

CREATE SEQUENCE test_dev.tax_establishment_id_establishment_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE test_dev.tax_establishment_id_establishment_seq OWNER TO postgres;

--
-- Name: tax_establishment_id_establishment_seq; Type: SEQUENCE OWNED BY; Schema: test_dev; Owner: postgres
--

ALTER SEQUENCE test_dev.tax_establishment_id_establishment_seq OWNED BY test_dev.tax_establishment.id_establishment;


--
-- Name: tax_establishmentemission; Type: TABLE; Schema: test_dev; Owner: postgres
--

CREATE TABLE test_dev.tax_establishmentemission (
    id_establishmentemission integer NOT NULL,
    establishmentemission character varying(3) NOT NULL,
    address text NOT NULL,
    description text,
    state boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone
);


ALTER TABLE test_dev.tax_establishmentemission OWNER TO postgres;

--
-- Name: TABLE tax_establishmentemission; Type: COMMENT; Schema: test_dev; Owner: postgres
--

COMMENT ON TABLE test_dev.tax_establishmentemission IS 'Establecimiento emision';


--
-- Name: tax_establishmentemission_id_establishmentemission_seq; Type: SEQUENCE; Schema: test_dev; Owner: postgres
--

CREATE SEQUENCE test_dev.tax_establishmentemission_id_establishmentemission_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE test_dev.tax_establishmentemission_id_establishmentemission_seq OWNER TO postgres;

--
-- Name: tax_establishmentemission_id_establishmentemission_seq; Type: SEQUENCE OWNED BY; Schema: test_dev; Owner: postgres
--

ALTER SEQUENCE test_dev.tax_establishmentemission_id_establishmentemission_seq OWNED BY test_dev.tax_establishmentemission.id_establishmentemission;


--
-- Name: tax_pointsaleemission; Type: TABLE; Schema: test_dev; Owner: postgres
--

CREATE TABLE test_dev.tax_pointsaleemission (
    id_pointsaleemission integer NOT NULL,
    id_establishmentemission integer NOT NULL,
    pointsaleemission character varying(3) NOT NULL,
    description text,
    state boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone
);


ALTER TABLE test_dev.tax_pointsaleemission OWNER TO postgres;

--
-- Name: TABLE tax_pointsaleemission; Type: COMMENT; Schema: test_dev; Owner: postgres
--

COMMENT ON TABLE test_dev.tax_pointsaleemission IS 'Punto de Venta Emision';


--
-- Name: tax_pointsaleemission_id_pointsaleemission_seq; Type: SEQUENCE; Schema: test_dev; Owner: postgres
--

CREATE SEQUENCE test_dev.tax_pointsaleemission_id_pointsaleemission_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE test_dev.tax_pointsaleemission_id_pointsaleemission_seq OWNER TO postgres;

--
-- Name: tax_pointsaleemission_id_pointsaleemission_seq; Type: SEQUENCE OWNED BY; Schema: test_dev; Owner: postgres
--

ALTER SEQUENCE test_dev.tax_pointsaleemission_id_pointsaleemission_seq OWNED BY test_dev.tax_pointsaleemission.id_pointsaleemission;


--
-- Name: tax_tax_accountplan; Type: TABLE; Schema: test_dev; Owner: postgres
--

CREATE TABLE test_dev.tax_tax_accountplan (
    id_tax integer NOT NULL,
    id_accountplan integer NOT NULL,
    state boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE test_dev.tax_tax_accountplan OWNER TO postgres;

--
-- Name: TABLE tax_tax_accountplan; Type: COMMENT; Schema: test_dev; Owner: postgres
--

COMMENT ON TABLE test_dev.tax_tax_accountplan IS 'Impuesto - Plan Cuenta';


--
-- Name: tax_taxretention_accountplan; Type: TABLE; Schema: test_dev; Owner: postgres
--

CREATE TABLE test_dev.tax_taxretention_accountplan (
    id_taxretention integer NOT NULL,
    id_accountplan integer NOT NULL,
    state boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE test_dev.tax_taxretention_accountplan OWNER TO postgres;

--
-- Name: TABLE tax_taxretention_accountplan; Type: COMMENT; Schema: test_dev; Owner: postgres
--

COMMENT ON TABLE test_dev.tax_taxretention_accountplan IS 'Impuestos Retencion - Plan Cuenta';


--
-- Name: acc_bank id_bank; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.acc_bank ALTER COLUMN id_bank SET DEFAULT nextval('public.acc_bank_id_bank_seq'::regclass);


--
-- Name: acc_banktypeaccount id_banktypeaccount; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.acc_banktypeaccount ALTER COLUMN id_banktypeaccount SET DEFAULT nextval('public.acc_banktypeaccount_id_banktypeaccount_seq'::regclass);


--
-- Name: acc_categoryitem id_categoryitem; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.acc_categoryitem ALTER COLUMN id_categoryitem SET DEFAULT nextval('public.acc_categoryitem_id_categoryitem_seq'::regclass);


--
-- Name: acc_paymentform id_paymentform; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.acc_paymentform ALTER COLUMN id_paymentform SET DEFAULT nextval('public.acc_paymentform_id_paymentform_seq'::regclass);


--
-- Name: acc_typeaccount id_typeaccount; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.acc_typeaccount ALTER COLUMN id_typeaccount SET DEFAULT nextval('public.acc_typeaccount_id_typeaccount_seq'::regclass);


--
-- Name: acc_typeincomeegress id_typeincomeegress; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.acc_typeincomeegress ALTER COLUMN id_typeincomeegress SET DEFAULT nextval('public.acc_typeincomeegress_id_typeincomeegress_seq'::regclass);


--
-- Name: acc_typetransaction id_typetransaction; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.acc_typetransaction ALTER COLUMN id_typetransaction SET DEFAULT nextval('public.acc_typetransaction_id_typetransaction_seq'::regclass);


--
-- Name: hrr_paymentcategory id_paymentcategory; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hrr_paymentcategory ALTER COLUMN id_paymentcategory SET DEFAULT nextval('public.hrr_paymentcategory_id_paymentcategory_seq'::regclass);


--
-- Name: hrr_paymentconcept id_paymentconcept; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hrr_paymentconcept ALTER COLUMN id_paymentconcept SET DEFAULT nextval('public.hrr_paymentconcept_id_paymentconcept_seq'::regclass);


--
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- Name: oauth_clients id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oauth_clients ALTER COLUMN id SET DEFAULT nextval('public.oauth_clients_id_seq'::regclass);


--
-- Name: oauth_personal_access_clients id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oauth_personal_access_clients ALTER COLUMN id SET DEFAULT nextval('public.oauth_personal_access_clients_id_seq'::regclass);


--
-- Name: sys_city id_city; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_city ALTER COLUMN id_city SET DEFAULT nextval('public.sys_city_id_city_seq'::regclass);


--
-- Name: sys_permission id_permission; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_permission ALTER COLUMN id_permission SET DEFAULT nextval('public.sys_permission_id_permission_seq'::regclass);


--
-- Name: sys_province id_province; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_province ALTER COLUMN id_province SET DEFAULT nextval('public.sys_province_id_province_seq'::regclass);


--
-- Name: sys_registrationschema id_registrationschema; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_registrationschema ALTER COLUMN id_registrationschema SET DEFAULT nextval('public.sys_registrationschema_id_registrationschema_seq'::regclass);


--
-- Name: sys_webconnectsri id_webconnectsri; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_webconnectsri ALTER COLUMN id_webconnectsri SET DEFAULT nextval('public.sys_webconnectsri_id_webconnectsri_seq'::regclass);


--
-- Name: tax_country id_country; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tax_country ALTER COLUMN id_country SET DEFAULT nextval('public.tax_country_id_country_seq'::regclass);


--
-- Name: tax_part id_part; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tax_part ALTER COLUMN id_part SET DEFAULT nextval('public.tax_part_id_part_seq'::regclass);


--
-- Name: tax_paymentresident id_paymentresident; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tax_paymentresident ALTER COLUMN id_paymentresident SET DEFAULT nextval('public.tax_paymentresident_id_paymentresident_seq'::regclass);


--
-- Name: tax_tax id_tax; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tax_tax ALTER COLUMN id_tax SET DEFAULT nextval('public.tax_tax_id_tax_seq'::regclass);


--
-- Name: tax_taxretention id_taxretention; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tax_taxretention ALTER COLUMN id_taxretention SET DEFAULT nextval('public.tax_taxretention_id_taxretention_seq'::regclass);


--
-- Name: tax_taxsupport id_taxsupport; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tax_taxsupport ALTER COLUMN id_taxsupport SET DEFAULT nextval('public.tax_taxsupport_id_taxsupport_seq'::regclass);


--
-- Name: tax_typecompany id_typecompany; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tax_typecompany ALTER COLUMN id_typecompany SET DEFAULT nextval('public.tax_typecompany_id_typecompany_seq'::regclass);


--
-- Name: tax_typedocument id_typedocument; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tax_typedocument ALTER COLUMN id_typedocument SET DEFAULT nextval('public.tax_typedocument_id_typedocument_seq'::regclass);


--
-- Name: tax_typeemission id_typeemission; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tax_typeemission ALTER COLUMN id_typeemission SET DEFAULT nextval('public.tax_typeemission_id_typeemission_seq'::regclass);


--
-- Name: tax_typeenvironment id_typeenvironment; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tax_typeenvironment ALTER COLUMN id_typeenvironment SET DEFAULT nextval('public.tax_typeenvironment_id_typeenvironment_seq'::regclass);


--
-- Name: tax_typeidentification id_typeidentification; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tax_typeidentification ALTER COLUMN id_typeidentification SET DEFAULT nextval('public.tax_typeidentification_id_typeidentification_seq'::regclass);


--
-- Name: tax_typetax id_typetax; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tax_typetax ALTER COLUMN id_typetax SET DEFAULT nextval('public.tax_typetax_id_typetax_seq'::regclass);


--
-- Name: tax_typetaxretention id_typetaxretention; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tax_typetaxretention ALTER COLUMN id_typetaxretention SET DEFAULT nextval('public.tax_typetaxretention_id_typetaxretention_seq'::regclass);


--
-- Name: tax_typevoucher id_typevoucher; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tax_typevoucher ALTER COLUMN id_typevoucher SET DEFAULT nextval('public.tax_typevoucher_id_typevoucher_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: acc_ accountingrecord id_accountingrecord; Type: DEFAULT; Schema: test_dev; Owner: postgres
--

ALTER TABLE ONLY test_dev."acc_ accountingrecord" ALTER COLUMN id_accountingrecord SET DEFAULT nextval('test_dev."acc_ accountingrecord_id_accountingrecord_seq"'::regclass);


--
-- Name: acc_accountplan id_accountplan; Type: DEFAULT; Schema: test_dev; Owner: postgres
--

ALTER TABLE ONLY test_dev.acc_accountplan ALTER COLUMN id_accountplan SET DEFAULT nextval('test_dev.acc_accountplan_id_accountplan_seq'::regclass);


--
-- Name: acc_client id_client; Type: DEFAULT; Schema: test_dev; Owner: postgres
--

ALTER TABLE ONLY test_dev.acc_client ALTER COLUMN id_client SET DEFAULT nextval('test_dev.acc_client_id_client_seq'::regclass);


--
-- Name: acc_conciliation id_conciliation; Type: DEFAULT; Schema: test_dev; Owner: postgres
--

ALTER TABLE ONLY test_dev.acc_conciliation ALTER COLUMN id_conciliation SET DEFAULT nextval('test_dev.acc_conciliation_id_conciliation_seq'::regclass);


--
-- Name: acc_item id_item; Type: DEFAULT; Schema: test_dev; Owner: postgres
--

ALTER TABLE ONLY test_dev.acc_item ALTER COLUMN id_item SET DEFAULT nextval('test_dev.acc_item_id_item_seq'::regclass);


--
-- Name: acc_item_warehouse id_item_warehouse; Type: DEFAULT; Schema: test_dev; Owner: postgres
--

ALTER TABLE ONLY test_dev.acc_item_warehouse ALTER COLUMN id_item_warehouse SET DEFAULT nextval('test_dev.acc_item_warehouse_id_item_warehouse_seq'::regclass);


--
-- Name: acc_itemphoto id_itemphoto; Type: DEFAULT; Schema: test_dev; Owner: postgres
--

ALTER TABLE ONLY test_dev.acc_itemphoto ALTER COLUMN id_itemphoto SET DEFAULT nextval('test_dev.acc_itemphoto_id_itemphoto_seq'::regclass);


--
-- Name: acc_kardex id_kardex; Type: DEFAULT; Schema: test_dev; Owner: postgres
--

ALTER TABLE ONLY test_dev.acc_kardex ALTER COLUMN id_kardex SET DEFAULT nextval('test_dev.acc_kardex_id_kardex_seq'::regclass);


--
-- Name: acc_paymentterm id_paymentterm; Type: DEFAULT; Schema: test_dev; Owner: postgres
--

ALTER TABLE ONLY test_dev.acc_paymentterm ALTER COLUMN id_paymentterm SET DEFAULT nextval('test_dev.acc_paymentterm_id_paymentterm_seq'::regclass);


--
-- Name: acc_provider id_provider; Type: DEFAULT; Schema: test_dev; Owner: postgres
--

ALTER TABLE ONLY test_dev.acc_provider ALTER COLUMN id_provider SET DEFAULT nextval('test_dev.acc_provider_id_provider_seq'::regclass);


--
-- Name: acc_registrationclient id_registrationclient; Type: DEFAULT; Schema: test_dev; Owner: postgres
--

ALTER TABLE ONLY test_dev.acc_registrationclient ALTER COLUMN id_registrationclient SET DEFAULT nextval('test_dev.acc_registrationclient_id_registrationclient_seq'::regclass);


--
-- Name: acc_registrationprovider id_registrationprovider; Type: DEFAULT; Schema: test_dev; Owner: postgres
--

ALTER TABLE ONLY test_dev.acc_registrationprovider ALTER COLUMN id_registrationprovider SET DEFAULT nextval('test_dev.acc_registrationprovider_id_registrationprovider_seq'::regclass);


--
-- Name: acc_transaction id_transaction; Type: DEFAULT; Schema: test_dev; Owner: postgres
--

ALTER TABLE ONLY test_dev.acc_transaction ALTER COLUMN id_transaction SET DEFAULT nextval('test_dev.acc_transaction_id_transaction_seq'::regclass);


--
-- Name: acc_typeunit id_typeunit; Type: DEFAULT; Schema: test_dev; Owner: postgres
--

ALTER TABLE ONLY test_dev.acc_typeunit ALTER COLUMN id_typeunit SET DEFAULT nextval('test_dev.acc_typeunit_id_typeunit_seq'::regclass);


--
-- Name: acc_warehouse id_warehouse; Type: DEFAULT; Schema: test_dev; Owner: postgres
--

ALTER TABLE ONLY test_dev.acc_warehouse ALTER COLUMN id_warehouse SET DEFAULT nextval('test_dev.acc_warehouse_id_warehouse_seq'::regclass);


--
-- Name: sys_role id_role; Type: DEFAULT; Schema: test_dev; Owner: postgres
--

ALTER TABLE ONLY test_dev.sys_role ALTER COLUMN id_role SET DEFAULT nextval('test_dev.sys_role_id_role_seq'::regclass);


--
-- Name: tax_establishment id_establishment; Type: DEFAULT; Schema: test_dev; Owner: postgres
--

ALTER TABLE ONLY test_dev.tax_establishment ALTER COLUMN id_establishment SET DEFAULT nextval('test_dev.tax_establishment_id_establishment_seq'::regclass);


--
-- Name: tax_establishmentemission id_establishmentemission; Type: DEFAULT; Schema: test_dev; Owner: postgres
--

ALTER TABLE ONLY test_dev.tax_establishmentemission ALTER COLUMN id_establishmentemission SET DEFAULT nextval('test_dev.tax_establishmentemission_id_establishmentemission_seq'::regclass);


--
-- Name: tax_pointsaleemission id_pointsaleemission; Type: DEFAULT; Schema: test_dev; Owner: postgres
--

ALTER TABLE ONLY test_dev.tax_pointsaleemission ALTER COLUMN id_pointsaleemission SET DEFAULT nextval('test_dev.tax_pointsaleemission_id_pointsaleemission_seq'::regclass);


--
-- Data for Name: acc_bank; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: acc_banktypeaccount; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: acc_categoryitem; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: acc_paymentform; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: acc_typeaccount; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: acc_typeincomeegress; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: acc_typetransaction; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: hrr_paymentcategory; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: hrr_paymentconcept; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.migrations (id, migration, batch) VALUES (1, '2014_10_12_000000_create_users_table', 1);
INSERT INTO public.migrations (id, migration, batch) VALUES (2, '2014_10_12_100000_create_password_resets_table', 1);
INSERT INTO public.migrations (id, migration, batch) VALUES (3, '2016_06_01_000001_create_oauth_auth_codes_table', 1);
INSERT INTO public.migrations (id, migration, batch) VALUES (4, '2016_06_01_000002_create_oauth_access_tokens_table', 1);
INSERT INTO public.migrations (id, migration, batch) VALUES (5, '2016_06_01_000003_create_oauth_refresh_tokens_table', 1);
INSERT INTO public.migrations (id, migration, batch) VALUES (6, '2016_06_01_000004_create_oauth_clients_table', 1);
INSERT INTO public.migrations (id, migration, batch) VALUES (7, '2016_06_01_000005_create_oauth_personal_access_clients_table', 1);


--
-- Data for Name: oauth_access_tokens; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: oauth_auth_codes; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: oauth_clients; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.oauth_clients (id, user_id, name, secret, redirect, personal_access_client, password_client, revoked, created_at, updated_at) VALUES (1, NULL, 'Laravel Personal Access Client', 'QPNvmEXkZ9XphAqFD4F8cklGQtQqvWl4olxKXsq2', 'http://localhost', true, false, false, '2019-08-01 08:00:07', '2019-08-01 08:00:07');
INSERT INTO public.oauth_clients (id, user_id, name, secret, redirect, personal_access_client, password_client, revoked, created_at, updated_at) VALUES (2, NULL, 'Laravel Password Grant Client', 'kJZkniJhLYnkBsZG95BBhrr29pXOoO8IqFRq5ooy', 'http://localhost', false, true, false, '2019-08-01 08:00:07', '2019-08-01 08:00:07');


--
-- Data for Name: oauth_personal_access_clients; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.oauth_personal_access_clients (id, client_id, created_at, updated_at) VALUES (1, 1, '2019-08-01 08:00:07', '2019-08-01 08:00:07');


--
-- Data for Name: oauth_refresh_tokens; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: password_resets; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: sys_city; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: sys_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: sys_province; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: sys_registrationschema; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: sys_registrationschema_user; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: sys_webconnectsri; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: tax_country; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: tax_part; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: tax_paymentresident; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: tax_tax; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: tax_taxretention; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: tax_taxsupport; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: tax_typecompany; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: tax_typedocument; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: tax_typeemission; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: tax_typeenvironment; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: tax_typeidentification; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: tax_typetax; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: tax_typetaxretention; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: tax_typevoucher; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: acc_ accountingrecord; Type: TABLE DATA; Schema: test_dev; Owner: postgres
--



--
-- Data for Name: acc_accountplan; Type: TABLE DATA; Schema: test_dev; Owner: postgres
--



--
-- Data for Name: acc_client; Type: TABLE DATA; Schema: test_dev; Owner: postgres
--



--
-- Data for Name: acc_conciliation; Type: TABLE DATA; Schema: test_dev; Owner: postgres
--



--
-- Data for Name: acc_item; Type: TABLE DATA; Schema: test_dev; Owner: postgres
--



--
-- Data for Name: acc_item_warehouse; Type: TABLE DATA; Schema: test_dev; Owner: postgres
--



--
-- Data for Name: acc_itemphoto; Type: TABLE DATA; Schema: test_dev; Owner: postgres
--



--
-- Data for Name: acc_kardex; Type: TABLE DATA; Schema: test_dev; Owner: postgres
--



--
-- Data for Name: acc_paymentterm; Type: TABLE DATA; Schema: test_dev; Owner: postgres
--



--
-- Data for Name: acc_provider; Type: TABLE DATA; Schema: test_dev; Owner: postgres
--



--
-- Data for Name: acc_registrationclient; Type: TABLE DATA; Schema: test_dev; Owner: postgres
--



--
-- Data for Name: acc_registrationprovider; Type: TABLE DATA; Schema: test_dev; Owner: postgres
--



--
-- Data for Name: acc_transaction; Type: TABLE DATA; Schema: test_dev; Owner: postgres
--



--
-- Data for Name: acc_typeunit; Type: TABLE DATA; Schema: test_dev; Owner: postgres
--



--
-- Data for Name: acc_warehouse; Type: TABLE DATA; Schema: test_dev; Owner: postgres
--



--
-- Data for Name: hrr_paymentconcept_accountplan; Type: TABLE DATA; Schema: test_dev; Owner: postgres
--



--
-- Data for Name: sys_permission_role; Type: TABLE DATA; Schema: test_dev; Owner: postgres
--



--
-- Data for Name: sys_role; Type: TABLE DATA; Schema: test_dev; Owner: postgres
--



--
-- Data for Name: sys_user_role; Type: TABLE DATA; Schema: test_dev; Owner: postgres
--



--
-- Data for Name: tax_establishment; Type: TABLE DATA; Schema: test_dev; Owner: postgres
--



--
-- Data for Name: tax_establishmentemission; Type: TABLE DATA; Schema: test_dev; Owner: postgres
--



--
-- Data for Name: tax_pointsaleemission; Type: TABLE DATA; Schema: test_dev; Owner: postgres
--



--
-- Data for Name: tax_tax_accountplan; Type: TABLE DATA; Schema: test_dev; Owner: postgres
--



--
-- Data for Name: tax_taxretention_accountplan; Type: TABLE DATA; Schema: test_dev; Owner: postgres
--



--
-- Name: acc_bank_id_bank_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.acc_bank_id_bank_seq', 1, false);


--
-- Name: acc_banktypeaccount_id_banktypeaccount_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.acc_banktypeaccount_id_banktypeaccount_seq', 1, false);


--
-- Name: acc_categoryitem_id_categoryitem_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.acc_categoryitem_id_categoryitem_seq', 1, false);


--
-- Name: acc_paymentform_id_paymentform_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.acc_paymentform_id_paymentform_seq', 1, false);


--
-- Name: acc_typeaccount_id_typeaccount_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.acc_typeaccount_id_typeaccount_seq', 1, false);


--
-- Name: acc_typeincomeegress_id_typeincomeegress_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.acc_typeincomeegress_id_typeincomeegress_seq', 1, false);


--
-- Name: acc_typetransaction_id_typetransaction_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.acc_typetransaction_id_typetransaction_seq', 1, false);


--
-- Name: hrr_paymentcategory_id_paymentcategory_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.hrr_paymentcategory_id_paymentcategory_seq', 1, false);


--
-- Name: hrr_paymentconcept_id_paymentconcept_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.hrr_paymentconcept_id_paymentconcept_seq', 1, false);


--
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.migrations_id_seq', 7, true);


--
-- Name: oauth_clients_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oauth_clients_id_seq', 2, true);


--
-- Name: oauth_personal_access_clients_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oauth_personal_access_clients_id_seq', 1, true);


--
-- Name: sys_city_id_city_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sys_city_id_city_seq', 1, false);


--
-- Name: sys_permission_id_permission_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sys_permission_id_permission_seq', 1, false);


--
-- Name: sys_province_id_province_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sys_province_id_province_seq', 1, false);


--
-- Name: sys_registrationschema_id_registrationschema_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sys_registrationschema_id_registrationschema_seq', 1, false);


--
-- Name: sys_webconnectsri_id_webconnectsri_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sys_webconnectsri_id_webconnectsri_seq', 1, false);


--
-- Name: tax_country_id_country_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tax_country_id_country_seq', 1, false);


--
-- Name: tax_part_id_part_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tax_part_id_part_seq', 1, false);


--
-- Name: tax_paymentresident_id_paymentresident_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tax_paymentresident_id_paymentresident_seq', 1, false);


--
-- Name: tax_tax_id_tax_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tax_tax_id_tax_seq', 1, false);


--
-- Name: tax_taxretention_id_taxretention_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tax_taxretention_id_taxretention_seq', 1, false);


--
-- Name: tax_taxsupport_id_taxsupport_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tax_taxsupport_id_taxsupport_seq', 1, false);


--
-- Name: tax_typecompany_id_typecompany_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tax_typecompany_id_typecompany_seq', 1, false);


--
-- Name: tax_typedocument_id_typedocument_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tax_typedocument_id_typedocument_seq', 1, false);


--
-- Name: tax_typeemission_id_typeemission_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tax_typeemission_id_typeemission_seq', 1, false);


--
-- Name: tax_typeenvironment_id_typeenvironment_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tax_typeenvironment_id_typeenvironment_seq', 1, false);


--
-- Name: tax_typeidentification_id_typeidentification_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tax_typeidentification_id_typeidentification_seq', 1, false);


--
-- Name: tax_typetax_id_typetax_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tax_typetax_id_typetax_seq', 1, false);


--
-- Name: tax_typetaxretention_id_typetaxretention_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tax_typetaxretention_id_typetaxretention_seq', 1, false);


--
-- Name: tax_typevoucher_id_typevoucher_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tax_typevoucher_id_typevoucher_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 1, false);


--
-- Name: acc_ accountingrecord_id_accountingrecord_seq; Type: SEQUENCE SET; Schema: test_dev; Owner: postgres
--

SELECT pg_catalog.setval('test_dev."acc_ accountingrecord_id_accountingrecord_seq"', 1, false);


--
-- Name: acc_accountplan_id_accountplan_seq; Type: SEQUENCE SET; Schema: test_dev; Owner: postgres
--

SELECT pg_catalog.setval('test_dev.acc_accountplan_id_accountplan_seq', 1, false);


--
-- Name: acc_client_id_client_seq; Type: SEQUENCE SET; Schema: test_dev; Owner: postgres
--

SELECT pg_catalog.setval('test_dev.acc_client_id_client_seq', 1, false);


--
-- Name: acc_conciliation_id_conciliation_seq; Type: SEQUENCE SET; Schema: test_dev; Owner: postgres
--

SELECT pg_catalog.setval('test_dev.acc_conciliation_id_conciliation_seq', 1, false);


--
-- Name: acc_item_id_item_seq; Type: SEQUENCE SET; Schema: test_dev; Owner: postgres
--

SELECT pg_catalog.setval('test_dev.acc_item_id_item_seq', 1, false);


--
-- Name: acc_item_warehouse_id_item_warehouse_seq; Type: SEQUENCE SET; Schema: test_dev; Owner: postgres
--

SELECT pg_catalog.setval('test_dev.acc_item_warehouse_id_item_warehouse_seq', 1, false);


--
-- Name: acc_itemphoto_id_itemphoto_seq; Type: SEQUENCE SET; Schema: test_dev; Owner: postgres
--

SELECT pg_catalog.setval('test_dev.acc_itemphoto_id_itemphoto_seq', 1, false);


--
-- Name: acc_kardex_id_kardex_seq; Type: SEQUENCE SET; Schema: test_dev; Owner: postgres
--

SELECT pg_catalog.setval('test_dev.acc_kardex_id_kardex_seq', 1, false);


--
-- Name: acc_paymentterm_id_paymentterm_seq; Type: SEQUENCE SET; Schema: test_dev; Owner: postgres
--

SELECT pg_catalog.setval('test_dev.acc_paymentterm_id_paymentterm_seq', 1, false);


--
-- Name: acc_provider_id_provider_seq; Type: SEQUENCE SET; Schema: test_dev; Owner: postgres
--

SELECT pg_catalog.setval('test_dev.acc_provider_id_provider_seq', 1, false);


--
-- Name: acc_registrationclient_id_registrationclient_seq; Type: SEQUENCE SET; Schema: test_dev; Owner: postgres
--

SELECT pg_catalog.setval('test_dev.acc_registrationclient_id_registrationclient_seq', 1, false);


--
-- Name: acc_registrationprovider_id_registrationprovider_seq; Type: SEQUENCE SET; Schema: test_dev; Owner: postgres
--

SELECT pg_catalog.setval('test_dev.acc_registrationprovider_id_registrationprovider_seq', 1, false);


--
-- Name: acc_transaction_id_transaction_seq; Type: SEQUENCE SET; Schema: test_dev; Owner: postgres
--

SELECT pg_catalog.setval('test_dev.acc_transaction_id_transaction_seq', 1, false);


--
-- Name: acc_typeunit_id_typeunit_seq; Type: SEQUENCE SET; Schema: test_dev; Owner: postgres
--

SELECT pg_catalog.setval('test_dev.acc_typeunit_id_typeunit_seq', 1, false);


--
-- Name: acc_warehouse_id_warehouse_seq; Type: SEQUENCE SET; Schema: test_dev; Owner: postgres
--

SELECT pg_catalog.setval('test_dev.acc_warehouse_id_warehouse_seq', 1, false);


--
-- Name: sys_role_id_role_seq; Type: SEQUENCE SET; Schema: test_dev; Owner: postgres
--

SELECT pg_catalog.setval('test_dev.sys_role_id_role_seq', 1, false);


--
-- Name: tax_establishment_id_establishment_seq; Type: SEQUENCE SET; Schema: test_dev; Owner: postgres
--

SELECT pg_catalog.setval('test_dev.tax_establishment_id_establishment_seq', 1, false);


--
-- Name: tax_establishmentemission_id_establishmentemission_seq; Type: SEQUENCE SET; Schema: test_dev; Owner: postgres
--

SELECT pg_catalog.setval('test_dev.tax_establishmentemission_id_establishmentemission_seq', 1, false);


--
-- Name: tax_pointsaleemission_id_pointsaleemission_seq; Type: SEQUENCE SET; Schema: test_dev; Owner: postgres
--

SELECT pg_catalog.setval('test_dev.tax_pointsaleemission_id_pointsaleemission_seq', 1, false);


--
-- Name: acc_bank acc_bank_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.acc_bank
    ADD CONSTRAINT acc_bank_pk PRIMARY KEY (id_bank);


--
-- Name: acc_banktypeaccount acc_banktypeaccount_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.acc_banktypeaccount
    ADD CONSTRAINT acc_banktypeaccount_pk PRIMARY KEY (id_banktypeaccount);


--
-- Name: acc_categoryitem acc_categoryitem_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.acc_categoryitem
    ADD CONSTRAINT acc_categoryitem_pk PRIMARY KEY (id_categoryitem);


--
-- Name: acc_paymentform acc_paymentform_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.acc_paymentform
    ADD CONSTRAINT acc_paymentform_pk PRIMARY KEY (id_paymentform);


--
-- Name: acc_typeaccount acc_typeaccount_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.acc_typeaccount
    ADD CONSTRAINT acc_typeaccount_pk PRIMARY KEY (id_typeaccount);


--
-- Name: acc_typeincomeegress acc_typeincomeegress_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.acc_typeincomeegress
    ADD CONSTRAINT acc_typeincomeegress_pk PRIMARY KEY (id_typeincomeegress);


--
-- Name: acc_typetransaction acc_typetransaction_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.acc_typetransaction
    ADD CONSTRAINT acc_typetransaction_pk PRIMARY KEY (id_typetransaction);


--
-- Name: hrr_paymentcategory hrr_paymentcategory_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hrr_paymentcategory
    ADD CONSTRAINT hrr_paymentcategory_pk PRIMARY KEY (id_paymentcategory);


--
-- Name: hrr_paymentconcept hrr_paymentconcept_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hrr_paymentconcept
    ADD CONSTRAINT hrr_paymentconcept_pk PRIMARY KEY (id_paymentconcept);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: oauth_access_tokens oauth_access_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oauth_access_tokens
    ADD CONSTRAINT oauth_access_tokens_pkey PRIMARY KEY (id);


--
-- Name: oauth_auth_codes oauth_auth_codes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oauth_auth_codes
    ADD CONSTRAINT oauth_auth_codes_pkey PRIMARY KEY (id);


--
-- Name: oauth_clients oauth_clients_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oauth_clients
    ADD CONSTRAINT oauth_clients_pkey PRIMARY KEY (id);


--
-- Name: oauth_personal_access_clients oauth_personal_access_clients_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oauth_personal_access_clients
    ADD CONSTRAINT oauth_personal_access_clients_pkey PRIMARY KEY (id);


--
-- Name: oauth_refresh_tokens oauth_refresh_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oauth_refresh_tokens
    ADD CONSTRAINT oauth_refresh_tokens_pkey PRIMARY KEY (id);


--
-- Name: sys_city sys_city_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_city
    ADD CONSTRAINT sys_city_pk PRIMARY KEY (id_city);


--
-- Name: sys_permission sys_permission_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_permission
    ADD CONSTRAINT sys_permission_pk PRIMARY KEY (id_permission);


--
-- Name: sys_province sys_province_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_province
    ADD CONSTRAINT sys_province_pk PRIMARY KEY (id_province);


--
-- Name: sys_registrationschema sys_registrationschema_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_registrationschema
    ADD CONSTRAINT sys_registrationschema_pk PRIMARY KEY (id_registrationschema);


--
-- Name: sys_webconnectsri sys_webconnectsri_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_webconnectsri
    ADD CONSTRAINT sys_webconnectsri_pk PRIMARY KEY (id_webconnectsri);


--
-- Name: tax_country tax_country_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tax_country
    ADD CONSTRAINT tax_country_pk PRIMARY KEY (id_country);


--
-- Name: tax_part tax_part_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tax_part
    ADD CONSTRAINT tax_part_pk PRIMARY KEY (id_part);


--
-- Name: tax_paymentresident tax_paymentresident_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tax_paymentresident
    ADD CONSTRAINT tax_paymentresident_pk PRIMARY KEY (id_paymentresident);


--
-- Name: tax_tax tax_tax_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tax_tax
    ADD CONSTRAINT tax_tax_pk PRIMARY KEY (id_tax);


--
-- Name: tax_taxretention tax_taxretention_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tax_taxretention
    ADD CONSTRAINT tax_taxretention_pk PRIMARY KEY (id_taxretention);


--
-- Name: tax_taxsupport tax_taxsupport_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tax_taxsupport
    ADD CONSTRAINT tax_taxsupport_pk PRIMARY KEY (id_taxsupport);


--
-- Name: tax_typecompany tax_typecompany_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tax_typecompany
    ADD CONSTRAINT tax_typecompany_pk PRIMARY KEY (id_typecompany);


--
-- Name: tax_typedocument tax_typedocument_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tax_typedocument
    ADD CONSTRAINT tax_typedocument_pk PRIMARY KEY (id_typedocument);


--
-- Name: tax_typeemission tax_typeemission_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tax_typeemission
    ADD CONSTRAINT tax_typeemission_pk PRIMARY KEY (id_typeemission);


--
-- Name: tax_typeenvironment tax_typeenvironment_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tax_typeenvironment
    ADD CONSTRAINT tax_typeenvironment_pk PRIMARY KEY (id_typeenvironment);


--
-- Name: tax_typeidentification tax_typeidentification_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tax_typeidentification
    ADD CONSTRAINT tax_typeidentification_pk PRIMARY KEY (id_typeidentification);


--
-- Name: tax_typetax tax_typetax_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tax_typetax
    ADD CONSTRAINT tax_typetax_pk PRIMARY KEY (id_typetax);


--
-- Name: tax_typetaxretention tax_typetaxretention_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tax_typetaxretention
    ADD CONSTRAINT tax_typetaxretention_pk PRIMARY KEY (id_typetaxretention);


--
-- Name: tax_typevoucher tax_typevoucher_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tax_typevoucher
    ADD CONSTRAINT tax_typevoucher_pk PRIMARY KEY (id_typevoucher);


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
-- Name: acc_ accountingrecord acc_ accountingrecord_pk; Type: CONSTRAINT; Schema: test_dev; Owner: postgres
--

ALTER TABLE ONLY test_dev."acc_ accountingrecord"
    ADD CONSTRAINT "acc_ accountingrecord_pk" PRIMARY KEY (id_accountingrecord);


--
-- Name: acc_accountplan acc_accountplan_pk; Type: CONSTRAINT; Schema: test_dev; Owner: postgres
--

ALTER TABLE ONLY test_dev.acc_accountplan
    ADD CONSTRAINT acc_accountplan_pk PRIMARY KEY (id_accountplan);


--
-- Name: acc_client acc_client_pk; Type: CONSTRAINT; Schema: test_dev; Owner: postgres
--

ALTER TABLE ONLY test_dev.acc_client
    ADD CONSTRAINT acc_client_pk PRIMARY KEY (id_client);


--
-- Name: acc_conciliation acc_conciliation_pk; Type: CONSTRAINT; Schema: test_dev; Owner: postgres
--

ALTER TABLE ONLY test_dev.acc_conciliation
    ADD CONSTRAINT acc_conciliation_pk PRIMARY KEY (id_conciliation);


--
-- Name: acc_item acc_item_pk; Type: CONSTRAINT; Schema: test_dev; Owner: postgres
--

ALTER TABLE ONLY test_dev.acc_item
    ADD CONSTRAINT acc_item_pk PRIMARY KEY (id_item);


--
-- Name: acc_item_warehouse acc_item_warehouse_pk; Type: CONSTRAINT; Schema: test_dev; Owner: postgres
--

ALTER TABLE ONLY test_dev.acc_item_warehouse
    ADD CONSTRAINT acc_item_warehouse_pk PRIMARY KEY (id_item_warehouse);


--
-- Name: acc_itemphoto acc_itemphoto_pk; Type: CONSTRAINT; Schema: test_dev; Owner: postgres
--

ALTER TABLE ONLY test_dev.acc_itemphoto
    ADD CONSTRAINT acc_itemphoto_pk PRIMARY KEY (id_itemphoto);


--
-- Name: acc_kardex acc_kardex_pk; Type: CONSTRAINT; Schema: test_dev; Owner: postgres
--

ALTER TABLE ONLY test_dev.acc_kardex
    ADD CONSTRAINT acc_kardex_pk PRIMARY KEY (id_kardex);


--
-- Name: acc_paymentterm acc_paymentterm_pk; Type: CONSTRAINT; Schema: test_dev; Owner: postgres
--

ALTER TABLE ONLY test_dev.acc_paymentterm
    ADD CONSTRAINT acc_paymentterm_pk PRIMARY KEY (id_paymentterm);


--
-- Name: acc_provider acc_provider_pk; Type: CONSTRAINT; Schema: test_dev; Owner: postgres
--

ALTER TABLE ONLY test_dev.acc_provider
    ADD CONSTRAINT acc_provider_pk PRIMARY KEY (id_provider);


--
-- Name: acc_registrationclient acc_registrationclient_pk; Type: CONSTRAINT; Schema: test_dev; Owner: postgres
--

ALTER TABLE ONLY test_dev.acc_registrationclient
    ADD CONSTRAINT acc_registrationclient_pk PRIMARY KEY (id_registrationclient);


--
-- Name: acc_registrationprovider acc_registrationprovider_pk; Type: CONSTRAINT; Schema: test_dev; Owner: postgres
--

ALTER TABLE ONLY test_dev.acc_registrationprovider
    ADD CONSTRAINT acc_registrationprovider_pk PRIMARY KEY (id_registrationprovider);


--
-- Name: acc_transaction acc_transaction_pk; Type: CONSTRAINT; Schema: test_dev; Owner: postgres
--

ALTER TABLE ONLY test_dev.acc_transaction
    ADD CONSTRAINT acc_transaction_pk PRIMARY KEY (id_transaction);


--
-- Name: acc_typeunit acc_typeunit_pk; Type: CONSTRAINT; Schema: test_dev; Owner: postgres
--

ALTER TABLE ONLY test_dev.acc_typeunit
    ADD CONSTRAINT acc_typeunit_pk PRIMARY KEY (id_typeunit);


--
-- Name: acc_warehouse acc_warehouse_pk; Type: CONSTRAINT; Schema: test_dev; Owner: postgres
--

ALTER TABLE ONLY test_dev.acc_warehouse
    ADD CONSTRAINT acc_warehouse_pk PRIMARY KEY (id_warehouse);


--
-- Name: sys_role sys_role_pk; Type: CONSTRAINT; Schema: test_dev; Owner: postgres
--

ALTER TABLE ONLY test_dev.sys_role
    ADD CONSTRAINT sys_role_pk PRIMARY KEY (id_role);


--
-- Name: tax_establishment tax_establishment_pk; Type: CONSTRAINT; Schema: test_dev; Owner: postgres
--

ALTER TABLE ONLY test_dev.tax_establishment
    ADD CONSTRAINT tax_establishment_pk PRIMARY KEY (id_establishment);


--
-- Name: tax_establishmentemission tax_establishmentemission_pk; Type: CONSTRAINT; Schema: test_dev; Owner: postgres
--

ALTER TABLE ONLY test_dev.tax_establishmentemission
    ADD CONSTRAINT tax_establishmentemission_pk PRIMARY KEY (id_establishmentemission);


--
-- Name: tax_pointsaleemission tax_pointsaleemission_pk; Type: CONSTRAINT; Schema: test_dev; Owner: postgres
--

ALTER TABLE ONLY test_dev.tax_pointsaleemission
    ADD CONSTRAINT tax_pointsaleemission_pk PRIMARY KEY (id_pointsaleemission);


--
-- Name: acc_bank_id_bank_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX acc_bank_id_bank_uindex ON public.acc_bank USING btree (id_bank);


--
-- Name: acc_banktypeaccount_id_banktypeaccount_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX acc_banktypeaccount_id_banktypeaccount_uindex ON public.acc_banktypeaccount USING btree (id_banktypeaccount);


--
-- Name: acc_categoryitem_id_categoryitem_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX acc_categoryitem_id_categoryitem_uindex ON public.acc_categoryitem USING btree (id_categoryitem);


--
-- Name: acc_paymentform_id_paymentform_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX acc_paymentform_id_paymentform_uindex ON public.acc_paymentform USING btree (id_paymentform);


--
-- Name: acc_typeaccount_id_typeaccount_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX acc_typeaccount_id_typeaccount_uindex ON public.acc_typeaccount USING btree (id_typeaccount);


--
-- Name: acc_typeincomeegress_id_typeincomeegress_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX acc_typeincomeegress_id_typeincomeegress_uindex ON public.acc_typeincomeegress USING btree (id_typeincomeegress);


--
-- Name: acc_typetransaction_id_typetransaction_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX acc_typetransaction_id_typetransaction_uindex ON public.acc_typetransaction USING btree (id_typetransaction);


--
-- Name: hrr_paymentcategory_id_paymentcategory_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX hrr_paymentcategory_id_paymentcategory_uindex ON public.hrr_paymentcategory USING btree (id_paymentcategory);


--
-- Name: hrr_paymentconcept_id_paymentconcept_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX hrr_paymentconcept_id_paymentconcept_uindex ON public.hrr_paymentconcept USING btree (id_paymentconcept);


--
-- Name: oauth_access_tokens_user_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX oauth_access_tokens_user_id_index ON public.oauth_access_tokens USING btree (user_id);


--
-- Name: oauth_clients_user_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX oauth_clients_user_id_index ON public.oauth_clients USING btree (user_id);


--
-- Name: oauth_personal_access_clients_client_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX oauth_personal_access_clients_client_id_index ON public.oauth_personal_access_clients USING btree (client_id);


--
-- Name: oauth_refresh_tokens_access_token_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX oauth_refresh_tokens_access_token_id_index ON public.oauth_refresh_tokens USING btree (access_token_id);


--
-- Name: password_resets_email_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX password_resets_email_index ON public.password_resets USING btree (email);


--
-- Name: sys_city_id_city_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX sys_city_id_city_uindex ON public.sys_city USING btree (id_city);


--
-- Name: sys_permission_id_permission_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX sys_permission_id_permission_uindex ON public.sys_permission USING btree (id_permission);


--
-- Name: sys_province_id_province_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX sys_province_id_province_uindex ON public.sys_province USING btree (id_province);


--
-- Name: sys_registrationschema_id_registrationschema_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX sys_registrationschema_id_registrationschema_uindex ON public.sys_registrationschema USING btree (id_registrationschema);


--
-- Name: sys_webconnectsri_id_webconnectsri_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX sys_webconnectsri_id_webconnectsri_uindex ON public.sys_webconnectsri USING btree (id_webconnectsri);


--
-- Name: tax_country_id_country_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX tax_country_id_country_uindex ON public.tax_country USING btree (id_country);


--
-- Name: tax_part_id_part_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX tax_part_id_part_uindex ON public.tax_part USING btree (id_part);


--
-- Name: tax_paymentresident_id_paymentresident_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX tax_paymentresident_id_paymentresident_uindex ON public.tax_paymentresident USING btree (id_paymentresident);


--
-- Name: tax_tax_id_tax_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX tax_tax_id_tax_uindex ON public.tax_tax USING btree (id_tax);


--
-- Name: tax_taxretention_id_taxretention_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX tax_taxretention_id_taxretention_uindex ON public.tax_taxretention USING btree (id_taxretention);


--
-- Name: tax_taxsupport_id_taxsupport_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX tax_taxsupport_id_taxsupport_uindex ON public.tax_taxsupport USING btree (id_taxsupport);


--
-- Name: tax_typecompany_id_typecompany_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX tax_typecompany_id_typecompany_uindex ON public.tax_typecompany USING btree (id_typecompany);


--
-- Name: tax_typedocument_id_typedocument_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX tax_typedocument_id_typedocument_uindex ON public.tax_typedocument USING btree (id_typedocument);


--
-- Name: tax_typeemission_id_typeemission_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX tax_typeemission_id_typeemission_uindex ON public.tax_typeemission USING btree (id_typeemission);


--
-- Name: tax_typeemission_id_typeemission_uindex_2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX tax_typeemission_id_typeemission_uindex_2 ON public.tax_typeemission USING btree (id_typeemission);


--
-- Name: tax_typeenvironment_id_typeenvironment_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX tax_typeenvironment_id_typeenvironment_uindex ON public.tax_typeenvironment USING btree (id_typeenvironment);


--
-- Name: tax_typeidentification_id_typeidentification_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX tax_typeidentification_id_typeidentification_uindex ON public.tax_typeidentification USING btree (id_typeidentification);


--
-- Name: tax_typetax_id_typetax_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX tax_typetax_id_typetax_uindex ON public.tax_typetax USING btree (id_typetax);


--
-- Name: tax_typetaxretention_id_typetaxretention_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX tax_typetaxretention_id_typetaxretention_uindex ON public.tax_typetaxretention USING btree (id_typetaxretention);


--
-- Name: tax_typevoucher_id_typevoucher_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX tax_typevoucher_id_typevoucher_uindex ON public.tax_typevoucher USING btree (id_typevoucher);


--
-- Name: acc_ accountingrecord_id_accountingrecord_uindex; Type: INDEX; Schema: test_dev; Owner: postgres
--

CREATE UNIQUE INDEX "acc_ accountingrecord_id_accountingrecord_uindex" ON test_dev."acc_ accountingrecord" USING btree (id_accountingrecord);


--
-- Name: acc_accountplan_id_accountplan_uindex; Type: INDEX; Schema: test_dev; Owner: postgres
--

CREATE UNIQUE INDEX acc_accountplan_id_accountplan_uindex ON test_dev.acc_accountplan USING btree (id_accountplan);


--
-- Name: acc_client_id_client_uindex; Type: INDEX; Schema: test_dev; Owner: postgres
--

CREATE UNIQUE INDEX acc_client_id_client_uindex ON test_dev.acc_client USING btree (id_client);


--
-- Name: acc_conciliation_id_conciliation_uindex; Type: INDEX; Schema: test_dev; Owner: postgres
--

CREATE UNIQUE INDEX acc_conciliation_id_conciliation_uindex ON test_dev.acc_conciliation USING btree (id_conciliation);


--
-- Name: acc_item_id_item_uindex; Type: INDEX; Schema: test_dev; Owner: postgres
--

CREATE UNIQUE INDEX acc_item_id_item_uindex ON test_dev.acc_item USING btree (id_item);


--
-- Name: acc_item_warehouse_id_item_warehouse_uindex; Type: INDEX; Schema: test_dev; Owner: postgres
--

CREATE UNIQUE INDEX acc_item_warehouse_id_item_warehouse_uindex ON test_dev.acc_item_warehouse USING btree (id_item_warehouse);


--
-- Name: acc_itemphoto_id_itemphoto_uindex; Type: INDEX; Schema: test_dev; Owner: postgres
--

CREATE UNIQUE INDEX acc_itemphoto_id_itemphoto_uindex ON test_dev.acc_itemphoto USING btree (id_itemphoto);


--
-- Name: acc_kardex_id_kardex_uindex; Type: INDEX; Schema: test_dev; Owner: postgres
--

CREATE UNIQUE INDEX acc_kardex_id_kardex_uindex ON test_dev.acc_kardex USING btree (id_kardex);


--
-- Name: acc_paymentterm_id_paymentterm_uindex; Type: INDEX; Schema: test_dev; Owner: postgres
--

CREATE UNIQUE INDEX acc_paymentterm_id_paymentterm_uindex ON test_dev.acc_paymentterm USING btree (id_paymentterm);


--
-- Name: acc_provider_id_provider_uindex; Type: INDEX; Schema: test_dev; Owner: postgres
--

CREATE UNIQUE INDEX acc_provider_id_provider_uindex ON test_dev.acc_provider USING btree (id_provider);


--
-- Name: acc_registrationclient_id_registrationclient_uindex; Type: INDEX; Schema: test_dev; Owner: postgres
--

CREATE UNIQUE INDEX acc_registrationclient_id_registrationclient_uindex ON test_dev.acc_registrationclient USING btree (id_registrationclient);


--
-- Name: acc_registrationprovider_id_registrationprovider_uindex; Type: INDEX; Schema: test_dev; Owner: postgres
--

CREATE UNIQUE INDEX acc_registrationprovider_id_registrationprovider_uindex ON test_dev.acc_registrationprovider USING btree (id_registrationprovider);


--
-- Name: acc_transaction_id_transaction_uindex; Type: INDEX; Schema: test_dev; Owner: postgres
--

CREATE UNIQUE INDEX acc_transaction_id_transaction_uindex ON test_dev.acc_transaction USING btree (id_transaction);


--
-- Name: acc_typeunit_id_typeunit_uindex; Type: INDEX; Schema: test_dev; Owner: postgres
--

CREATE UNIQUE INDEX acc_typeunit_id_typeunit_uindex ON test_dev.acc_typeunit USING btree (id_typeunit);


--
-- Name: acc_warehouse_id_warehouse_uindex; Type: INDEX; Schema: test_dev; Owner: postgres
--

CREATE UNIQUE INDEX acc_warehouse_id_warehouse_uindex ON test_dev.acc_warehouse USING btree (id_warehouse);


--
-- Name: sys_role_id_role_uindex; Type: INDEX; Schema: test_dev; Owner: postgres
--

CREATE UNIQUE INDEX sys_role_id_role_uindex ON test_dev.sys_role USING btree (id_role);


--
-- Name: tax_establishment_id_establishment_uindex; Type: INDEX; Schema: test_dev; Owner: postgres
--

CREATE UNIQUE INDEX tax_establishment_id_establishment_uindex ON test_dev.tax_establishment USING btree (id_establishment);


--
-- Name: tax_establishmentemission_id_establishmentemission_uindex; Type: INDEX; Schema: test_dev; Owner: postgres
--

CREATE UNIQUE INDEX tax_establishmentemission_id_establishmentemission_uindex ON test_dev.tax_establishmentemission USING btree (id_establishmentemission);


--
-- Name: tax_pointsaleemission_id_pointsaleemission_uindex; Type: INDEX; Schema: test_dev; Owner: postgres
--

CREATE UNIQUE INDEX tax_pointsaleemission_id_pointsaleemission_uindex ON test_dev.tax_pointsaleemission USING btree (id_pointsaleemission);


--
-- Name: sys_city sys_city_sys_province_id_province_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_city
    ADD CONSTRAINT sys_city_sys_province_id_province_fk FOREIGN KEY (id_province) REFERENCES public.sys_province(id_province) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: sys_province sys_province_tax_country_id_country_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_province
    ADD CONSTRAINT sys_province_tax_country_id_country_fk FOREIGN KEY (id_country) REFERENCES public.tax_country(id_country) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: sys_registrationschema_user sys_registrationschema_user_sys_registrationschema_id_registrat; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_registrationschema_user
    ADD CONSTRAINT sys_registrationschema_user_sys_registrationschema_id_registrat FOREIGN KEY (id_registrationschema) REFERENCES public.sys_registrationschema(id_registrationschema) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: sys_webconnectsri sys_webconnectsri_tax_typeenvironment_id_typeenvironment_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_webconnectsri
    ADD CONSTRAINT sys_webconnectsri_tax_typeenvironment_id_typeenvironment_fk FOREIGN KEY (id_typeenvironment) REFERENCES public.tax_typeenvironment(id_typeenvironment) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: hrr_paymentconcept table_paymentconcept_hrr_paymentcategory_id_paymentcategory_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hrr_paymentconcept
    ADD CONSTRAINT table_paymentconcept_hrr_paymentcategory_id_paymentcategory_fk FOREIGN KEY (id_paymentcategory) REFERENCES public.hrr_paymentcategory(id_paymentcategory) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: tax_tax tax_tax_tax_typetax_id_typetax_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tax_tax
    ADD CONSTRAINT tax_tax_tax_typetax_id_typetax_fk FOREIGN KEY (id_typetax) REFERENCES public.tax_typetax(id_typetax) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: tax_taxretention tax_taxretention_tax_typetaxretention_id_typetaxretention_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tax_taxretention
    ADD CONSTRAINT tax_taxretention_tax_typetaxretention_id_typetaxretention_fk FOREIGN KEY (id_typetaxretention) REFERENCES public.tax_typetaxretention(id_typetaxretention) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: acc_ accountingrecord acc_ accountingrecord_acc_accountplan_id_accountplan_fk; Type: FK CONSTRAINT; Schema: test_dev; Owner: postgres
--

ALTER TABLE ONLY test_dev."acc_ accountingrecord"
    ADD CONSTRAINT "acc_ accountingrecord_acc_accountplan_id_accountplan_fk" FOREIGN KEY (id_accountplan) REFERENCES test_dev.acc_accountplan(id_accountplan) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: acc_ accountingrecord acc_ accountingrecord_acc_conciliation_id_conciliation_fk; Type: FK CONSTRAINT; Schema: test_dev; Owner: postgres
--

ALTER TABLE ONLY test_dev."acc_ accountingrecord"
    ADD CONSTRAINT "acc_ accountingrecord_acc_conciliation_id_conciliation_fk" FOREIGN KEY (id_conciliation) REFERENCES test_dev.acc_conciliation(id_conciliation) ON UPDATE SET NULL ON DELETE SET NULL;


--
-- Name: acc_ accountingrecord acc_ accountingrecord_acc_transaction_id_transaction_fk; Type: FK CONSTRAINT; Schema: test_dev; Owner: postgres
--

ALTER TABLE ONLY test_dev."acc_ accountingrecord"
    ADD CONSTRAINT "acc_ accountingrecord_acc_transaction_id_transaction_fk" FOREIGN KEY (id_transaction) REFERENCES test_dev.acc_transaction(id_transaction) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: acc_accountplan acc_accountplan_acc_typeaccount_id_typeaccount_fk; Type: FK CONSTRAINT; Schema: test_dev; Owner: postgres
--

ALTER TABLE ONLY test_dev.acc_accountplan
    ADD CONSTRAINT acc_accountplan_acc_typeaccount_id_typeaccount_fk FOREIGN KEY (id_typeaccount) REFERENCES public.acc_typeaccount(id_typeaccount) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: acc_client acc_client_acc_accountplan_id_accountplan_fk; Type: FK CONSTRAINT; Schema: test_dev; Owner: postgres
--

ALTER TABLE ONLY test_dev.acc_client
    ADD CONSTRAINT acc_client_acc_accountplan_id_accountplan_fk FOREIGN KEY (id_accountplan) REFERENCES test_dev.acc_accountplan(id_accountplan) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: acc_client acc_client_acc_paymentterm_id_paymentterm_fk; Type: FK CONSTRAINT; Schema: test_dev; Owner: postgres
--

ALTER TABLE ONLY test_dev.acc_client
    ADD CONSTRAINT acc_client_acc_paymentterm_id_paymentterm_fk FOREIGN KEY (id_paymentterm) REFERENCES test_dev.acc_paymentterm(id_paymentterm) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: acc_client acc_client_tax_part_id_part_fk; Type: FK CONSTRAINT; Schema: test_dev; Owner: postgres
--

ALTER TABLE ONLY test_dev.acc_client
    ADD CONSTRAINT acc_client_tax_part_id_part_fk FOREIGN KEY (id_part) REFERENCES public.tax_part(id_part) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: acc_client acc_client_tax_tax_id_tax_fk; Type: FK CONSTRAINT; Schema: test_dev; Owner: postgres
--

ALTER TABLE ONLY test_dev.acc_client
    ADD CONSTRAINT acc_client_tax_tax_id_tax_fk FOREIGN KEY (id_tax) REFERENCES public.tax_tax(id_tax) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: acc_client acc_client_tax_typecompany_id_typecompany_fk; Type: FK CONSTRAINT; Schema: test_dev; Owner: postgres
--

ALTER TABLE ONLY test_dev.acc_client
    ADD CONSTRAINT acc_client_tax_typecompany_id_typecompany_fk FOREIGN KEY (id_typecompany) REFERENCES public.tax_typecompany(id_typecompany) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: acc_client acc_client_tax_typeidentification_id_typeidentification_fk; Type: FK CONSTRAINT; Schema: test_dev; Owner: postgres
--

ALTER TABLE ONLY test_dev.acc_client
    ADD CONSTRAINT acc_client_tax_typeidentification_id_typeidentification_fk FOREIGN KEY (id_typeidentification) REFERENCES public.tax_typeidentification(id_typeidentification) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: acc_conciliation acc_conciliation_acc_accountplan_id_accountplan_fk; Type: FK CONSTRAINT; Schema: test_dev; Owner: postgres
--

ALTER TABLE ONLY test_dev.acc_conciliation
    ADD CONSTRAINT acc_conciliation_acc_accountplan_id_accountplan_fk FOREIGN KEY (id_accountplan) REFERENCES test_dev.acc_accountplan(id_accountplan) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: acc_item acc_item_acc_accountplan_id_accountplan_fk; Type: FK CONSTRAINT; Schema: test_dev; Owner: postgres
--

ALTER TABLE ONLY test_dev.acc_item
    ADD CONSTRAINT acc_item_acc_accountplan_id_accountplan_fk FOREIGN KEY (id_accountplanentry) REFERENCES test_dev.acc_accountplan(id_accountplan) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: acc_item acc_item_acc_accountplan_id_accountplan_fk_2; Type: FK CONSTRAINT; Schema: test_dev; Owner: postgres
--

ALTER TABLE ONLY test_dev.acc_item
    ADD CONSTRAINT acc_item_acc_accountplan_id_accountplan_fk_2 FOREIGN KEY (id_accountplancost) REFERENCES test_dev.acc_accountplan(id_accountplan) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: acc_item acc_item_acc_categoryitem_id_categoryitem_fk; Type: FK CONSTRAINT; Schema: test_dev; Owner: postgres
--

ALTER TABLE ONLY test_dev.acc_item
    ADD CONSTRAINT acc_item_acc_categoryitem_id_categoryitem_fk FOREIGN KEY (id_categoryitem) REFERENCES public.acc_categoryitem(id_categoryitem) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: acc_item acc_item_acc_typeunit_id_typeunit_fk; Type: FK CONSTRAINT; Schema: test_dev; Owner: postgres
--

ALTER TABLE ONLY test_dev.acc_item
    ADD CONSTRAINT acc_item_acc_typeunit_id_typeunit_fk FOREIGN KEY (id_typeunit) REFERENCES test_dev.acc_typeunit(id_typeunit) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: acc_item acc_item_tax_tax_id_tax_fk; Type: FK CONSTRAINT; Schema: test_dev; Owner: postgres
--

ALTER TABLE ONLY test_dev.acc_item
    ADD CONSTRAINT acc_item_tax_tax_id_tax_fk FOREIGN KEY (id_taxiva) REFERENCES public.tax_tax(id_tax) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: acc_item acc_item_tax_tax_id_tax_fk_2; Type: FK CONSTRAINT; Schema: test_dev; Owner: postgres
--

ALTER TABLE ONLY test_dev.acc_item
    ADD CONSTRAINT acc_item_tax_tax_id_tax_fk_2 FOREIGN KEY (id_taxice) REFERENCES public.tax_tax(id_tax) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: acc_item_warehouse acc_item_warehouse_acc_item_id_item_fk; Type: FK CONSTRAINT; Schema: test_dev; Owner: postgres
--

ALTER TABLE ONLY test_dev.acc_item_warehouse
    ADD CONSTRAINT acc_item_warehouse_acc_item_id_item_fk FOREIGN KEY (id_item) REFERENCES test_dev.acc_item(id_item) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: acc_item_warehouse acc_item_warehouse_acc_warehouse_id_warehouse_fk; Type: FK CONSTRAINT; Schema: test_dev; Owner: postgres
--

ALTER TABLE ONLY test_dev.acc_item_warehouse
    ADD CONSTRAINT acc_item_warehouse_acc_warehouse_id_warehouse_fk FOREIGN KEY (id_warehouse) REFERENCES test_dev.acc_warehouse(id_warehouse) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: acc_itemphoto acc_itemphoto_acc_item_id_item_fk; Type: FK CONSTRAINT; Schema: test_dev; Owner: postgres
--

ALTER TABLE ONLY test_dev.acc_itemphoto
    ADD CONSTRAINT acc_itemphoto_acc_item_id_item_fk FOREIGN KEY (id_item) REFERENCES test_dev.acc_item(id_item) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: acc_kardex acc_kardex_acc_item_warehouse_id_item_warehouse_fk; Type: FK CONSTRAINT; Schema: test_dev; Owner: postgres
--

ALTER TABLE ONLY test_dev.acc_kardex
    ADD CONSTRAINT acc_kardex_acc_item_warehouse_id_item_warehouse_fk FOREIGN KEY (id_item_warehouse) REFERENCES test_dev.acc_item_warehouse(id_item_warehouse) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: acc_kardex acc_kardex_acc_transaction_id_transaction_fk; Type: FK CONSTRAINT; Schema: test_dev; Owner: postgres
--

ALTER TABLE ONLY test_dev.acc_kardex
    ADD CONSTRAINT acc_kardex_acc_transaction_id_transaction_fk FOREIGN KEY (id_transaction) REFERENCES test_dev.acc_transaction(id_transaction) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: acc_provider acc_provider_acc_accountplan_id_accountplan_fk; Type: FK CONSTRAINT; Schema: test_dev; Owner: postgres
--

ALTER TABLE ONLY test_dev.acc_provider
    ADD CONSTRAINT acc_provider_acc_accountplan_id_accountplan_fk FOREIGN KEY (id_accountplan) REFERENCES test_dev.acc_accountplan(id_accountplan) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: acc_provider acc_provider_acc_paymentterm_id_paymentterm_fk; Type: FK CONSTRAINT; Schema: test_dev; Owner: postgres
--

ALTER TABLE ONLY test_dev.acc_provider
    ADD CONSTRAINT acc_provider_acc_paymentterm_id_paymentterm_fk FOREIGN KEY (id_paymentterm) REFERENCES test_dev.acc_paymentterm(id_paymentterm) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: acc_provider acc_provider_tax_part_id_part_fk; Type: FK CONSTRAINT; Schema: test_dev; Owner: postgres
--

ALTER TABLE ONLY test_dev.acc_provider
    ADD CONSTRAINT acc_provider_tax_part_id_part_fk FOREIGN KEY (id_part) REFERENCES public.tax_part(id_part) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: acc_provider acc_provider_tax_tax_id_tax_fk; Type: FK CONSTRAINT; Schema: test_dev; Owner: postgres
--

ALTER TABLE ONLY test_dev.acc_provider
    ADD CONSTRAINT acc_provider_tax_tax_id_tax_fk FOREIGN KEY (id_tax) REFERENCES public.tax_tax(id_tax) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: acc_provider acc_provider_tax_typecompany_id_typecompany_fk; Type: FK CONSTRAINT; Schema: test_dev; Owner: postgres
--

ALTER TABLE ONLY test_dev.acc_provider
    ADD CONSTRAINT acc_provider_tax_typecompany_id_typecompany_fk FOREIGN KEY (id_typecompany) REFERENCES public.tax_typecompany(id_typecompany) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: acc_provider acc_provider_tax_typeidentification_id_typeidentification_fk; Type: FK CONSTRAINT; Schema: test_dev; Owner: postgres
--

ALTER TABLE ONLY test_dev.acc_provider
    ADD CONSTRAINT acc_provider_tax_typeidentification_id_typeidentification_fk FOREIGN KEY (id_typeidentification) REFERENCES public.tax_typeidentification(id_typeidentification) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: acc_registrationclient acc_registrationclient_acc_client_id_client_fk; Type: FK CONSTRAINT; Schema: test_dev; Owner: postgres
--

ALTER TABLE ONLY test_dev.acc_registrationclient
    ADD CONSTRAINT acc_registrationclient_acc_client_id_client_fk FOREIGN KEY (id_client) REFERENCES test_dev.acc_client(id_client) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: acc_registrationclient acc_registrationclient_acc_transaction_id_transaction_fk; Type: FK CONSTRAINT; Schema: test_dev; Owner: postgres
--

ALTER TABLE ONLY test_dev.acc_registrationclient
    ADD CONSTRAINT acc_registrationclient_acc_transaction_id_transaction_fk FOREIGN KEY (id_transaction) REFERENCES test_dev.acc_transaction(id_transaction) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: acc_registrationprovider acc_registrationprovider_acc_provider_id_provider_fk; Type: FK CONSTRAINT; Schema: test_dev; Owner: postgres
--

ALTER TABLE ONLY test_dev.acc_registrationprovider
    ADD CONSTRAINT acc_registrationprovider_acc_provider_id_provider_fk FOREIGN KEY (id_provider) REFERENCES test_dev.acc_provider(id_provider) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: acc_registrationprovider acc_registrationprovider_acc_transaction_id_transaction_fk; Type: FK CONSTRAINT; Schema: test_dev; Owner: postgres
--

ALTER TABLE ONLY test_dev.acc_registrationprovider
    ADD CONSTRAINT acc_registrationprovider_acc_transaction_id_transaction_fk FOREIGN KEY (id_transaction) REFERENCES test_dev.acc_transaction(id_transaction) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: acc_transaction acc_transaction_acc_typetransaction_id_typetransaction_fk; Type: FK CONSTRAINT; Schema: test_dev; Owner: postgres
--

ALTER TABLE ONLY test_dev.acc_transaction
    ADD CONSTRAINT acc_transaction_acc_typetransaction_id_typetransaction_fk FOREIGN KEY (id_typetransaction) REFERENCES public.acc_typetransaction(id_typetransaction) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: acc_warehouse acc_warehouse_acc_accountplan_id_accountplan_fk; Type: FK CONSTRAINT; Schema: test_dev; Owner: postgres
--

ALTER TABLE ONLY test_dev.acc_warehouse
    ADD CONSTRAINT acc_warehouse_acc_accountplan_id_accountplan_fk FOREIGN KEY (id_accountplan) REFERENCES test_dev.acc_accountplan(id_accountplan) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: hrr_paymentconcept_accountplan hrr_paymentconcept_accountplan_acc_accountplan__fk2; Type: FK CONSTRAINT; Schema: test_dev; Owner: postgres
--

ALTER TABLE ONLY test_dev.hrr_paymentconcept_accountplan
    ADD CONSTRAINT hrr_paymentconcept_accountplan_acc_accountplan__fk2 FOREIGN KEY (id_accountplan_extra) REFERENCES test_dev.acc_accountplan(id_accountplan) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: hrr_paymentconcept_accountplan hrr_paymentconcept_accountplan_acc_accountplan_id_accountplan_f; Type: FK CONSTRAINT; Schema: test_dev; Owner: postgres
--

ALTER TABLE ONLY test_dev.hrr_paymentconcept_accountplan
    ADD CONSTRAINT hrr_paymentconcept_accountplan_acc_accountplan_id_accountplan_f FOREIGN KEY (id_accountplan) REFERENCES test_dev.acc_accountplan(id_accountplan) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: hrr_paymentconcept_accountplan hrr_paymentconcept_accountplan_hrr_paymentconcept_id_paymentcon; Type: FK CONSTRAINT; Schema: test_dev; Owner: postgres
--

ALTER TABLE ONLY test_dev.hrr_paymentconcept_accountplan
    ADD CONSTRAINT hrr_paymentconcept_accountplan_hrr_paymentconcept_id_paymentcon FOREIGN KEY (id_paymentconcept) REFERENCES public.hrr_paymentconcept(id_paymentconcept) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: sys_permission_role sys_permission_role_sys_permission_id_permission_fk; Type: FK CONSTRAINT; Schema: test_dev; Owner: postgres
--

ALTER TABLE ONLY test_dev.sys_permission_role
    ADD CONSTRAINT sys_permission_role_sys_permission_id_permission_fk FOREIGN KEY (id_permission) REFERENCES public.sys_permission(id_permission) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: sys_permission_role sys_permission_role_sys_role_id_role_fk; Type: FK CONSTRAINT; Schema: test_dev; Owner: postgres
--

ALTER TABLE ONLY test_dev.sys_permission_role
    ADD CONSTRAINT sys_permission_role_sys_role_id_role_fk FOREIGN KEY (id_role) REFERENCES test_dev.sys_role(id_role) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: sys_user_role sys_user_role_sys_role_id_role_fk; Type: FK CONSTRAINT; Schema: test_dev; Owner: postgres
--

ALTER TABLE ONLY test_dev.sys_user_role
    ADD CONSTRAINT sys_user_role_sys_role_id_role_fk FOREIGN KEY (id_role) REFERENCES test_dev.sys_role(id_role) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: tax_establishment tax_establishment_tax_typecompany_id_typecompany_fk; Type: FK CONSTRAINT; Schema: test_dev; Owner: postgres
--

ALTER TABLE ONLY test_dev.tax_establishment
    ADD CONSTRAINT tax_establishment_tax_typecompany_id_typecompany_fk FOREIGN KEY (id_typecompany) REFERENCES public.tax_typecompany(id_typecompany) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: tax_pointsaleemission tax_pointsaleemission_tax_establishmentemission_id_establishmen; Type: FK CONSTRAINT; Schema: test_dev; Owner: postgres
--

ALTER TABLE ONLY test_dev.tax_pointsaleemission
    ADD CONSTRAINT tax_pointsaleemission_tax_establishmentemission_id_establishmen FOREIGN KEY (id_establishmentemission) REFERENCES test_dev.tax_establishmentemission(id_establishmentemission) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: tax_tax_accountplan tax_tax_accountplan_acc_accountplan_id_accountplan_fk; Type: FK CONSTRAINT; Schema: test_dev; Owner: postgres
--

ALTER TABLE ONLY test_dev.tax_tax_accountplan
    ADD CONSTRAINT tax_tax_accountplan_acc_accountplan_id_accountplan_fk FOREIGN KEY (id_accountplan) REFERENCES test_dev.acc_accountplan(id_accountplan) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: tax_tax_accountplan tax_tax_accountplan_tax_tax_id_tax_fk; Type: FK CONSTRAINT; Schema: test_dev; Owner: postgres
--

ALTER TABLE ONLY test_dev.tax_tax_accountplan
    ADD CONSTRAINT tax_tax_accountplan_tax_tax_id_tax_fk FOREIGN KEY (id_tax) REFERENCES public.tax_tax(id_tax) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: tax_taxretention_accountplan tax_taxretention_accountplan_acc_accountplan_id_accountplan_fk; Type: FK CONSTRAINT; Schema: test_dev; Owner: postgres
--

ALTER TABLE ONLY test_dev.tax_taxretention_accountplan
    ADD CONSTRAINT tax_taxretention_accountplan_acc_accountplan_id_accountplan_fk FOREIGN KEY (id_accountplan) REFERENCES test_dev.acc_accountplan(id_accountplan) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: tax_taxretention_accountplan tax_taxretention_accountplan_tax_taxretention_id_taxretention_f; Type: FK CONSTRAINT; Schema: test_dev; Owner: postgres
--

ALTER TABLE ONLY test_dev.tax_taxretention_accountplan
    ADD CONSTRAINT tax_taxretention_accountplan_tax_taxretention_id_taxretention_f FOREIGN KEY (id_taxretention) REFERENCES public.tax_taxretention(id_taxretention) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

