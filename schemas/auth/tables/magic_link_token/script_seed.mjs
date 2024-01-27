import util from 'node:util';
import fs from 'node:fs/promises';
import { randomBytes } from 'node:crypto';
import pgpromise from 'pg-promise';
import { faker } from '@faker-js/faker';

import { emails } from '../../../_seed/data.mjs';
import { magicLinkTypes } from '../magic_link_type/data.mjs';


const randomBytesAsync = util.promisify(randomBytes);
const minutes_to_expire = 15;

const pgp = pgpromise({ capSQL: true });
const table = new pgp.helpers.TableName({ table: 'magic_link_token', schema: 'auth' });
const columns = new pgp.helpers.ColumnSet(['expires_at', 'is_used', 'magic_link_type', 'email'], { table });

async function magicLink() {
  let i=0;
  const len=emails.length;

  const magicLinks = [];
  for(;i<len;i++) {
    const createdAt = faker.date.recent({ days: 10 });
    const expiresAt = new Date(createdAt);
    expiresAt.setMinutes(createdAt.getMinutes() + minutes_to_expire);

    magicLinks.push({
      // Leaving for Future Reference
      // token_id:         (await randomBytesAsync(64)).toString('hex'),
      expires_at:       expiresAt.toISOString(),
      is_used:          faker.datatype.boolean({ probability: 0.5 }),
      magic_link_type:  faker.helpers.arrayElement(magicLinkTypes),
      email:            emails[i],
      created_at:       createdAt.toISOString()
    });
  }

  const query = pgp.helpers.insert(magicLinks, columns);
  await fs.writeFile('./seed.sql', query, { flag: 'w+' });
}


magicLink();
