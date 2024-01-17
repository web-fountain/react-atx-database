import fs from 'node:fs/promises';
import pgpromise from 'pg-promise';
import { magicLinkTypes } from './data.mjs'


const pgp = pgpromise({ capSQL: true });
const table = new pgp.helpers.TableName({ table: 'magic_link_type', schema: 'auth' });
const columns = new pgp.helpers.ColumnSet(['name'], { table });

async function magicLinkType() {
  const data = [];

  let i=0;
  const len=magicLinkTypes.length
  for (;i<len;i++) {
    data.push({ name: magicLinkTypes[i] });
  }

  const query = pgp.helpers.insert(data, columns);
  await fs.writeFile('./seed.sql', query, { flag: 'w+' });
}


magicLinkType();
