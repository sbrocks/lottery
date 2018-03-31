const path = require('path')
const fs = require('fs')
const solc = require('solc');

// __dirname would point to the root directory, inbox , here
const lotteryPath = path.resolve(__dirname, 'contracts', 'Lottery.sol');
const source = fs.readFileSync(lotteryPath,'utf8');

// To compile the solidity program file
//console.log(solc.compile(source,1));
module.exports = solc.compile(source,1).contracts[':Lottery'];