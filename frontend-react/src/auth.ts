export type Role = 'admin' | 'inventory' | 'data_entry' | 'client' | 'supplier';
export type User = { email: string; role: Role; displayName: string; passwordHash: string; salt: string };
const seed: User[] = [
  { email: 'admin@company.local', displayName: 'Admin', role: 'admin', salt: '8881021a66e5787e60df94aa1930107c', passwordHash: 'bbb0205fb07d3164aadd56ffe1f1232735d128f7a7cc69234c5a8f0a5c68b6d9' },
  { email: 'inventory@company.local', displayName: 'Inventory Manager', role: 'inventory', salt: 'd4fece2b0534989256e05bcf349d5676', passwordHash: '0d68265ce07c19bc721c22406e0d19650130116d8648f972ad8872b8ff1b2b7a' },
  { email: 'dataentry@company.local', displayName: 'Data Entry Operator', role: 'data_entry', salt: 'fd3a7aae00cb2f5a368e9bdc4a79405f', passwordHash: '287555edccab3d81f6c52840b90d4cdc3de8f1cd40eab7c839ffa2ad8715cfb4' },
  { email: 'client@company.local', displayName: 'Client Portal User', role: 'client', salt: '16b8c81ff280ac47ec30774c0f4078e6', passwordHash: '1c21722cada1bd46d9399912d7a052e3500749cdf6cc7d4ec64d7d3fc81ddf3f' },
  { email: 'supplier@company.local', displayName: 'Supplier Portal User', role: 'supplier', salt: 'f65f7f7f60bb5572029724c013613b44', passwordHash: '6fafc3247dcf4be7216d4c2b21e0098316da5b64bf69c8d2220e1864192ee4a1' },
];
const encoder = new TextEncoder(); const toHex = (bytes: Uint8Array) => Array.from(bytes).map(byte => byte.toString(16).padStart(2, '0')).join(''); const fromHex = (hex: string) => new Uint8Array(hex.match(/.{1,2}/g)!.map(byte => parseInt(byte, 16)));
async function derive(password: string, salt: Uint8Array) { const key = await crypto.subtle.importKey('raw', encoder.encode(password), 'PBKDF2', false, ['deriveBits']); const bits = await crypto.subtle.deriveBits({ name: 'PBKDF2', salt, iterations: 120000, hash: 'SHA-256' }, key, 256); return toHex(new Uint8Array(bits)); }
export async function authenticate(email: string, password: string) { const account = seed.find(record => record.email.toLowerCase() === email.trim().toLowerCase()); if (!account) throw new Error('Invalid email or password'); const hash = await derive(password, fromHex(account.salt)); if (hash !== account.passwordHash) throw new Error('Invalid email or password'); const { passwordHash: _hash, salt: _salt, ...sessionUser } = account; return sessionUser; }
