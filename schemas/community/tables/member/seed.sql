INSERT INTO community.member
  (email)
VALUES
  ('simple@example.com'),
  ('very.common@example.com'),
  ('disposable.style.email.with+symbol@example.com'),
  ('other.email-with-hyphen@example.com'),
  ('fully-qualified-domain@example.com'),
  ('user.name+tag+sorting@example.com'),
  ('x@example.com'),
  ('example-indeed@strange-example.com'),
  ('test/test@test.com'),
  ('admin@mailserver1'),
  ('example@s.example'),
  ('mailhost!username@example.org'),
  ('user%example.com@example.org'),
  ('user-@example.org'),
  ('Abc@example.com'),
  ('Abc.123@example.com'),
  ('user+mailbox/department=shipping@example.com')
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
