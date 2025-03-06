import 'package:flutter/material.dart';

class FoodList extends StatefulWidget {
  const FoodList({super.key});

  @override
  State<FoodList> createState() => _FoodListState();
}

class _FoodListState extends State<FoodList> {
  // List of grid items with images and default colors
  List<Map<String, dynamic>> gridItems = [
    {
      "image": "assets/cabbage.png",
      "color": Colors.white,
      "text": "Cabbage",
    },
    {
      "image": "assets/chicken.png",
      "color": Colors.white,
      "text": "Chicken",
    },
    {
      "image": "assets/meat.png",
      "color": Colors.lightGreen[100],
      "text": "Meat",
    },
    {
      "image": "assets/egg.png",
      "color": Colors.lightGreen[100],
      "text": "Egg",
    },
    {
      "image": "assets/brocolli.png",
      "color": Colors.white,
      "text": "Brocolli",
    },
    {
      "image": "assets/corn.png",
      "color": Colors.white,
      "text": "Corn",
    },
    {
      "image": "assets/carrot.png",
      "color": Colors.white,
      "text": "Carrot",
    },
    {
      "image": "assets/sweet_potato.png",
      "color": Colors.white,
      "text": "Sweet Potato",
    },
    {
      "image": "assets/lettuce.png",
      "color": Colors.lightGreen[100],
      "text": "Lettuce",
    },
  ];

  // Function to change color when tapped
  void changeColor(int index) {
    setState(() {
      gridItems[index]["color"] = (gridItems[index]["color"] == Colors.white)
          ? Colors.brown[100]
          : Colors.white;
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Let's Start...",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Text(
                      "Skip",
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.black,
                          fontFamily: 'Poppins'),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 10,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.brown[100],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    child: Container(
                      height: 10,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    child: Container(
                      height: 10,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    child: Container(
                      height: 10,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                "What material you\n like the most",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 30),
              ),
              SizedBox(height: 10),
              SizedBox(
                  width: 300,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[300],
                          foregroundColor: Colors.grey[600]),
                      onPressed: () {},
                      child: Text("You can choose more than 1 answer"))),
              SizedBox(height: 30),
              Expanded(
                child: GridView.builder(
                  itemCount: gridItems.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    childAspectRatio: 0.8, // Makes grid items square
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => changeColor(index), // Tap to change color
                      child: Container(
                        decoration: BoxDecoration(
                          color: gridItems[index]["color"], // Dynamic color
                          borderRadius: BorderRadius.circular(35),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ///Food Image
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(gridItems[index]["image"],
                                    fit: BoxFit.contain),
                              ),
                            ),

                            /// Food Name Below Image
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                gridItems[index]["text"],
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white),
                      onPressed: () {},
                      child: Text("Next"))),
            ],
          ),
        ),
      ),
    );
  }
}
