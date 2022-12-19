const { initializeApp, applicationDefault, cert } = require('firebase-admin/app');
const { getFirestore, Timestamp, FieldValue } = require('firebase-admin/firestore');
const serviceAccount = require('./firebase.json');

initializeApp({
  credential: cert(serviceAccount)
});

const db = getFirestore();

const docRef = db.collection('user').doc('alovelace');

docRef.set({
  first: 'Ada',
  last: 'Lovelace',
  born: 1815
});
const aTuringRef = db.collection('users').doc('aturing');

 aTuringRef.set({
  'first': 'Alan',
  'middle': 'Mathison',
  'last': 'Turing',
  'born': 1912
});
async function test(){
  const snapshot = await db.collection('users').get();
  
  }
test()
