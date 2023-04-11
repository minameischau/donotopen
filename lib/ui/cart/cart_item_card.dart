import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:panow/models/cart_item.dart';
import 'package:panow/ui/control_screen.dart';

class CardItemCard extends StatefulWidget {
  final String productId;
  final CartItem cardItem;

  const CardItemCard({
    required this.productId,
    required this.cardItem,
    super.key,
  });

  @override
  State<CardItemCard> createState() => _CardItemCardState();
}

class _CardItemCardState extends State<CardItemCard> {
  String formatCurrency(double amount) {
    final formatter = NumberFormat.currency(locale: 'vi_VN', symbol: 'VNĐ');
    return formatter.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(widget.cardItem.id),
      background: Container(
        color: Theme.of(context).colorScheme.error,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showConfirmDialog(
          context,
          'Do you want to remove the item from the cart?',
        );
      },
      onDismissed: (direction) {
        context.read<CartManager>().removeItem(widget.productId);
      },
      child: buildItemCard(),
    );
  }

  Widget buildItemCard() {
    
    // return Card(
    //   margin: const EdgeInsets.symmetric(
    //     horizontal: 15,
    //     vertical: 4,
    //   ),
    //   child: Padding(
    //     padding: const EdgeInsets.all(8),
    //     child: ListTile(
    //       leading: CircleAvatar(
    //         child: Padding(
    //           padding: const EdgeInsets.all(5),
    //           child: FittedBox(
    //             child: Text('\$${widget.cardItem.price}'),
    //           ),
    //         ),
    //       ),
    //       title: Text(widget.cardItem.title),
    //       subtitle: Text('Total: ${formatCurrency(widget.cardItem.price * widget.cardItem.quantity)}'),
    //       trailing: Text('x ${widget.cardItem.quantity}'),
    //     ),
    //   ),
    // );

//-----------------------Old version end -------------------------
    return Row(
      children: [
          Container(
            margin: EdgeInsets.only(left: 20, bottom: 20),
            height: 120,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: NetworkImage(widget.cardItem.imageUrl),
                  fit: BoxFit.cover),
            ),
          ),
          Container(
            height: 120,
            width: 230,
            margin: EdgeInsets.only(bottom: 20),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.horizontal(right: Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFFe8e8e8),
                  offset: const Offset(
                    5.0,
                    5.0,
                  ),
                  blurRadius: 5.0,
                  spreadRadius: 2.0,
                ), //BoxShadow
                BoxShadow(
                  color: Colors.white,
                  offset: const Offset(0.0, 0.0),
                  blurRadius: 0.0,
                  spreadRadius: 0.0,
                ), //BoxShadow
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BigText(
                  text: widget.cardItem.title,
                  size: 15,
                ),
                SizedBox(
                  height: 3,
                ),
                SmallText(
                  text: '${formatCurrency(widget.cardItem.price)}',
                  size: 15,
                  color: Colors.red,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.only(left: 10),
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey[200]),
                  width: 100,
                  child: Row(children: [
                    Text(
                      'Số lượng:',
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(width: 5),
                    Text('${widget.cardItem.quantity}',
                        style: TextStyle(fontSize: 17, color: Colors.red))
                  ]),
                )
              ],
            ),
          ),

      ],
    );
  }
}
