CREATE SEQUENCE IF NOT EXISTS hole_id_seq
INCREMENT 1
START 1;

CREATE TABLE IF NOT EXISTS public."hole"
(
    id INTEGER NOT NULL DEFAULT nextval('hole_id_seq'::regclass),
    game_Id INTEGER NOT NULL DEFAULT 0,
    player_Id INTEGER NOT NULL DEFAULT 0,
    yeets INTEGER NOT NULL DEFAULT 0,
    CONSTRAINT hole_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."hole"
    OWNER to folf_tracker_user;