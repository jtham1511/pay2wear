import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class Pay2wearFirebaseUser {
  Pay2wearFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

Pay2wearFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<Pay2wearFirebaseUser> pay2wearFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<Pay2wearFirebaseUser>(
            (user) => currentUser = Pay2wearFirebaseUser(user));
