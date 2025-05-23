import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'portion_selection.dart';

class FoodList extends StatefulWidget {
  const FoodList({super.key});

  @override
  State<FoodList> createState() => _FoodListState();
}

class _FoodListState extends State<FoodList> {
  List<Map<String, dynamic>> gridItems = [
    {"image": "assets/cabbage.png", "text": "Cabbage"},
    {"image": "assets/chicken.png", "text": "Chicken"},
    {"image": "assets/meat.png", "text": "Meat"},
    {"image": "assets/egg.png", "text": "Egg"},
    {"image": "assets/brocolli.png", "text": "Brocolli"},
    {"image": "assets/corn.png", "text": "Corn"},
    {"image": "assets/carrot.png", "text": "Carrot"},
    {"image": "assets/sweet_potato.png", "text": "Sweet Potato"},
    {"image": "assets/lettuce.png", "text": "Lettuce"},
  ];

  Set<String> selectedFoods = {};

  @override
  void initState() {
    super.initState();
    _loadSelectedFoods();
  }

  Future<void> _loadSelectedFoods() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedFoods = prefs.getStringList('selectedFoods')?.toSet() ?? {};
    });
  }

  Future<void> _saveSelectedFoods() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('selectedFoods', selectedFoods.toList());
  }

  void toggleSelection(String foodName) {
    setState(() {
      if (selectedFoods.contains(foodName)) {
        selectedFoods.remove(foodName);
      } else {
        selectedFoods.add(foodName);
      }
      _saveSelectedFoods();
    });
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
              /// Header
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Let's Start...",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    Text("Skip",
                        style: TextStyle(fontSize: 24, fontFamily: 'Poppins')),
                  ],
                ),
              ),

              /// Progress indicator
              SizedBox(height: 20),
              Row(
                children: List.generate(
                  4,
                  (index) => Expanded(
                    child: Container(
                      height: 10,
                      margin: EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                        color: index == 0 ? Colors.brown[100] : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),

              /// Prompt
              SizedBox(height: 20),
              Text("What material you\n like the most",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              SizedBox(height: 10),
              SizedBox(
                width: 300,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[300],
                      foregroundColor: Colors.grey[600]),
                  onPressed: () {},
                  child: Text("You can choose more than 1 answer"),
                ),
              ),
              SizedBox(height: 30),

              /// Grid of food items
              Expanded(
                child: GridView.builder(
                  itemCount: gridItems.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 0.8,
                  ),
                  itemBuilder: (context, index) {
                    String foodName = gridItems[index]["text"];
                    bool isSelected = selectedFoods.contains(foodName);
                    return GestureDetector(
                      onTap: () => toggleSelection(foodName),
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.brown[100] : Colors.white,
                          borderRadius: BorderRadius.circular(35),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  gridItems[index]["image"],
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(foodName,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              /// Next button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PortionSelection(
                          selectedFoods: selectedFoods.toList(),
                        ),
                      ),
                    );
                  },
                  child: Text("Next"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
