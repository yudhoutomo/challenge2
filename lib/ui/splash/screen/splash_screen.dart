import 'package:challenge2/core/config/config.dart';
import 'package:challenge2/di/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import '../widget/im_flutter.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkstate();
  }

  Future<void> checkstate() async {
    var isLogin =
        await getIt<FlutterSecureStorage>().read(key: Config.IS_LOGIN);
    debugPrint(isLogin);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(const Duration(seconds: 3),
          () => {context.go(isLogin != null ? '/menu' : '/login')});
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ImFlutter(),
    );
  }
}
