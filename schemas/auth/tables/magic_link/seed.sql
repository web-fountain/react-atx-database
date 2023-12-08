INSERT INTO auth.magic_link
  (email, magic_link_type, is_used)
VALUES
  ('simple@example.com', 'join', TRUE),
  ('very.common@example.com', 'join', TRUE),
  ('disposable.style.email.with+symbol@example.com', 'join', TRUE),
  ('other.email-with-hyphen@example.com', 'join', TRUE),
  ('fully-qualified-domain@example.com', 'join', TRUE),
  ('user.name+tag+sorting@example.com', 'join', TRUE),
  ('x@example.com', 'join', TRUE),
  ('example-indeed@strange-example.com', 'join', TRUE),
  ('test/test@test.com', 'join', TRUE),
  ('admin@mailserver1', 'join', TRUE),
  ('example@s.example', 'join', TRUE),
  ('mailhost!username@example.org', 'join', TRUE),
  ('user%example.com@example.org', 'join', TRUE),
  ('user-@example.org', 'join', TRUE),
  ('Abc@example.com', 'join', TRUE),
  ('Abc.123@example.com', 'join', TRUE),
  ('user+mailbox/department=shipping@example.com', 'join', TRUE)
;


  -- INVALID EMAILS
  -- ('" "@example.org')
  -- ('"john..doe"@example.org')
  -- ('"very.(),:;<>[]\".VERY.\"very@\\ \"very\".unusual"@strange.example.com')
  -- ('postmaster@[123.123.123.123]')
  -- ('postmaster@[IPv6:2001:0db8:85a3:0000:0000:8a2e:0370:7334]')
  -- ('"Abc@def"@example.com')
  -- ('"Fred\ Bloggs"@example.com')
  -- ('"Joe.\\Blow"@example.com')
  -- ('用户@例子.广告')
  -- ('ಬೆಂಬಲ@ಡೇಟಾಮೇಲ್.ಭಾರತ')
  -- ('अजय@डाटा.भारत')
  -- ('квіточка@пошта.укр')
  -- ('χρήστης@παράδειγμα.ελ')
  -- ('Dörte@Sörensen.example.com')
  -- ('коля@пример.рф')
