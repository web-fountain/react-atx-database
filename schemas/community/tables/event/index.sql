SET search_path TO community;


/*
 * CREATE TABLE event
 */
 CREATE TABLE IF NOT EXISTS community.event (
  event_id                UUID,

  event_start_date        DATE
  event_start_time

  event_end_date          DATE
  event_end_time

  location_id             UUID
 );


CREATE TABLE IF NOT EXISTS community.event_speaker (
  event_id
  speaker_id

);


CREATE TABLE IF NOT EXISTS community.event_sponsor (
  event_id
  sponsor_id
);
