import fs from 'node:fs/promises';
import pgpromise from 'pg-promise';
import { faker } from '@faker-js/faker';

import { emails } from '../../../_seed/data.mjs';


const pgp = pgpromise({ capSQL: true });
const table = new pgp.helpers.TableName({ table: 'member', schema: 'community' });
const columns = new pgp.helpers.ColumnSet(['email', 'is_verified'], { table });

async function member() {
  const data = [];

  let i=0;
  const len=emails.length
  for (;i<len;i++) {
    data.push({
      email:              emails[i],
      is_verified:        faker.datatype.boolean({ probability: 0.5 })
    });
  }

  const query = pgp.helpers.insert(data, columns);
  await fs.writeFile('./seed.sql', query, { flag: 'w+' });
}


member();
