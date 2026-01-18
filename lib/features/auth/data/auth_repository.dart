import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../domain/app_user.dart';

part 'auth_repository.g.dart';

@riverpod
AuthRepository authRepository(Ref ref) {
  return AuthRepository(
    FirebaseAuth.instance,
    GoogleSignIn(scopes: ['email', 'profile']),
  );
}

@riverpod
Stream<AppUser?> authStateChanges(Ref ref) {
  return ref.watch(authRepositoryProvider).authStateChanges();
}

class AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  AuthRepository(this._firebaseAuth, this._googleSignIn);

  Stream<AppUser?> authStateChanges() {
    return _firebaseAuth.authStateChanges().map(_convertUser);
  }

  AppUser? get currentUser => _convertUser(_firebaseAuth.currentUser);

  AppUser? _convertUser(User? user) {
    if (user == null) return null;
    return AppUser(
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
      photoURL: user.photoURL,
    );
  }

  Future<AppUser?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      final UserCredential userCredential = await _firebaseAuth
          .signInWithCredential(credential);
      return _convertUser(userCredential.user);
    } catch (e) {
      print('Google Sign-In Error: $e'); // Added log
      return null;
    }
  }

  Future<AppUser?> signInAnonymously() async {
    try {
      final UserCredential userCredential = await _firebaseAuth
          .signInAnonymously();
      return _convertUser(userCredential.user);
    } catch (e) {
      print('Anonymous Sign-In Error: $e'); // Added log
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      // Force disconnect so Google Account selection is shown next time
      try {
        if (await _googleSignIn.isSignedIn()) {
          await _googleSignIn.disconnect();
        }
      } catch (_) {
        // Ignore errors if check fails or on platforms where disconnect unsupported
      }

      try {
        await _googleSignIn.signOut();
      } catch (_) {
        // Ignore google sign out errors
      }
      await _firebaseAuth.signOut();
    } catch (e) {
      // log error
    }
  }

  Future<void> deleteAccount() async {
    try {
      // Re-authenticate might be required for sensitive operations,
      // but for MVP we try direct delete. If it fails, we should handle auth-requires-recent-login.
      // For now, simple implementation.
      await _firebaseAuth.currentUser?.delete();
    } catch (e) {
      throw e; // Rethrow to handle in UI (e.g. show "Please login again")
    }
  }
}
