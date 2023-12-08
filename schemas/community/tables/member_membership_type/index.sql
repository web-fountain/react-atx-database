SET search_path TO community;


/*
 * CREATE JUNCTION TABLE member_membership_type
 */
CREATE TABLE IF NOT EXISTS community.member_membership_type (
  member_id             UUID NOT NULL,
  membership_type       TEXT NOT NULL,

  created_at            TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,


  CONSTRAINT sponsor_sponsorship_type_sponsor_id_sponsorship_type_pkey
    PRIMARY KEY (sponsor_id, sponsorship_type),

  CONSTRAINT sponsor_sponsorship_type_sponsor_id_fkey
    FOREIGN KEY (sponsor_id)
    REFERENCES community.sponsor (sponsor_id),
  CONSTRAINT sponsor_sponsorship_type_sponsorship_type_fkey
    FOREIGN KEY (sponsorship_type)
    REFERENCES community.sponsorship_type (name)
);
CREATE INDEX IF NOT EXISTS sponsor_sponsorship_type_sponsor_id_idx
  ON community.sponsor_sponsorship_type
  USING btree (sponsor_id);
CREATE INDEX IF NOT EXISTS sponsor_sponsorship_type_sponsorship_type_idx
  ON community.sponsor_sponsorship_type
  USING btree (sponsorship_type);
