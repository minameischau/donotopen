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
        title: const Center(
          child: Text(
            'Confim information',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                height: deviceSize.height * 0.4,
                child: buildCartDetails(cart),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total Payment:',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
              SingleChildScrollView(
                child: Container(
                  // padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  padding: EdgeInsets.all(deviceSize.width * .01),
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
                          padding: EdgeInsets.symmetric(
                              vertical: deviceSize.height * .02),
                          child: const Text(
                            'Order Information',
                            style: TextStyle(
                                color: primaryCorlor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: deviceSize.width * .05),
                          child: TextFormField(
                            initialValue: _addOrder.name,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Full name",
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
                          padding: EdgeInsets.symmetric(
                              vertical: deviceSize.height * .01,
                              horizontal: deviceSize.width * 0.05),
                          child: TextFormField(
                            initialValue: _addOrder.address,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Delivery address",
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
                          padding: EdgeInsets.symmetric(
                              horizontal: deviceSize.width * .05),
                          child: TextFormField(
                            initialValue: _addOrder.phone,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Phone number",
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextButton(
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
                              'Place Order',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            style: TextButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    vertical: deviceSize.height * 0.015,
                                    horizontal: deviceSize.width * 0.32),
                                foregroundColor: Colors.white,
                                elevation: 5,
                                // backgroundColor: AppColors.mainColor),
                                backgroundColor: primaryCorlor),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
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
