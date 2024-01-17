import fs from 'node:fs/promises';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

import { faker } from '@faker-js/faker';
import { Liquid } from 'liquidjs';


const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const engine = new Liquid({
  root: path.join(__dirname, '.'),
  extname: '.liquid'
});
engine.registerFilter('escapeJS', v => v.replace(/[\\$'"]/g, "\\$&"))


async function seedEmails() {
  const emails = [];

  let i=0;
  const len=100;
  for (;i<len;i++) {
    emails.push(faker.internet.email({ allowSpecialCharacters: true }));
  }

  const template = await engine.renderFile('email_template', { emails });
  await fs.writeFile('./data.mjs', template, { flag: 'w+' });
}


seedEmails();
