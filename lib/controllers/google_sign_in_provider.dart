import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class GoogleSignInProvider extends ChangeNotifier {
  bool isSigning = false;
  final supabase = Supabase.instance.client;

  Future<bool> nativeGoogleSignIn() async {
    isSigning = true;

    try {
      const webClientId =
          '999157749627-llfhhitkhcva6ali536oebd6ffaq85lj.apps.googleusercontent.com';

      const iosClientId =
          '999157749627-hfqh019v45gp88u0g9boa6svsc4hfgsl.apps.googleusercontent.com';

      final scopes = ['email', 'profile'];

      final googleSignIn = GoogleSignIn.instance;
      await googleSignIn.initialize(
        serverClientId: webClientId,
        clientId: iosClientId,
      );

      final googleUser = await googleSignIn.attemptLightweightAuthentication();

      if (googleUser == null) {
        throw AuthException('Failed to sign in with Google.');
      }

      final authorization =
          await googleUser.authorizationClient.authorizationForScopes(scopes) ??
          await googleUser.authorizationClient.authorizeScopes(scopes);

      final idToken = googleUser.authentication.idToken;

      if (idToken == null) {
        throw AuthException('No ID Token found.');
      }

      await supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: authorization.accessToken,
      );
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    } finally {
      isSigning = false;
    }
  }
}
