import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app.dart';
import 'firebase_options.dart';

import 'features/auth/data/auth_repository.dart';
import 'features/group/data/group_repository.dart';
import 'features/list/data/list_repository.dart';
import 'core/data/mock_repositories.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  // Set this to false to use real Firebase
  const useMock = false;

  if (useMock) {
    await MockDatabase.instance.init();
  } else {
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    } catch (e) {
      debugPrint('Firebase init failed: $e');
    }
  }

  runApp(
    ProviderScope(
      overrides: useMock
          ? [
              authRepositoryProvider.overrideWith(
                (ref) => FakeAuthRepository(),
              ),
              groupRepositoryProvider.overrideWith(
                (ref) => FakeGroupRepository(),
              ),
              listRepositoryProvider.overrideWith(
                (ref) => FakeListRepository(),
              ),
            ]
          : [],
      child: const App(),
    ),
  );
}
