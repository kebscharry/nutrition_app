import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../models/water_log.dart';

class WaterTrackingService {
  static const String _storageKey = 'water_logs';
  final _uuid = const Uuid();
  static SharedPreferences? _prefs;

  // Lazy load SharedPreferences
  Future<SharedPreferences> get _sharedPrefs async {
    return _prefs ??= await SharedPreferences.getInstance();
  }

  // Add new water intake entry
  Future<void> addWaterIntake(int amount) async {
    try {
      //final prefs = await _sharedPrefs;
      final logs = await getWaterLogs();

      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);

      final log = WaterLog(
        id: _uuid.v4(),
        date: today,
        amount: amount,
        timestamp: now,
      );

      logs.add(log);
      await _saveLogs(logs);
    } catch (e) {
      print('Error adding water intake: $e');
    }
  }

  // Get total water intake for a specific date
  Future<int> getWaterIntakeForDate(DateTime date) async {
    final logs = await getWaterLogs();
    final dayLogs = logs.where((log) =>
        log.date.year == date.year &&
        log.date.month == date.month &&
        log.date.day == date.day);

    return dayLogs.fold<int>(0, (sum, WaterLog log) => sum + log.amount);
  }

  // Get all water logs
  Future<List<WaterLog>> getWaterLogs() async {
    try {
      final prefs = await _sharedPrefs;
      final jsonString = prefs.getString(_storageKey);
      if (jsonString == null) return [];

      final List<dynamic> jsonList = jsonDecode(jsonString);
      final logs = jsonList.map((json) => WaterLog.fromJson(json)).toList();
      logs.sort(
          (a, b) => b.timestamp.compareTo(a.timestamp)); // Sort descending
      return logs;
    } catch (e) {
      print('Error retrieving logs: $e');
      return [];
    }
  }

  // Get logs for a specific date
  Future<List<WaterLog>> getWaterLogsForDate(DateTime date) async {
    final logs = await getWaterLogs();
    return logs
        .where((log) =>
            log.date.year == date.year &&
            log.date.month == date.month &&
            log.date.day == date.day)
        .toList();
  }

  // Delete a water log by ID
  Future<void> deleteWaterLog(String id) async {
    try {
      final logs = await getWaterLogs();
      logs.removeWhere((log) => log.id == id);
      await _saveLogs(logs);
    } catch (e) {
      print('Error deleting log: $e');
    }
  }

  // Update a water log
  Future<void> updateWaterLog(WaterLog updatedLog) async {
    try {
      final logs = await getWaterLogs();
      final index = logs.indexWhere((log) => log.id == updatedLog.id);
      if (index != -1) {
        logs[index] = updatedLog;
        await _saveLogs(logs);
      }
    } catch (e) {
      print('Error updating log: $e');
    }
  }

  // Save logs to SharedPreferences
  Future<void> _saveLogs(List<WaterLog> logs) async {
    final prefs = await _sharedPrefs;
    final jsonList = logs.map((log) => log.toJson()).toList();
    await prefs.setString(_storageKey, jsonEncode(jsonList));
  }
}
