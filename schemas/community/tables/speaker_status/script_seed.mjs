import fs from 'node:fs/promises';
import pgpromise from 'pg-promise';
import { speakerStatus } from './data.mjs'


const pgp = pgpromise({ capSQL: true });
const table = new pgp.helpers.TableName({ table: 'speaker_status', schema: 'community' });
const columns = new pgp.helpers.ColumnSet(['name'], { table });

async function speakerStatus() {
  const data = [];

  let i=0;
  const len=speakerStatus.length
  for (;i<len;i++) {
    data.push({ name: speakerStatus[i] });
  }

  const query = pgp.helpers.insert(data, columns);
  await fs.writeFile('./seed.sql', query, { flag: 'w+' });
}


speakerStatus();
