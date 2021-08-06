import 'package:cloud_firestore/cloud_firestore.dart';
import 'User_model.dart';
class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  // collection reference
  final CollectionReference dataCollection = Firestore.instance.collection('data');

  Future<void> updateUserData(String roll_no, String name) async {
    return await dataCollection.document(uid).setData({
      'rollno': roll_no,
      'name': name,
    });
  }
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        name: snapshot.data['name'],
        rollno: snapshot.data['rollno'],
    );
  }
  Stream<QuerySnapshot> get data {
    return dataCollection.snapshots();
  }
  Stream<UserData> get userData {
    return dataCollection.document(uid).snapshots()
        .map(_userDataFromSnapshot);
  }

}