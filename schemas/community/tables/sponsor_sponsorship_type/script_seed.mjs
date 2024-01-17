import fs from 'node:fs/promises';
import { sponsorIds } from '../sponsor/data.mjs';
import { sponsorshipTypes } from '../sponsorship_type/data.mjs';


import pgpromise from 'pg-promise';

const pgp = pgpromise({ capSQL: true });
const table = new pgp.helpers.TableName({ table: 'sponsor_sponsorship_type', schema: 'community' });
const columns = new pgp.helpers.ColumnSet(['sponsor_id', 'sponsorship_type'], { table });

async function sponsorSponsorshipType() {
  console.log('running');
  let i=0;
  const len=sponsorIds.length;

  const data = [];
  for (;i<len;i++) {
    data.push({
      sponsor_id: sponsorIds[i],
      sponsorship_type: sponsorshipTypes[Math.floor(Math.random() * sponsorshipTypes.length)]
    });
  }

  const query = pgp.helpers.insert(data, columns);
  await fs.writeFile('./seed.sql', query, { flag: 'w+' });
}


sponsorSponsorshipType();
