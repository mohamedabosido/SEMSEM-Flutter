import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tokoto/Models/user.dart';
import 'package:tokoto/api/controller/user_api_controller.dart';
import 'package:tokoto/helpers/helpers.dart';
import 'package:tokoto/prefs/user_preferences_controller.dart';

typedef UserAuthStatus = void Function({required bool loggedIn});

class FbAuthController with Helpers {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var facebookAuth = FacebookAuth.instance;

  Future<bool> login({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      if (userCredential.user != null) {
        if (userCredential.user!.emailVerified) {
          firestore
              .collection('users')
              .doc(userCredential.user!.uid)
              .get()
              .then((value) {
            UserModel user = UserModel(
              id: userCredential.user!.uid,
              fName: value.get('fName'),
              lName: value.get('lName'),
              email: email,
              phone: value.get('phone'),
              address: value.get('address'),
            );
            UserPreferencesController().saveUser(user: user);
          });
          return true;
        } else {
          await logout();
          showSnackBar(
            context: context,
            message: 'Verify email to login into the app',
            error: true,
          );
          return false;
        }
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(
          context: context, message: e.message.toString(), error: true);
    }
    return false;
  }

  Future<bool> loginWithGoogle(context) async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await firebaseAuth.signInWithCredential(credential);
      final snapshot = await firestore
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .get();
      if (!snapshot.exists) {
        firestore.collection('users').doc(firebaseAuth.currentUser!.uid).set({
          'fName': googleUser.displayName!.split(' ')[0],
          'lName': googleUser.displayName!.split(' ')[1],
          'address': '',
          'phone': '',
        });
        await UserApiController().register(
          id: firebaseAuth.currentUser!.uid,
          email: googleUser.email,
          fName: googleUser.displayName!,
          lName: googleUser.displayName!,
          phone: 'Phone',
          address: 'Address',
          password: '12345678',
          confirmPassword: '12345678',
        );
        UserModel user = UserModel(
          id: firebaseAuth.currentUser!.uid,
          email: googleUser.email,
          fName: googleUser.displayName!.split(' ')[0],
          lName: googleUser.displayName!.split(' ')[1],
          phone: '',
          address: '',
        );
        UserPreferencesController().saveUser(user: user);
        Navigator.pushReplacementNamed(context, '/main_screen');
        return true;
      } else {
        var userCredential = firebaseAuth.currentUser;
        firestore
            .collection('users')
            .doc(userCredential!.uid)
            .get()
            .then((value) {
          UserModel user = UserModel(
            id: userCredential.uid,
            fName: value.get('fName'),
            lName: value.get('lName'),
            email: userCredential.email!,
            phone: value.get('phone'),
            address: value.get('address'),
          );
          UserPreferencesController().saveUser(user: user);
          Navigator.pushReplacementNamed(context, '/main_screen');
        });
        return true;
      }
    }
    return false;
  }

  Future<bool> loginWithFacebook(context) async {
    final LoginResult loginResult = await facebookAuth.login();
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    await firebaseAuth.signInWithCredential(facebookAuthCredential);
    final userData = await FacebookAuth.instance.getUserData();

    final snapshot = await firestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .get();
    if (!snapshot.exists) {
      firestore.collection('users').doc(firebaseAuth.currentUser!.uid).set({
        'fName': userData['name'].toString().split(' ')[0],
        'lName': userData['name'].toString().split(' ')[1],
        'address': '',
        'phone': '',
      });
      await UserApiController().register(
        id: firebaseAuth.currentUser!.uid,
        email: userData['email'],
        fName: userData['name'].toString().split(' ')[0],
        lName: userData['name'].toString().split(' ')[1],
        phone: 'Phone',
        address: 'Address',
        password: '12345678',
        confirmPassword: '12345678',
      );
      UserModel user = UserModel(
        id: firebaseAuth.currentUser!.uid,
        email: userData['email'],
        fName: userData['name'].toString().split(' ')[0],
        lName: userData['name'].toString().split(' ')[1],
        phone: '',
        address: '',
      );
      UserPreferencesController().saveUser(user: user);
      Navigator.pushReplacementNamed(context, '/main_screen');
      return true;
    } else {
      var userCredential = firebaseAuth.currentUser;
      firestore
          .collection('users')
          .doc(userCredential!.uid)
          .get()
          .then((value) {
        UserModel user = UserModel(
          id: userCredential.uid,
          fName: value.get('fName'),
          lName: value.get('lName'),
          email: userCredential.email!,
          phone: value.get('phone'),
          address: value.get('address'),
        );
        UserPreferencesController().saveUser(user: user);
        Navigator.pushReplacementNamed(context, '/main_screen');
      });
      return true;
    }
  }


  Future<bool> register({
    required BuildContext context,
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String phone,
    required String address,
  }) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        userCredential.user?.sendEmailVerification();
        firestore.collection('users').doc(userCredential.user!.uid).set({
          'fName': firstName,
          'lName': lastName,
          'address': address,
          'phone': phone,
        });
        await UserApiController().register(
          id: userCredential.user!.uid,
          fName: firstName,
          lName: lastName,
          email: email,
          password: password,
          confirmPassword: password,
          address: address,
          phone: phone,
        );
      }
      return true;
    } on FirebaseAuthException catch (e) {
      showSnackBar(
          context: context, message: e.message.toString(), error: true);
    } catch (e) {
      showSnackBar(
          context: context, message: 'Something Wrong, Please try later');
    }
    return false;
  }

  Future<void> logout() async {
    firebaseAuth.signOut();
    UserPreferencesController().logout();
  }

  bool loggedIn() => firebaseAuth.currentUser != null;

  StreamSubscription<User?> checkUserStatus(UserAuthStatus userAuthStatus) {
    return firebaseAuth.authStateChanges().listen((event) {
      userAuthStatus(loggedIn: event != null);
    });
  }

  Future<bool> resetPassword(String email, context) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      showSnackBar(
          context: context, message: 'Check your email to reset password');
      return true;
    } on FirebaseAuthException catch (e) {
      showSnackBar(
          context: context, message: e.message.toString(), error: true);
      return false;
    }
  }

  void updateUserInfo(UserModel userModel, context) {
    var userCredential = firebaseAuth.currentUser;
    firestore.collection('users').doc(userCredential!.uid).set({
      'fName': userModel.fName,
      'lName': userModel.lName,
      'address': userModel.address,
      'phone': userModel.phone,
    });
    UserPreferencesController().saveUser(user: userModel);
    showSnackBar(context: context, message: 'Saved Changes');
  }
}
