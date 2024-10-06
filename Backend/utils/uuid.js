const uuid = require('uuid');

function generateUUID() {
  return uuid.v4(); 
}

console.log(generateUUID()); 
