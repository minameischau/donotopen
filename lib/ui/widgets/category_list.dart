// import 'package:eatcleanproject/models/typeproduct.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'ui';
// import 'package:eatcleanproject/ui/widgets/big_text.dart';
// import 'package:eatcleanproject/ui/widgets/small_text.dart';
// import 'package:eatcleanproject/ui/Products/Manager/type_product_manager.dart';

// class CategoryList extends StatefulWidget {
//   // final TypeProduct typeProduct;
//   const CategoryList({super.key});
  
//   @override
//   State<CategoryList> createState() => _CategoryListState();
// }

// class _CategoryListState extends State<CategoryList> {
//   final typeproducts = TypeProductManager().items;
//   @override
//   Widget build(BuildContext context) {
//     return  Container(
//       height: 140,
//       child: ListView.builder(
//           scrollDirection: Axis.horizontal,
//           itemCount: TypeProductManager().itemCount,
//           itemBuilder: (context, index) => CategoryChild(typeproducts[index])),
//     );
//   }
// }

// class CategoryChild extends StatelessWidget {
//   final TypeProduct typeproduct;
//   const CategoryChild(this.typeproduct, {super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.all(15),
//       child: Column(
//         children: [
//           Container(
//             height: 80,
//             width: 80,
//             decoration: BoxDecoration(
//                 image: DecorationImage(
//                     image: NetworkImage(typeproduct.hinhanh),
//                     fit: BoxFit.cover),
//                 borderRadius: BorderRadius.circular(20),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Color.fromARGB(255, 176, 176, 176),
//                     offset: const Offset(
//                       5.0,
//                       5.0,
//                     ),
//                     blurRadius: 10.0,
//                     spreadRadius: 2.0,
//                   ),
//                 ]),
//           ),
//           Container(
//               margin: EdgeInsets.only(top: 12),
//               height: 18,
//               child: Text(
//                 typeproduct.tenloai,
//                 style: TextStyle(
//                     fontFamily: 'Poppins',
//                     fontSize: 15,
//                     fontWeight: FontWeight.w500),
//               )),
//         ],
//       ),
//     );
//   }
// }
