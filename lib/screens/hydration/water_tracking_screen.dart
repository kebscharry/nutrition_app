import 'package:flutter/material.dart';
import 'package:nutrition/models/water_log.dart';
import 'package:nutrition/services/water_tracking_service.dart';

class WaterTrackingScreen extends StatefulWidget {
  const WaterTrackingScreen({super.key});

  @override
  State<WaterTrackingScreen> createState() => _WaterTrackingScreenState();
}

class _WaterTrackingScreenState extends State<WaterTrackingScreen> {
  final _waterService = WaterTrackingService();
  int _todaysIntake = 0;
  final int _dailyGoal = 2000; // 2L daily goal
  List<WaterLog> _todaysLogs = [];

  @override
  void initState() {
    super.initState();
    _loadWaterData();
  }

  Future<void> _loadWaterData() async {
    final today = DateTime.now();
    final intake = await _waterService.getWaterIntakeForDate(today);
    final logs = await _waterService.getWaterLogsForDate(today);

    if (mounted) {
      setState(() {
        _todaysIntake = intake;
        _todaysLogs = logs;
      });
    }
  }

  Future<void> _addWaterIntake(int amount) async {
    await _waterService.addWaterIntake(amount);
    _loadWaterData();
  }

  Future<void> _deleteLog(String id) async {
    await _waterService.deleteWaterLog(id);
    _loadWaterData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Water Tracking'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: _loadWaterData,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildWaterProgress(),
                const SizedBox(height: 24),
                _buildQuickAddButtons(),
                const SizedBox(height: 24),
                _buildTodaysLogs(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWaterProgress() {
    final progress = _todaysIntake / _dailyGoal;

    return Card(
      elevation: 0,
      color: Colors.blue[50],
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Today\'s Intake',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.headlineMedium,
                        children: [
                          TextSpan(
                            text:
                                '${(_todaysIntake / 1000).toStringAsFixed(1)}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                          TextSpan(
                            text:
                                ' / ${(_dailyGoal / 1000).toStringAsFixed(1)}L',
                            style: TextStyle(
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Icon(
                  Icons.water_drop,
                  size: 48,
                  color: Colors.blue[200],
                ),
              ],
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: progress.clamp(0, 1),
              backgroundColor: Colors.blue[100],
              color: Colors.blue,
              minHeight: 10,
              borderRadius: BorderRadius.circular(5),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAddButtons() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Add',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildAddButton(100, 'Small\n100ml'),
            _buildAddButton(200, 'Medium\n200ml'),
            _buildAddButton(300, 'Large\n300ml'),
          ],
        ),
      ],
    );
  }

  Widget _buildAddButton(int amount, String label) {
    return InkWell(
      onTap: () => _addWaterIntake(amount),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.blue[100]!),
        ),
        child: Column(
          children: [
            Icon(Icons.water_drop, color: Colors.blue[300]),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.blue[900],
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTodaysLogs() {
    if (_todaysLogs.isEmpty) {
      return Center(
        child: Text(
          'No water intake logged today',
          style: TextStyle(color: Colors.grey[600]),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Today\'s Logs',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 16),
        ..._todaysLogs.map((log) => _buildLogItem(log)),
      ],
    );
  }

  Widget _buildLogItem(WaterLog log) {
    return Card(
      elevation: 0,
      child: ListTile(
        leading: Icon(Icons.water_drop, color: Colors.blue[300]),
        title: Text('${log.amount}ml'),
        subtitle: Text(
          '${log.timestamp.hour}:${log.timestamp.minute.toString().padLeft(2, '0')}',
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline),
          onPressed: () => _deleteLog(log.id),
        ),
      ),
    );
  }
}
