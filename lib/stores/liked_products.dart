import 'package:bloc/bloc.dart';

class AddLikedProductEvent {
  final int productId;
  AddLikedProductEvent(this.productId);
}

class RemoveLikedProductEvent {
  final int productId;
  RemoveLikedProductEvent(this.productId);
}

class LikedProductsState {
  final List<int> likedProducts;
  LikedProductsState(this.likedProducts);
}

class LikedProductsBloc extends Bloc<dynamic, LikedProductsState> {
  LikedProductsBloc() : super(LikedProductsState([]));

  @override
  Stream<LikedProductsState> mapEventToState(dynamic event) async* {
    List<int> updatedLikedProducts = List.from(state.likedProducts);

    if (event is AddLikedProductEvent) {
      updatedLikedProducts.add(event.productId);
    } else if (event is RemoveLikedProductEvent) {
      updatedLikedProducts.remove(event.productId);
    }

    yield LikedProductsState(updatedLikedProducts);
  }
}
