import 'package:flutter/foundation.dart';

class Config {
  static const baseUrl = 'http://34.128.80.67';
  static const apiKey = 'rahasia';
  static const notificationChannelId = 'challenge2_channel_id';
  static const notificationChannelName = 'challenge2 notification';
  static const notificationChannelDesc = 'challenge2 notification';
  static const savedNotification = 'FCM_MESSAGE';
  static const IS_LOGIN = 'IS_LOGIN';
  static const timeout = kDebugMode ? 90 * 1000 : 10 * 1000;
}
