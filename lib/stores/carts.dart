import 'package:bloc/bloc.dart';
import 'package:fk/models/cart_item.dart';
import 'package:fk/models/product.dart';

class CartState {
  final List<CartItem> items;

  CartState({required this.items});

  double get totalCost {
    double sum = 0.0;
    for (CartItem item in items) {
      sum += item.product.price * item.quantity;
    }
    return double.parse(sum.toStringAsFixed(3));
  }
}

class CartBloc extends Bloc<Object, CartState> {
  static const int defaultQuantity = 1;

  CartBloc() : super(CartState(items: []));

  @override
  Stream<CartState> mapEventToState(Object event) async* {
    if (event is AddToCartEvent) {
      if (state.items.any((item) => item.product.id == event.product.id)) {
        // If the product is already in the cart, increase quantity
        yield CartState(
          items: state.items.map((item) {
            if (item.product.id == event.product.id) {
              return CartItem(
                product: item.product,
                quantity: item.quantity + 1,
              );
            } else {
              return item;
            }
          }).toList(),
        );
      } else {
        // If the product is not in the cart, add it with default quantity
        yield CartState(
          items: [
            ...state.items,
            CartItem(product: event.product, quantity: defaultQuantity),
          ],
        );
      }
    } else if (event is DecreaseQuantityEvent) {
      yield CartState(
        items: state.items
            .map((item) {
              if (item.product.id == event.productId) {
                // Decrease quantity, remove if it reaches zero
                return CartItem(
                  product: item.product,
                  quantity: item.quantity - 1,
                );
              } else {
                return item;
              }
            })
            .where((item) => item.quantity > 0)
            .toList(),
      );
    } else if (event is RemoveFromCartEvent) {
      yield CartState(
        items: state.items
            .where(
              (item) => item.product.id != event.productId,
            )
            .toList(),
      );
    } else if (event is ClearCartEvent) {
      yield CartState(items: []);
    }
  }

  double calculateTotalCost() {
    return state.totalCost;
  }
}

class AddToCartEvent {
  final Product product;

  AddToCartEvent(this.product);
}

class DecreaseQuantityEvent {
  final int productId;

  DecreaseQuantityEvent(this.productId);
}

class RemoveFromCartEvent {
  final int productId;

  RemoveFromCartEvent(this.productId);
}

class ClearCartEvent {}
