import 'package:panow/models/order_item.dart';
import 'package:getwidget/getwidget.dart';

import '/models/cart_item.dart';
// import '/ui/orders/app_bar_order.dart';
// import '/ui/.dart';
import 'package:panow/ui/control_screen.dart';
import 'package:flutter/material.dart';
// import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';
import 'app_bar_order.dart';
import 'package:intl/intl.dart';
// import '';


class OrderInformation extends StatefulWidget {
  final List<CartItem> product;
  final email;
  final total;
  OrderInformation(this.product, this.total, this.email, {super.key}) {
    this.orderItem = OrderItem(
      id: null,
      amount: this.total, 
      products: [], 
      name: '', 
      email: this.email, 
      phone: '', 
      address: '',
      dateTime: new DateTime.now());
  }
  late final OrderItem orderItem;
  @override
  State<OrderInformation> createState() => _OrderInformationState();
}
class _OrderInformationState extends State<OrderInformation> {
  TextEditingController fullnameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  var _isLoading = false;
  final _addForm = GlobalKey<FormState>();
  late OrderItem _addOrder;
  @override
  void initState() {
    setState(() {});
    _addOrder = widget.orderItem;
    super.initState();
  }

  @override
  void dispose() {
    fullnameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }

  
  String formatCurrency(double amount) {
    final formatter = NumberFormat.currency(locale: 'vi_VN', symbol: 'VNĐ');
    return formatter.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final cart = context.watch<CartManager>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Confim information'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // AppBarOrder(
              // title: 'Xác nhận thông tin đơn hàng',
              // click: IconButton(
              //     onPressed: () {
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => HomeScreen()));
              //     },
              //     icon: Icon(Icons.home))
            // ),
            Container(
              // height: 380,
              // child: ListView.builder(
                // shrinkWrap: true,
                // scrollDirection: Axis.vertical,
                // itemCount: widget.product.length,
                // itemBuilder: (context, index) {

      //--------------------Old version------------------------            
                  // return ListTile(
                  //   leading: GFAvatar(
                  //     shape: GFAvatarShape.standard,
                  //     backgroundImage:
                  //         NetworkImage(widget.product[index].imageUrl),
                  //   ),
                  //   // Image.network(product[index].imageUrl, fit: BoxFit.contain,),
                  //   title: Text('${widget.product[index].title}',
                  //   style: TextStyle(
                  //   fontWeight: FontWeight.bold, fontSize: 18)),
                  //   subtitle: Row(
                  //     children: [
                  //       Text(
                  //         'Số lượng: ',
                  //         style: TextStyle(color: Colors.grey[500]),
                  //       ),
                  //       Text(
                  //         '${widget.product[index].quantity}',
                  //         style: TextStyle(color: Colors.red, fontSize: 15),
                  //       ),
                  //     ],
                  //   ),
                  //   trailing: Text(
                  //     // '${}00 VNĐ',
                  //     formatCurrency(widget.product[index].price),
                  //     style: TextStyle(
                  //         //fontWeight: FontWeight.bold,
                  //         color: Colors.red,
                  //         fontSize: 17),
                  //   ),
                  // );
      //--------------------Old version end------------------------   
                  // return Consumer<AuthManager>(
                  //   builder: (context, authManager, child) {
                  //     return Scaffold(
                  //       body: Column(children: [
                  //           Expanded(
                  //           child: SingleChildScrollView(
                  //             child: Container(
                  //               height: 1000,
                  //               child: buildCartDetails(cart),
                  //             ),
                  //           ),
                  //         ),
                  //       ],)
                  //     );
                  //   },
                  // );
                // },
                child: Container(
                  height: deviceSize.height*0.5,
                  child: buildCartDetails(cart),
                ),
              // ),
            ),
            Container(
              padding: EdgeInsets.only(right: 20, bottom: 20, left: 120),
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Thành tiền:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    // '${}00 VNĐ',
                    formatCurrency(widget.total),
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.red),
                  ),
                ],
              ),
            ),
            Container(
              height: 350,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFe8e8e8),
                    offset: const Offset(5.0, 5.0),
                    blurRadius: 5.0,
                    spreadRadius: 5.0,
                  ), //BoxShadow
                  BoxShadow(
                    color: Colors.white,
                    offset: const Offset(.0, 5.0),
                    blurRadius: 0.0,
                    spreadRadius: 0.0,
                  ), //BoxShadow
                ],
              ),
              child: Form(
                key: _addForm,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        'Thông tin đặt hàng',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                      child: TextFormField(
                        initialValue: _addOrder.name,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Họ tên",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please provide a value.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _addOrder = _addOrder.copyWith(name: value);
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                      child: TextFormField(
                        initialValue: _addOrder.address,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Địa chỉ",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please provide a value.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _addOrder = _addOrder.copyWith(address: value);
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: 10, left: 20, right: 20, bottom: 10),
                      child: TextFormField(
                        initialValue: _addOrder.phone,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Số điện thoại",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please provide a value.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _addOrder = _addOrder.copyWith(phone: value);
                        },
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        _saveForm();
                        // context.read<OrdersManager>().addOrder(
                        //     widget.product,
                        //     widget.total,
                        //     fullnameController.text,
                        //     phoneController.text,
                        //     addressController.text);
                        context.read<CartManager>().clear();
                      },
                      child: Text(
                        'Đặt hàng',
                        style: TextStyle(fontSize: 18),
                      ),
                      style: TextButton.styleFrom(
                          padding: EdgeInsets.only(
                              top: 15, bottom: 15, left: 140, right: 140),
                          foregroundColor: Colors.white,
                          elevation: 20,
                          // backgroundColor: AppColors.mainColor),
                          backgroundColor: primaryCorlor),  
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCartDetails(CartManager cart) {
    return ListView(
      children: cart.productEntries
        .map((e) => CardItemCard(productId: e.key, cardItem: e.value))
        .toList(),
    );
  }

  Future<void> _saveForm() async {
    final isValid = _addForm.currentState!.validate();
    if (!isValid) {
      return;
    }
    _addForm.currentState!.save();

    setState(() {
      _isLoading = true;
    });
    // print('save');
    print(_addOrder.name);
    print(_addOrder.amount);
    print(_addOrder.address);
    print(_addOrder.phone);
    print(_addOrder.email);
    try {
      final ordersManager = context.read<OrdersManager>();
      await ordersManager.addOrder(_addOrder);
      print(ordersManager.orderCount);
    } catch (error) {
      await showErrorDialog(context, 'Something went wrong.');
    }
    setState(() {
      _isLoading = false;
    });
    if (mounted) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => OrderScreen()));
    }
  }

  Future<void> showErrorDialog(BuildContext context, String message) {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('An Error Occurred'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }
}