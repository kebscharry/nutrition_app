import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dietary_goals.dart';

class MealTiming extends StatefulWidget {
  const MealTiming({super.key});

  @override
  State<MealTiming> createState() => _MealTimingState();
}

class _MealTimingState extends State<MealTiming> {
  final List<Map<String, dynamic>> mealTimes = [
    {
      'meal': 'Breakfast',
      'icon': Icons.wb_sunny_outlined,
      'defaultTime': const TimeOfDay(hour: 7, minute: 30),
      'isSelected': true
    },
    {
      'meal': 'Lunch',
      'icon': Icons.sunny,
      'defaultTime': const TimeOfDay(hour: 12, minute: 30),
      'isSelected': true
    },
    {
      'meal': 'Dinner',
      'icon': Icons.nights_stay_outlined,
      'defaultTime': const TimeOfDay(hour: 19, minute: 0),
      'isSelected': true
    },
    {
      'meal': 'Snacks',
      'icon': Icons.cookie_outlined,
      'defaultTime': const TimeOfDay(hour: 15, minute: 30),
      'isSelected': false
    },
  ];

  Map<String, TimeOfDay> selectedTimes = {};

  @override
  void initState() {
    super.initState();
    // Initialize selected times with default values
    for (var meal in mealTimes) {
      if (meal['isSelected']) {
        selectedTimes[meal['meal']] = meal['defaultTime'];
      }
    }
    _loadSavedTimes();
  }

  Future<void> _loadSavedTimes() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      for (var meal in mealTimes) {
        final savedTime = prefs.getString('${meal['meal']}Time');
        if (savedTime != null) {
          final parts = savedTime.split(':');
          selectedTimes[meal['meal']] = TimeOfDay(
            hour: int.parse(parts[0]),
            minute: int.parse(parts[1]),
          );
        }
      }
    });
  }

  Future<void> _saveMealTimes() async {
    final prefs = await SharedPreferences.getInstance();
    for (var entry in selectedTimes.entries) {
      await prefs.setString(
        '${entry.key}Time',
        '${entry.value.hour}:${entry.value.minute}',
      );
    }
  }

  Future<void> _selectTime(String meal, TimeOfDay currentTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: currentTime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            timePickerTheme: TimePickerThemeData(
              backgroundColor: Colors.white,
              hourMinuteShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              dayPeriodBorderSide: const BorderSide(color: Colors.grey),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        selectedTimes[meal] = picked;
      });
      await _saveMealTimes();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.arrow_back),
                    ),
                  ),
                  Text(
                    "Skip",
                    style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              // Progress indicator
              Row(
                children: List.generate(
                  4,
                  (index) => Expanded(
                    child: Container(
                      height: 10,
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                        color: index <= 2 ? Colors.brown[100] : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),
              const Text(
                "When would you like\nto eat?",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),
              // Meal timing cards
              Expanded(
                child: ListView.builder(
                  itemCount: mealTimes.length,
                  itemBuilder: (context, index) {
                    final meal = mealTimes[index];
                    final isSelected = selectedTimes.containsKey(meal['meal']);
                    final timeOfDay =
                        selectedTimes[meal['meal']] ?? meal['defaultTime'];

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.brown[50] : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          leading: Icon(
                            meal['icon'],
                            size: 30,
                            color: isSelected ? Colors.brown : Colors.grey,
                          ),
                          title: Text(
                            meal['meal'],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (isSelected)
                                GestureDetector(
                                  onTap: () =>
                                      _selectTime(meal['meal'], timeOfDay),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Text(
                                      timeOfDay.format(context),
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              const SizedBox(width: 10),
                              Switch(
                                value: isSelected,
                                onChanged: (value) {
                                  setState(() {
                                    if (value) {
                                      selectedTimes[meal['meal']] =
                                          meal['defaultTime'];
                                    } else {
                                      selectedTimes.remove(meal['meal']);
                                    }
                                  });
                                  _saveMealTimes();
                                },
                                activeColor: Colors.brown,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Next button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DietaryGoals(),
                      ),
                    );
                  },
                  child: const Text(
                    "Next",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
