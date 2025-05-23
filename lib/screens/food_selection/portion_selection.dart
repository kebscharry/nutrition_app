import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'meal_timing.dart';

class PortionSelection extends StatefulWidget {
  final List<String> selectedFoods;

  const PortionSelection({
    super.key,
    required this.selectedFoods,
  });

  @override
  State<PortionSelection> createState() => _PortionSelectionState();
}

class _PortionSelectionState extends State<PortionSelection> {
  // Store portion sizes for each food
  Map<String, double> portionSizes = {};

  @override
  void initState() {
    super.initState();
    // Initialize portion sizes to 1.0 for each food
    for (var food in widget.selectedFoods) {
      portionSizes[food] = 1.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back, size: 24),
                    ),
                    Text("Skip",
                        style: TextStyle(fontSize: 24, fontFamily: 'Poppins')),
                  ],
                ),
              ),

              // Progress indicator
              const SizedBox(height: 20),
              Row(
                children: List.generate(
                  4,
                  (index) => Expanded(
                    child: Container(
                      height: 10,
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                        color: index <= 1 ? Colors.brown[100] : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),

              // Title
              const SizedBox(height: 20),
              const Text(
                "Choose your\nportion size",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 20),
              // Portion selection list
              Expanded(
                child: ListView.builder(
                  itemCount: widget.selectedFoods.length,
                  itemBuilder: (context, index) {
                    final food = widget.selectedFoods[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              food,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: Slider(
                                    value: portionSizes[food] ?? 1.0,
                                    min: 0.5,
                                    max: 3.0,
                                    divisions: 5,
                                    activeColor: Colors.brown[100],
                                    inactiveColor: Colors.grey[300],
                                    onChanged: (value) {
                                      setState(() {
                                        portionSizes[food] = value;
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  '${portionSizes[food]?.toStringAsFixed(1)} x',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
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
                  ),
                  onPressed: () async {
                    // Save portion sizes
                    final prefs = await SharedPreferences.getInstance();
                    final portionData = portionSizes.map(
                      (key, value) => MapEntry(key, value.toString()),
                    );
                    await prefs.setString(
                      'portionSizes',
                      portionData.toString(),
                    );
                    // Navigate to meal timing screen
                    if (context.mounted) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MealTiming(),
                        ),
                      );
                    }
                  },
                  child: const Text("Next"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
