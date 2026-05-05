const semver = require('semver');
const packageJson = require('./package.json');

const requiredVersion = packageJson.engines.node;

function checkNodeVersion() {
  const currentVersion = process.version;
  
  if (!semver.satisfies(currentVersion, requiredVersion)) {
    console.warn(
      `\n⚠️ 当前 Node.js 版本 ${currentVersion} 不在建议范围 ${requiredVersion} 内。`
    );
    console.warn('建议使用 Node.js 18.x 或 20.x 以获得最佳兼容性，但我们也将尝试继续运行。\n');
    // 不退出，继续执行
  } else {
    console.log(`✓ 当前 Node.js 版本 ${currentVersion} 满足要求`);
  }
}

checkNodeVersion();