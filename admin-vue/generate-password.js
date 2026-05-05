const crypto = require('crypto');

function generatePassword(plainText) {
    // 生成 8 字节的 salt
    const salt = crypto.randomBytes(8);
    const saltHex = salt.toString('hex');
    
    // SHA1 加密，迭代 1024 次
    let hash = Buffer.from(plainText, 'utf8');
    for (let i = 0; i < 1024; i++) {
        hash = crypto.createHash('sha1')
            .update(Buffer.concat([salt, hash]))
            .digest();
    }
    
    const passwordHex = hash.toString('hex');
    
    return {
        salt: saltHex,
        password: passwordHex
    };
}

const plainText = '123456';
const result = generatePassword(plainText);

console.log('=== 密码生成结果 ===');
console.log(`明文密码: ${plainText}`);
console.log(`Salt (十六进制): ${result.salt}`);
console.log(`加密密码 (十六进制): ${result.password}`);
console.log('\n=== 插入 SQL ===');
console.log(`
INSERT INTO t_account (
  acct_id,
  account_key,
  account_name,
  password,
  account_status,
  is_active,
  create_date,
  modify_date,
  salt,
  role_ids,
  locked,
  owner_id,
  real_name,
  store_id,
  merchant_id,
  staff_id
) VALUES (
  NULL,
  'fuint',
  'fuint',
  '${result.password}',
  1,
  1,
  NOW(),
  NOW(),
  '${result.salt}',
  '1',
  0,
  NULL,
  '系统管理员',
  0,
  0,
  NULL
);
`);
