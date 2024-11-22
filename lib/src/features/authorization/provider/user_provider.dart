import 'package:chatremedy/src/model/user_data/user_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserProvider extends StateNotifier<UserData> {
  UserProvider() : super(UserData());

  void change(UserData role) {
    state = role;
  }

  void updateEmail(String newEmail) {
    final user = state.copyWith(user: state.user);
    user.user!.email = newEmail;
    state = user;
  }

  void likeCounsellor(
    String id,
  ) {
    final user = state.copyWith(user: state.user);

    user.user!.likes!.add(id);
    state = user;
  }

  void unlikeCounsellor(String id) {
    final user = state.copyWith(user: state.user);

    user.user!.likes!.remove(id);
    state = user;
  }
}

final userProvider =
    StateNotifierProvider<UserProvider, UserData>((ref) => UserProvider());
