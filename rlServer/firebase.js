const { initializeApp, cert } = require('firebase-admin/app');
const { getFirestore } = require('firebase-admin/firestore');
const serviceAccount = require('./key.json');

initializeApp({
  credential: cert(serviceAccount)
});

const db = getFirestore();

// const docRef = db.collection('user').doc('alovelace');

// docRef.set({
//   first: 'Ada',
//   last: 'Lovelace',
//   born: 1815
// });
// const aTuringRef = db.collection('users').doc('aturing');

//  aTuringRef.set({
//   'first': 'Alan',
//   'middle': 'Mathison',
//   'last': 'Turing',
//   'born': 1912
// });
async function test(){
  const snapshot = await db.collection('rooms').get();

  snapshot.forEach(doc => {
    console.log(doc.id, '=>', doc.data()['6']['1'].status);
  });
}
test();




