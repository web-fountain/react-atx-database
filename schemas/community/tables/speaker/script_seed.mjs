import { randomUUID } from 'node:crypto';
import fs from 'node:fs/promises';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

import pgpromise from 'pg-promise';
import { faker } from '@faker-js/faker';
import { Liquid } from 'liquidjs';

import { emails } from '../../../_seed/data.mjs';
import { speakerStatus } from '../speaker_status/data.mjs';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const engine = new Liquid({
  root: path.join(__dirname, '.'),
  extname: '.liquid'
});

const pgp = pgpromise({ capSQL: true });
const table = new pgp.helpers.TableName({ table: 'speaker', schema: 'community' });
const columns = new pgp.helpers.ColumnSet(['speaker_id', 'email', 'first_name', 'last_name', 'job_title', 'company_name', 'status', 'presentation_title', 'presentation_summary'], { table });


async function speaker() {
  let i=0;
  const len=emails.length;

  const speakerIds = [];
  for (;i<len;i++) {
    speakerIds.push(randomUUID());
  }

  const template = await engine.renderFile('template_speakerIds', { speakerIds });
  await fs.writeFile('./data.mjs', template, { flag: 'w+' });

  i=0;
  const speakerList = [];
  for (;i<len;i++) {
    speakerList.push({
      speaker_id:             speakerIds[i],
      email:                  emails[i],
      first_name:             faker.person.firstName().replace(/'/g, `''`), // escape single quotes
      last_name:              faker.person.lastName().replace(/'/g, `''`), // escape single quotes
      job_title:              faker.person.jobTitle(),
      company_name:           faker.company.name().replace(/'/g, `''`), // escape single quotes
      status:                 faker.helpers.arrayElement(speakerStatus),
      presentation_title:     faker.lorem.words({ min: 3, max: 10 }),
      presentation_summary:   faker.lorem.paragraphs({ min: 1, max: 5, separator: '/n' })
    });
  }

  const query = pgp.helpers.insert(speakerList, columns);
  await fs.writeFile('./seed.sql', query, { flag: 'w+' });
}


speaker();
