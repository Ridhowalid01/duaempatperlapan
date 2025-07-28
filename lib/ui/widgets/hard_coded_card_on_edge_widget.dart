// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../controllers/marble_controller.dart';
//
// // hardcoded position for card area overlay
//
// class HardcodedCardOnEdgeWidget extends StatefulWidget {
//   const HardcodedCardOnEdgeWidget({super.key});
//
//   @override
//   State<HardcodedCardOnEdgeWidget> createState() => _HardcodedCardOnEdgeWidgetState();
// }
//
// class _HardcodedCardOnEdgeWidgetState extends State<HardcodedCardOnEdgeWidget> {
//   late MarbleController controller;
//
//   @override
//   void initState() {
//     super.initState();
//     controller = Get.find<MarbleController>();
//
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       // Posisi yang konsisten untuk release mode
//       final cardPositions = [
//         Rect.fromLTRB(0.0, 0.0, 50.0, 110.0),
//         Rect.fromLTRB(0.0, 177.2, 50.0, 287.2),
//         Rect.fromLTRB(0.0, 354.5, 50.0, 464.5),
//       ];
//
//       for (int i = 0; i < 3; i++) {
//         controller.updateCardRect(i, cardPositions[i]);
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: List.generate(3, (i) {
//         final colors = [
//           [Colors.orangeAccent, Colors.orange],
//           [Colors.yellowAccent, Colors.yellow],
//           [Colors.cyanAccent, Colors.cyan],
//         ];
//         return _buildColorCard(i, colors[i][0], colors[i][1]);
//       }),
//     );
//   }
//
//   Widget _buildColorCard(int index, Color mainColor, Color shadowColor) {
//     return Container(
//       width: 50,
//       height: 100,
//       margin: const EdgeInsets.only(bottom: 10),
//       decoration: BoxDecoration(
//         color: mainColor,
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(color: shadowColor, width: 2),
//         boxShadow: [
//           BoxShadow(
//             color: shadowColor,
//             spreadRadius: 1,
//             blurRadius: 0,
//             offset: const Offset(3, 3),
//           ),
//         ],
//       ),
//     );
//   }
// }
