INSERT INTO community.login_security_type
  (login_type, provider)
VALUES
  ('magiclink', null),
  ('oidc', 'twitter'),
  ('oidc', 'github'),
  ('oidc', 'gitlab'),
  ('oidc', 'linkedin'),
  ('password', null)
;



INSERT INTO community.junction_account_login_security_type
  (account_id, login_security_type)
VALUES
  ('asdfasdfasdf', 'password')



INSERT INTO community.login_security
  (account_id, login_security_type)


login_security_password
login_security_oidc
login_security_magicLink
