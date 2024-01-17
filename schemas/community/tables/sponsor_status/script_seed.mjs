import fs from 'node:fs/promises';
import pgpromise from 'pg-promise';
import { sponsorStatus } from './data.mjs';


const pgp = pgpromise({ capSQL: true });


const table = new pgp.helpers.TableName({ table: 'sponsor_status', schema: 'community' });
const cs = new pgp.helpers.ColumnSet(['name'], { table });


async function sponsorStatus() {
  const data = [];

  let i=0;
  const len=sponsorStatus.length
  for (;i<len;i++) {
    data.push({ name: sponsorStatus[i] });
  }

  const query = pgp.helpers.insert(data, cs);
  await fs.writeFile('./seed.sql', query, { flag: 'w+' });
}


sponsorStatus();
