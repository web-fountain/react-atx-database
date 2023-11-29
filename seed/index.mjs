import { randomUUID } from 'node:crypto';
import fs from 'node:fs/promises';
import { faker } from '@faker-js/faker';


let i=0;
const len=100;

const accountIds = [];
for (;i<len;i++) {
  accountIds.push(randomUUID());
}

i=0;
const emails = [];
for (;i<len;i++) {
  emails.push(faker.internet.email({ allowSpecialCharacters: true }));
}

i=0;
const sponsorIds = [];
for (;i<len;i++) {
  sponsorIds.push(randomUUID());
}

async function createSeedDataForAccountTable(count=100) {
  const insertValues = [];
  const beginWith = `('`;
  const endWith = `')`;

  let i=0;
  const len=count;
  for (;i<len;i++) {
    insertValues.push(`('${accountIds[i]}', '${faker.internet.email()}', '${faker.helpers.arrayElement(['active', 'confirmed', 'disabled', 'pending'])}', '${faker.helpers.arrayElement(['magiclink', 'oidc', 'password'])}`);
  }

  const newlineInsertValues = insertValues.join('\'), \n');
  const sqlValues = `${newlineInsertValues}${endWith}`;

  const content = `
  INSERT INTO community.account
    (account_id, email, status, login_security_type)
  VALUES
    ${sqlValues}
  ;`;

  await fs.writeFile('./account.sql', content, { flag: 'w+' });
}


async function createSeedDataForSponsorTable(count=100) {
  const genSponsorList = [];

  let i=0;
  const len=count;
  for (;i<len;i++) {
    genSponsorList.push({
      sponsor_id:        sponsorIds[i],
      account_id:        accountIds[i],
      display_name:      faker.person.fullName().replace(/'/g, `''`), // escape single quotes
      job_title:         faker.person.jobTitle(),
      company_name:      faker.company.name().replace(/'/g, `''`), // escape single quotes
      status:            faker.helpers.arrayElement(['cancelled', 'confirmed', 'pending'])
    });
  }

  const sponsorList = [];
  const sponsorshipTypeList = [];
  for (const genSponsor of genSponsorList) {
    const { sponsor_id, account_id, display_name, job_title, company_name, status } = genSponsor;
    sponsorList.push(`('${sponsor_id}', '${account_id}', '${display_name}', '${job_title}', '${company_name}', '${status}'),`)
    sponsorshipTypeList.push(`('${sponsor_id}', '${faker.helpers.arrayElement(['venue', 'food', 'drinks', 'speakers', 'workshop', 'happyhour', 'other'])}'),`);
  }

  const sqlSponsorValues = sponsorList
    .join('\n')
    .slice(0, -1);

  const sqlSponsorshipTypeList = sponsorshipTypeList
    .join('\n')
    .slice(0, -1);

  const sponsorListContent = `
    INSERT INTO community.sponsor
      (sponsor_id, account_id, display_name, job_title, company_name, status)
    VALUES
      ${sqlSponsorValues}
    ;`;
  await fs.writeFile('./sponsor.sql', sponsorListContent, { flag: 'w+' });

  const sponsorshipTypeListContent = `
    INSERT INTO community.sponsor_sponsorship_type
     (sponsor_id, sponsorship_type)
    VALUES
      ${sqlSponsorshipTypeList}
    ;`;
  await fs.writeFile('./sponsor_sponsorship_type.sql', sponsorshipTypeListContent, { flag: 'w+' });
}


async function createSeedDataForSpeakerTable(count=100) {
  const genSpeakerList = [];

  let i=0;
  const len=count;
  for (;i<len;i++) {
    genSpeakerList.push({
      email:                  emails[i],
      display_name:           faker.person.fullName().replace(/'/g, `''`), // escape single quotes
      job_title:              faker.person.jobTitle(),
      company_name:           faker.company.name().replace(/'/g, `''`), // escape single quotes
      status:                 faker.helpers.arrayElement(['cancelled', 'confirmed', 'pending']),
      presentation_title:     faker.lorem.words({ min: 3, max: 10 }),
      presentation_summary:   faker.lorem.paragraphs({ min: 1, max: 5, separator: '/n' })
    });
  }

  const speakerList = [];
  for (const genSpeaker of genSpeakerList) {
    const { account_id, display_name, job_title, company_name, status, presentation_title, presentation_summary } = genSpeaker;
    speakerList.push(`('${account_id}', '${display_name}', '${job_title}', '${company_name}', '${status}', '${presentation_title}', '${presentation_summary}'),`)
  }

  const sqlSpeakerValues = speakerList
    .join('\n')
    .slice(0, -1);

  const content = `
    INSERT INTO community.speaker
      (email, display_name, job_title, company_name, status, presentation_title, presentation_summary)
    VALUES
      ${sqlSpeakerValues}
    ;`;

  await fs.writeFile('./speaker.sql', content, { flag: 'w+' });
}


function createSeedDataForNewsComment(count=100) {}



createSeedDataForAccountTable();
createSeedDataForSponsorTable();
createSeedDataForSpeakerTable();
