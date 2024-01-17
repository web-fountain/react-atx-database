import { randomUUID } from 'node:crypto';
import fs from 'node:fs/promises';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

import pgpromise from 'pg-promise';
import { faker } from '@faker-js/faker';
import { Liquid } from 'liquidjs';

import { emails } from '../../../_seed/data.mjs';
import { sponsorStatus } from '../sponsor_status/data.mjs';


const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const engine = new Liquid({
  root: path.join(__dirname, '.'),
  extname: '.liquid'
});

const pgp = pgpromise({ capSQL: true });
const table = new pgp.helpers.TableName({ table: 'sponsor', schema: 'community' });
const columns = new pgp.helpers.ColumnSet(['sponsor_id', 'email', 'first_name', 'last_name', 'job_title', 'company_name', 'status'], { table });

async function sponsor() {
  let i=0;
  const len=emails.length;

  const sponsorIds = [];
  for (;i<len;i++) {
    sponsorIds.push(randomUUID());
  }

  const template = await engine.renderFile('template_sponsorIds', { sponsorIds });
  await fs.writeFile('./data.mjs', template, { flag: 'w+' });

  i=0;
  const sponsorList = [];
  for (;i<len;i++) {
    sponsorList.push({
      sponsor_id:        sponsorIds[i],
      email:             emails[i],
      first_name:        faker.person.firstName().replace(/'/g, `''`), // escape single quotes
      last_name:         faker.person.lastName().replace(/'/g, `''`), // escape single quotes
      job_title:         faker.person.jobTitle(),
      company_name:      faker.company.name().replace(/'/g, `''`), // escape single quotes
      status:            faker.helpers.arrayElement(sponsorStatus)
    });
  }

  const query = pgp.helpers.insert(sponsorList, columns);
  await fs.writeFile('./seed.sql', query, { flag: 'w+' });
}


sponsor();
