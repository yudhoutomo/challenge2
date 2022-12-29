import 'package:challenge2/core/config/config.dart';
import 'package:challenge2/di/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import '../widget/im_flutter.dart';

class LoadingWidget extends StatelessWidget {
  final Color customColor;
  LoadingWidget(this.customColor);

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(
        customColor, // <--- // your specified color
      ),
    );
  }
}
