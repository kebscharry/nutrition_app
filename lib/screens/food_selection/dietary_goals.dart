import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/navigation_service.dart';

class DietaryGoals extends StatefulWidget {
  const DietaryGoals({super.key});

  @override
  State<DietaryGoals> createState() => _DietaryGoalsState();
}

class _DietaryGoalsState extends State<DietaryGoals> {
  final Map<String, Map<String, dynamic>> dietaryOptions = {
    'Weight Management': {
      'icon': Icons.monitor_weight_outlined,
      'options': ['Weight Loss', 'Maintain Weight', 'Weight Gain'],
      'selected': 'Maintain Weight',
    },
    'Dietary Restrictions': {
      'icon': Icons.no_food_outlined,
      'options': ['None', 'Vegetarian', 'Vegan', 'Pescatarian'],
      'selected': 'None',
    },
    'Health Conditions': {
      'icon': Icons.favorite_outline,
      'options': ['None', 'Diabetes', 'Heart Disease', 'High Blood Pressure'],
      'selected': 'None',
    },
    'Daily Calorie Goal': {
      'icon': Icons.local_fire_department_outlined,
      'options': ['1500', '2000', '2500', 'Custom'],
      'selected': '2000',
    },
  };

  final TextEditingController _calorieController = TextEditingController();
  bool _showCustomCalories = false;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      dietaryOptions.forEach((key, value) {
        final saved = prefs.getString(key);
        if (saved != null) {
          value['selected'] = saved;
        }
      });
    });
  }

  Future<void> _savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    for (var entry in dietaryOptions.entries) {
      await prefs.setString(entry.key, entry.value['selected'] as String);
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
              // Header with back button and skip
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
                        color: Colors.brown[100],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),
              const Text(
                "Set your\ndietary goals",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),
              // Dietary options
              Expanded(
                child: ListView.builder(
                  itemCount: dietaryOptions.length,
                  itemBuilder: (context, index) {
                    final entry = dietaryOptions.entries.elementAt(index);
                    final title = entry.key;
                    final data = entry.value;
                    final options = data['options'] as List<String>;
                    final icon = data['icon'] as IconData;

                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(icon, color: Colors.brown),
                              const SizedBox(width: 10),
                              Text(
                                title,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          if (title == 'Daily Calorie Goal' &&
                              _showCustomCalories)
                            TextField(
                              controller: _calorieController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: 'Enter custom calories',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                              ),
                              onSubmitted: (value) {
                                if (value.isNotEmpty) {
                                  setState(() {
                                    data['selected'] = value;
                                    _showCustomCalories = false;
                                  });
                                }
                              },
                            )
                          else
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: options.map((option) {
                                final isSelected = data['selected'] == option;
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (option == 'Custom' &&
                                          title == 'Daily Calorie Goal') {
                                        _showCustomCalories = true;
                                        _calorieController.clear();
                                      } else {
                                        data['selected'] = option;
                                        if (title == 'Daily Calorie Goal') {
                                          _showCustomCalories = false;
                                        }
                                      }
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? Colors.brown[50]
                                          : Colors.grey[100],
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: isSelected
                                            ? Colors.brown
                                            : Colors.transparent,
                                      ),
                                    ),
                                    child: Text(
                                      option,
                                      style: TextStyle(
                                        color: isSelected
                                            ? Colors.brown
                                            : Colors.black87,
                                        fontWeight: isSelected
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              // Finish button
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
                  onPressed: () async {
                    await _savePreferences();
                    if (context.mounted) {
                      NavigationService.completeFoodSelection(context);
                    }
                  },
                  child: const Text(
                    "Finish",
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
