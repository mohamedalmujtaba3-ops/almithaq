import 'package:flutter/material.dart';

class EtaCard extends StatelessWidget {
  final String distance;
  final String eta;

  const EtaCard(
      {Key? key, required this.distance, required this.eta,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return    Positioned(
                    top: 30,
                    left: 20,
                    right: 20,
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          )
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              const Icon(Icons.timer, color: Colors.blueAccent),
                              const SizedBox(height: 5),
                              Text(
                                eta,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              const Text("وقت الوصول",
                                  style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                          Container(
                            height: 40,
                            width: 1,
                            color: Colors.grey.shade300,
                          ),
                          Column(
                            children: [
                              const Icon(Icons.route, color: Colors.green),
                              const SizedBox(height: 5),
                              Text(
                                distance,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              const Text("المسافة",
                                  style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );

  }
}