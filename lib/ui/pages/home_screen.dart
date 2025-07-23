import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 20,
            bottom: 10,
            left: 20,
            right: 20,
          ),
          child: Center(
            child: Column(
              spacing: 20,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.purple[400],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Center(
                      child: Text(
                        "Find the result of the division",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          color: Colors.deepPurple[300],
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.deepPurple,
                            width: 3,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.deepPurple,
                              spreadRadius: 1,
                              blurRadius: 0,
                              offset: const Offset(4, 4),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            "24 ÷ 3",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 72,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: -25,
                        right: 0,
                        left: 0,
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 0,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.deepPurple[300],
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.deepPurple,
                                width: 3,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.deepPurple,
                                  spreadRadius: 1,
                                  blurRadius: 0,
                                  offset: const Offset(4, 4),
                                ),
                              ],
                            ),
                            child: const Text(
                              "=",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 48,
                                fontWeight: FontWeight.w900,
                                height: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    width: double.maxFinite,
                    decoration: BoxDecoration(color: Colors.red),
                  ),
                ),
                Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(color: Colors.green, width: 3),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.green,
                        spreadRadius: 2,
                        blurRadius: 0,
                        offset: const Offset(2, 2),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.greenAccent,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 50,
                        vertical: 8,
                      ),
                      child: Text(
                        "Check Answer",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.green[800],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
