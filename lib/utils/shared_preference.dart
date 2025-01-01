import 'dart:convert';

import 'package:hni_customers_app/model/hni_customer_met_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const String _userDataKey = 'latest_user_data';

  /// Save the most recent user data
  static Future<void> saveLatestUserData(
    HniCustomerMetResponce userData,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(userData.toJson()); // Convert to JSON
    await prefs.setString(
      _userDataKey,
      jsonString,
    );
  }

  /// Load the most recent user data
  static Future<HniCustomerMetResponce?> loadLatestUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_userDataKey);

    if (jsonString != null) {
      final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
      return HniCustomerMetResponce.fromJson(
        jsonMap,
      ); // Convert JSON back to object
    }

    return null; // No data found
  }

  /// Delete the most recent user data
  static Future<void> deleteLatestUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userDataKey); // Remove the key
  }
}
