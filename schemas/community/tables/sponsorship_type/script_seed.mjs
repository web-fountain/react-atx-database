import fs from 'node:fs/promises';
import pgpromise from 'pg-promise';
import { sponsorshipTypes } from './data.mjs'


const pgp = pgpromise({ capSQL: true });
const table = new pgp.helpers.TableName({ table: 'sponsorship_type', schema: 'community' });
const columns = new pgp.helpers.ColumnSet(['name'], { table });

async function sponsorshipType() {
  const data = [];

  let i=0;
  const len=sponsorshipTypes.length
  for (;i<len;i++) {
    data.push({ name: sponsorshipTypes[i] });
  }

  const query = pgp.helpers.insert(data, columns);
  await fs.writeFile('./seed.sql', query, { flag: 'w+' });
}


sponsorshipType();
