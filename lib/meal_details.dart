import 'package:flutter/material.dart';

class MealDetails extends StatelessWidget {
  const MealDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        backgroundColor: Colors.pink[50],
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Container(
              height: 40,
              width: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                  ),
                ],
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child:
                  IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back))),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            height: 300,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.pink[50],
              image: DecorationImage(
                image: AssetImage("assets/food_plate.png"),
                fit: BoxFit.contain,
                alignment: Alignment(3.5, 0),
              ),
            ),
            //texts
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Mix Salad\n Vegetables",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Container(
                      height: 30,
                      width: 5,
                      decoration: BoxDecoration(
                          color: Colors.amber[50],
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "240 ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text("Calories"),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                //second row
                Row(
                  children: [
                    Container(
                      height: 30,
                      width: 5,
                      decoration: BoxDecoration(
                          color: Colors.blue[100],
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "19gr ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text("Protein"),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),

                //third row
                Row(
                  children: [
                    Container(
                      height: 30,
                      width: 5,
                      decoration: BoxDecoration(
                          color: Colors.green[50],
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "5gr ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text("Carbs"),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: EdgeInsets.all(16),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                      ),
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Ingredients",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "6 healthy ingredients",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 13),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  alignment: Alignment.center,
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                      Icons.circle_notifications_outlined)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  height: 40,
                                  width: 40,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey[100],
                                  ),
                                  child: Icon(
                                      Icons.download_for_offline_outlined)),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      flex: 1,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            //first container
                            Container(
                              height: 80,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  // Aligns items vertically
                                  children: [
                                    // Image Container
                                    Container(
                                      height: 70,
                                      width: 70,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                          image:
                                              AssetImage("assets/shrimp.png"),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),

                                    // Expanded Column for Text
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start, // Aligns text to the left
                                        mainAxisAlignment: MainAxisAlignment
                                            .center, // Centers text vertically
                                        children: [
                                          Text(
                                            "Shrimp",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          // Space between title & description
                                          Text(
                                            "The shrimp is briefly fried, then add\ninstant sauce to it",
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 15,
                                            ),
                                            maxLines: 2,
                                            // Ensures text doesn't overflow
                                            overflow: TextOverflow
                                                .ellipsis, // Adds "..." if text is too long
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            //second container
                            Container(
                              height: 80,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  // Aligns items vertically
                                  children: [
                                    // Image Container
                                    Container(
                                      height: 70,
                                      width: 70,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                          image:
                                              AssetImage("assets/strawberry.png"),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),

                                    // Expanded Column for Text
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start, // Aligns text to the left
                                        mainAxisAlignment: MainAxisAlignment
                                            .center, // Centers text vertically
                                        children: [
                                          Text(
                                            "Strawberry",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          // Space between title & description
                                          Text(
                                            "To make your dish balanced include\nnatural sugar from the fruit",
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 15,
                                            ),
                                            maxLines: 2,
                                            // Ensures text doesn't overflow
                                            overflow: TextOverflow
                                                .ellipsis, // Adds "..." if text is too long
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            //third container
                            Container(
                              height: 80,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  // Aligns items vertically
                                  children: [
                                    // Image Container
                                    Container(
                                      height: 70,
                                      width: 70,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                          image:
                                              AssetImage("assets/kale.png"),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),

                                    // Expanded Column for Text
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start, // Aligns text to the left
                                        mainAxisAlignment: MainAxisAlignment
                                            .center, // Centers text vertically
                                        children: [
                                          Text(
                                            "Kale",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          // Space between title & description
                                          Text(
                                            "Vegetables rich in nutrients that\ncontain minerals and antioxidants",
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 15,
                                            ),
                                            maxLines: 2,
                                            // Ensures text doesn't overflow
                                            overflow: TextOverflow
                                                .ellipsis, // Adds "..." if text is too long
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            //fourth container
                            Container(
                              height: 80,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  // Aligns items vertically
                                  children: [
                                    // Image Container
                                    Container(
                                      height: 70,
                                      width: 70,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                          image:
                                              AssetImage("assets/corn.png"),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),

                                    // Expanded Column for Text
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start, // Aligns text to the left
                                        mainAxisAlignment: MainAxisAlignment
                                            .center, // Centers text vertically
                                        children: [
                                          Text(
                                            "Corn",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          // Space between title & description
                                          Text(
                                            "The shrimp is briefly fried, then add\ninstant sauce to it",
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 15,
                                            ),
                                            maxLines: 2,
                                            // Ensures text doesn't overflow
                                            overflow: TextOverflow
                                                .ellipsis, // Adds "..." if text is too long
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            //fifth container
                            Container(
                              height: 80,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  // Aligns items vertically
                                  children: [
                                    // Image Container
                                    Container(
                                      height: 70,
                                      width: 70,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                          image:
                                              AssetImage("assets/shrimp.png"),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),

                                    // Expanded Column for Text
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start, // Aligns text to the left
                                        mainAxisAlignment: MainAxisAlignment
                                            .center, // Centers text vertically
                                        children: [
                                          Text(
                                            "Shrimp",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          // Space between title & description
                                          Text(
                                            "The shrimp is briefly fried, then add\ninstant sauce to it",
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 15,
                                            ),
                                            maxLines: 2,
                                            // Ensures text doesn't overflow
                                            overflow: TextOverflow
                                                .ellipsis, // Adds "..." if text is too long
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            //6th container
                            Container(
                              height: 80,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  // Aligns items vertically
                                  children: [
                                    // Image Container
                                    Container(
                                      height: 70,
                                      width: 70,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                          image:
                                              AssetImage("assets/shrimp.png"),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),

                                    // Expanded Column for Text
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start, // Aligns text to the left
                                        mainAxisAlignment: MainAxisAlignment
                                            .center, // Centers text vertically
                                        children: [
                                          Text(
                                            "Shrimp",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          // Space between title & description
                                          Text(
                                            "The shrimp is briefly fried, then add\ninstant sauce to it",
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 15,
                                            ),
                                            maxLines: 2,
                                            // Ensures text doesn't overflow
                                            overflow: TextOverflow
                                                .ellipsis, // Adds "..." if text is too long
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
